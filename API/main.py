from fastapi import FastAPI, Query
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import joblib
import numpy as np
import pandas as pd

# ---------------- APP ----------------
app = FastAPI(title="Agriculture Price Prediction API")

# ---------------- CORS (REQUIRED FOR CHROME) ----------------
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],        # allow Flutter Web (Chrome)
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ---------------- LOAD MODEL & DATA ----------------
model = joblib.load("model.pkl")
encoders = joblib.load("encoders.pkl")

# Load dataset for dropdowns
df = pd.read_csv("data.csv")

# ---------------- FEATURE ORDER ----------------
FEATURE_ORDER = [
    "state",
    "district_name",
    "market_name",
    "commodity",
    "day",
    "month",
    "year",
    "day_of_week",
    "lag_1",
    "lag_7",
    "lag_14",
    "lag_30",
    "rolling_mean_7",
    "rolling_mean_14",
]

# ---------------- INPUT SCHEMA ----------------
class PredictionInput(BaseModel):
    state: str
    district_name: str
    market_name: str
    commodity: str
    day: int
    month: int
    year: int
    day_of_week: int
    lag_1: float
    lag_7: float
    lag_14: float
    lag_30: float
    rolling_mean_7: float
    rolling_mean_14: float

# ---------------- ENCODING ----------------
def encode_input(data_dict):
    row = []
    for col in FEATURE_ORDER:
        value = data_dict[col]
        if col in encoders:
            le = encoders[col]
            if value not in le.classes_:
                raise ValueError(f"Invalid value '{value}' for {col}")
            value = le.transform([value])[0]
        row.append(value)
    return np.array(row).reshape(1, -1)

# ---------------- BASIC ----------------
@app.get("/")
def home():
    return {"status": "API running"}

# ---------------- CASCADING DROPDOWNS ----------------
@app.get("/dropdown/states")
def get_states():
    return sorted(df["state"].dropna().unique().tolist())

@app.get("/dropdown/districts")
def get_districts(state: str = Query(...)):
    return sorted(
        df[df["state"] == state]["district_name"]
        .dropna()
        .unique()
        .tolist()
    )

@app.get("/dropdown/markets")
def get_markets(state: str = Query(...), district: str = Query(...)):
    return sorted(
        df[
            (df["state"] == state) &
            (df["district_name"] == district)
        ]["market_name"]
        .dropna()
        .unique()
        .tolist()
    )

@app.get("/dropdown/commodities")
def get_commodities(
    state: str = Query(...),
    district: str = Query(...),
    market: str = Query(...),
):
    return sorted(
        df[
            (df["state"] == state) &
            (df["district_name"] == district) &
            (df["market_name"] == market)
        ]["commodity"]
        .dropna()
        .unique()
        .tolist()
    )

# ---------------- PREDICTION ----------------
@app.post("/predict")
def predict_price(data: PredictionInput, days: int = Query(7, ge=1, le=30)):
    """
    Predict modal prices for 'days' number of days (default 7).
    """
    try:
        data_dict = data.dict()
        predictions = []

        lag_1 = data_dict["lag_1"]
        lag_7 = data_dict["lag_7"]
        lag_14 = data_dict["lag_14"]
        lag_30 = data_dict["lag_30"]
        rolling_7 = data_dict["rolling_mean_7"]
        rolling_14 = data_dict["rolling_mean_14"]

        for _ in range(days):
            data_dict.update({
                "lag_1": lag_1,
                "lag_7": lag_7,
                "lag_14": lag_14,
                "lag_30": lag_30,
                "rolling_mean_7": rolling_7,
                "rolling_mean_14": rolling_14,
            })

            X = encode_input(data_dict)
            pred = float(model.predict(X)[0])
            predictions.append(round(pred, 2))

            lag_30 = lag_30 - lag_7 + pred
            lag_14 = lag_14 - lag_1 + pred
            lag_7 = lag_7 - lag_1 + pred
            lag_1 = pred
            rolling_7 = (rolling_7 * 6 + pred) / 7
            rolling_14 = (rolling_14 * 13 + pred) / 14

            data_dict["day"] += 1
            data_dict["day_of_week"] = (data_dict["day_of_week"] % 7) + 1

            if data_dict["day"] > 30:
                data_dict["day"] = 1
                data_dict["month"] += 1
                if data_dict["month"] > 12:
                    data_dict["month"] = 1
                    data_dict["year"] += 1

        return {"status": "success", "predictions": predictions}

    except Exception as e:
        return {"status": "error", "message": str(e)}