# 🌾 Agriculture Price Forecasting of Crops

A machine learning–based system to forecast short-term agricultural commodity prices using real-world AGMARK data, with insights interpreted relative to the Minimum Support Price (MSP).

---

## Problem Statement

In India, agricultural commodity prices fluctuate across markets due to demand–supply dynamics, seasonality, and regional factors. Although the **Minimum Support Price (MSP)** acts as a protective benchmark for farmers, actual market prices frequently deviate from MSP, making short-term selling and planning decisions challenging.

Most existing agricultural price prediction systems rely on generic or limited datasets, overlook market-level variations, lack clarity in price unit interpretation, or continue to generate predictions even when historical data is insufficient. These limitations reduce the reliability, transparency, and real-world applicability of such systems.

This project addresses these challenges by developing a **transparent, market-specific, MSP-aware agricultural price forecasting system** using real-world **AGMARK (Agmarket) data**.

---

## Aims and Objectives (Project Differentiation)

This project distinguishes itself from conventional agricultural price prediction systems through the following objectives:

- Utilization of **real AGMARK (Agmarket) market data** instead of synthetic or generic datasets  
- **Market–commodity specific forecasting** to capture localized price behavior  
- Generation of **short-term price predictions** suitable for real mandi-level decisions  
- Clear and consistent **price unit interpretation (per quintal)**  
- Analysis of predicted prices **relative to the Minimum Support Price (MSP)**  
- Explicit identification and reporting of **insufficient historical data scenarios** instead of producing unreliable predictions  

---

## 📂 Data Cleaning

- **Notebook:** `01_data_cleaning.ipynb`

- **Description:**  
  Performs comprehensive preprocessing of raw AGMARK data, including:
  - Handling missing values using imputation or removal  
  - Standardizing data formats and column names  
  - Outlier detection and treatment  
  - Preparing the dataset for profiling and modeling  

- **Output:**  
  - Cleaned dataset: `cleaned_data.csv`

- **Note:**  
  - Each step is documented with markdown explanations  

---

## 📊 Data Profiling & Visualization

- **Notebook:** `02_data_profiling.ipynb`

- **Description:**  
  Exploratory data analysis including:
  - Summary statistics (mean, median, standard deviation)  
  - Trend, distribution, and correlation visualizations  
  - Data quality and feature relationship insights  

- **Output:**  
  - Visual charts and analytical insights for model guidance  

---

## Model Building

- **Notebooks:**  
  - `XGBoost_Model.ipynb`  
  - `Random_Forest.ipynb`  
  - `LSTM_Model.ipynb`  
  - `Models_Evaluation.ipynb`

- **Models Evaluated:**  
  - **XGBoost:** High-performance gradient boosting regression  
  - **Random Forest:** Ensemble model capturing non-linear patterns  
  - **LSTM:** Time-series model tested for sequential learning  

- **Final Selected Model:** **Random Forest**

- **Performance Metrics:**  
  - R² Score: **0.949**  
  - RMSE: **261.8**  
  - MAE: **152.1**

---

## Model Selection Rationale

- Agricultural price data exhibits **non-linear and market-dependent behavior**
- **Random Forest** demonstrated superior robustness to noise and missing values
- Achieved the best balance of **accuracy, generalization, and stability**
- **XGBoost** showed competitive performance but was more sensitive to tuning
- **LSTM** was less effective due to fragmented market–commodity time series

### Why ARIMA Was Not Used
- Requires strict **stationarity and linearity assumptions**
- AGMARK data contains **short, irregular, and discontinuous time series**
- Manual parameter tuning for each market–commodity pair is not scalable
- ML models provided better robustness and real-world suitability

---

## API Integration

- **Module:** `api/`

- **Description:**  
  RESTful API serving predictions to the frontend:
  - Accepts **State, District, Market, Commodity, Date**
  - Applies training-time preprocessing
  - Loads trained Random Forest model
  - Returns predictions in JSON format

- **Endpoint:**  
  - `POST /predict`

- **Note:**  
  - Avoids predictions for insufficient-data combinations  

---

## Frontend (Flutter Application)

- **Framework:** Flutter  
- **Architecture:** MVC  

### Features
- Crop and market selection via dropdowns  
- Predicted price display in **list** and **graph** views  
- Interactive trend visualization  
- Mobile-responsive design  
- Graceful handling of unavailable data  

---

## Conclusions (Project Metrics)

- **Model Accuracy & Generalization**
  - Training ≈ **0.96**, Testing ≈ **0.94** (minimal overfitting)

- **Market–Commodity Precision**
  - Localized modeling improves real-world accuracy

- **Short-Term Forecast Reliability**
  - Accurate next-day and short-term predictions

- **MSP-Relative Insights**
  - Predictions categorized as **above, near, or below MSP**

- **Data Adequacy Handling**
  - Explicit identification of insufficient historical data

- **Price Unit Consistency**
  - All predictions reported **per quintal**

---

## Future Scope

- Integration of weather, rainfall, and demand indicators  
- Seasonal and MSP-policy impact analysis  
- Expansion to more commodities and markets  
- Real-time data ingestion and alerts  
