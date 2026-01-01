##  Problem Statement

In India, agricultural commodity prices fluctuate across markets due to demand–supply variations, seasonality, and regional factors. While the **Minimum Support Price (MSP)** provides a baseline for farmer protection, actual market prices often deviate from MSP, making short-term decision-making difficult for farmers and traders.

Most existing agricultural price prediction systems rely on generic or limited datasets, ignore market-level variations, fail to define price units clearly, or continue to provide predictions even when historical data is insufficient. Such limitations reduce the reliability and real-world usability of these systems.

This project addresses these challenges by developing a **transparent, market-specific, MSP-aware agricultural price forecasting system** using real AGMARK data.


##  Aims and Objectives (Project Differentiation)

This project aims to distinguish itself from existing agricultural price prediction systems by focusing on the following key aspects:

- Use of **real AGMARK (Agmarket) market data** instead of synthetic or generic datasets  
- **Market–commodity specific forecasting** to capture localized price behavior  
- **Short-term price predictions** suitable for real mandi-level decisions  
- Clear and consistent **price unit interpretation (per quintal)**  
- Analysis of predicted prices **in relation to the Minimum Support Price (MSP)**  
- To explicitly identify and report insufficient historical data scenarios instead of generating unreliable predictions


# Agriculture-Price-Forecasting-of-Crops

## 📂 Data Cleaning

- **Notebook:** `01_data_cleaning.ipynb`

- **Description:**  
  This notebook contains all the steps performed to clean the raw dataset, including:  
  - Handling missing values using imputation or removal  
  - Correcting data formats and standardizing columns  
  - Outlier detection and treatment  
  - Other preprocessing steps to prepare the dataset for analysis  

- **Output:**  
  - A cleaned dataset (`cleaned_data.csv`) ready for profiling and model building  

- **Note:**  
  - The notebook is structured with clear markdown explanations for each step.  
  - This is the first step in the project workflow, preparing the data for further analysis and modeling.  

- **Guidelines to run the notebook:**  
  - Check the paths of the files and modify accordingly before executing  

---

## 📊 Data Profiling & Visualization

- **Notebook:** `02_data_profiling.ipynb`

- **Description:**  
  This notebook provides an exploratory analysis of the cleaned dataset, including:  
  - Summary statistics for each feature (mean, median, standard deviation, etc.)  
  - Visualizations to understand distributions, correlations, and trends  
  - Insights into data quality and potential relationships between variables  

- **Output:**  
  - Visual charts and tables that help understand the dataset and guide further analysis and model building  

- **Note:**  
  - All visualizations are created with clear markdown explanations.  
  - This step follows data cleaning and is essential for understanding the dataset before modeling.  

- **Guidelines to run the notebook:**  
  - Check the paths of the files and modify accordingly before executing  

---

## 📂 Model Building

- **Notebooks:**  
  - `XGBoost_Model.ipynb`  
  - `Random_Forest.ipynb`  
  - `LSTM_Model.ipynb`  
  - `Models_Evaluation.ipynb`

- **Description:**  
  These notebooks implement and evaluate multiple machine learning models to predict agricultural commodity prices:  
  - **XGBoost:** Gradient boosting-based model for fast and accurate predictions  
  - **Random Forest:** Ensemble of decision trees capturing non-linear patterns  
  - **LSTM:** Time-series model tested for sequential prediction (less suitable for this dataset)  
  - **Model Comparison:** Evaluates all models using metrics such as R², RMSE, and MAE to select the best model  

- **Output:**  
  - Final selected model: **Random Forest**  
  - Performance Metrics:  
    - R² Score: 0.949  
    - RMSE: 261.8  
    - MAE: 152.1  

- **Note:**  
  - The notebooks are structured with clear markdown explanations for each step  
  - The final model was chosen based on its accuracy, robustness, and computational efficiency  

- **Guidelines to run the notebooks:**  
  - Ensure all required libraries are installed 
  - Check file paths and modify if necessary before executing the notebooks  


---

## 📂 API Integration

- **Module:** `api/` (Backend Service)

- **Description:**  
  This module provides a RESTful API to serve agricultural commodity price predictions to the frontend application. The API performs the following tasks:  
  - Accepts user inputs such as **State, District, Market, Commodity, and Date**  
  - Applies the same preprocessing pipeline used during model training  
  - Loads the trained **Random Forest model** for inference  
  - Generates and returns predicted crop prices in a structured JSON format  

- **Endpoints:**  
  - `POST /predict`  
    - **Input:** State, District, Market, Commodity, Date  
    - **Output:** Predicted price value for the selected crop and market  

- **Output:**  
  - JSON response containing the predicted commodity price  
  - Informative error messages for invalid inputs or unsupported combinations  

- **Note:**  
  - The API acts as a bridge between the **Flutter frontend** and the **machine learning models**  
  - It ensures consistency by using the same feature engineering and preprocessing logic as model training  
  - For certain combinations, predictions are not returned when historical data is insufficient  

- **Guidelines to run the API:**  
  - Install required dependencies listed in `requirements.txt`  
  - Ensure the trained model files (`.pkl`) are available in the specified directory  
  - Run the API server using the provided entry file (e.g., `app.py` or `main.py`)
  
  
  ---
  
  ##📂 Frontend (User Interface)

- **Framework:** Flutter  
- **Architecture:** MVC pattern  

###  Description  
The frontend provides a clean and responsive user interface for the crop price forecasting system. It allows users to select crops, markets, and dates to view predicted prices in an easy-to-understand format.

###  Features  
- Crop and market selection using dropdowns  
- Predicted price display in **list** and **graph** views  
- Interactive charts for trend analysis  
- Mobile-friendly and responsive UI  
- Handles cases with insufficient or unavailable data gracefully


## ✅ Conclusions (Project Metrics)

The effectiveness and reliability of the proposed agricultural price forecasting system are validated through the following measurable project metrics:

- **Model Accuracy & Generalization**
  - Achieved high predictive performance with training scores of approximately **0.96** and testing scores of approximately **0.94**, indicating strong generalization and minimal overfitting.

- **Market–Commodity Level Precision**
  - Models are trained and evaluated on **specific market–commodity combinations**, resulting in improved localized prediction accuracy compared to generic models.

- **Short-Term Forecast Reliability**
  - Successfully generates **next-day and short-term price predictions**, making the outputs practically useful for mandi-level decision-making.

- **MSP-Relative Prediction Insight**
  - Predicted prices are analyzed relative to **Minimum Support Price (MSP)**, enabling classification of outcomes as **above, near, or below MSP** for informed decision support.

- **Data Adequacy Handling**
  - The system explicitly identifies scenarios with **insufficient historical data** and avoids unreliable predictions, improving overall model trustworthiness.

- **Price Unit Consistency**
  - All predictions maintain consistent **price units (per quintal)**, ensuring accurate interpretation and preventing unit-based ambiguity.

- **Model Robustness**
  - Performance consistency across multiple algorithms (**Random Forest, XGBoost, and LSTM**) demonstrates robustness to different learning approaches.

- **Scalability**
  - The framework supports extension to additional commodities, markets, and time periods without fundamental changes to the modeling pipeline.

Overall, these metrics confirm that the project delivers a **reliable, MSP-aware, and market-focused agricultural price forecasting system** with strong real-world applicability.
