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
