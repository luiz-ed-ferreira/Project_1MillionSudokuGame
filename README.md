# Project One Million Sudoku Game - Kaggle Dataset

### Project overview

> An end-to-end Data Engineering and Machine Learning project leveraging Databricks, Apache Spark, PySpark, and MLflow to process and analyze a dataset containing one million Sudoku puzzles.

>The project aims to build a scalable data pipeline using the Medallion Architecture (Bronze, Silver, and Gold), perform exploratory data analysis (EDA), engineer relevant features, and develop Machine Learning models to predict Sudoku puzzle complexity.

>The workflow incorporates Cookiecutter for standardized project organization, Delta Lake for reliable data management, Spark MLlib for model development, and MLflow for experiment tracking and model evaluation.

>By integrating GitHub with Databricks, the project also explores reproducibility, version control, and MLOps best practices, demonstrating a complete workflow from raw data ingestion to predictive modeling.

### Status & improvements

In progress

- [x] **Project Setup:** Organize the repository using Cookiecutter and configure the development environment.
- [x] **GitHub & Databricks Integration:** Connect the GitHub repository to Databricks Free Edition.
- [x] **Data Ingestion:** Import the Kaggle dataset using PySpark and create the Bronze layer.
- [x] **Data Cleaning & Validation:** Perform structural and mathematical Sudoku validation and create the Silver layer.
- [x] **Exploratory Data Analysis (EDA):** Analyze Sudoku patterns, distributions, and dataset characteristics.
- [x] **Feature Engineering:** Extract relevant puzzle features and create the Gold layer.
- [ ] **Target Generation:** Implement a Sudoku solver to generate complexity metrics and difficulty labels for supervised learning.
- [ ] **Regression Modeling:** Train and compare regression models to predict Sudoku solving complexity using Spark MLlib.
- [ ] **Classification Modeling:** Train and compare classification models to predict Sudoku difficulty levels (Easy, Medium, Hard) using Spark MLlib.
- [ ] **Regression Evaluation:** Evaluate models using MAE, RMSE, and R².
- [ ] **Classification Evaluation:** Evaluate models using Accuracy, Precision, Recall, F1-score, and Confusion Matrix.
- [ ] **Model Comparison & Selection:** Compare model performance and select the best approaches for regression and classification.
- [ ] **MLOps & Experiment Tracking:** Track experiments, metrics, parameters, and model artifacts using MLflow.
- [ ] **Pipeline Automation:** Configure and execute workflows using Databricks Jobs, subject to Free Edition limitations.

### Data Quality

The dataset contains 1,000,000 Sudoku puzzles. All records passed structural, consistency, duplicate, and mathematical solution validation checks.

For the complete validation methodology and results, see [Data Quality Documentation](docs/data-quality.md).

### Gold Layer — Feature Engineering

The Gold Layer has been successfully implemented using PySpark and Delta Lake.

- Processed 1,000,000 validated Sudoku puzzles.
- Engineered 7 numerical features describing puzzle structure and candidate availability.
- Analyzed clue distribution across rows, columns, and 3x3 boxes.
- Implemented candidate analysis using native Spark SQL functions.
- Validated all features with zero null values and zero invalid records.
- Cross-validated candidate-based calculations against a Python reference implementation.
- Persisted the final dataset in `workspace.sudoku_gold.game_features`.

### Project Architecture

```text
Project_1MillionSudokuGame/
│
├── data/
│   ├── external/
│   │   └── .gitkeep
│   ├── interim/
│   │   └── .gitkeep
│   ├── processed/
│   │   └── .gitkeep
│   └── raw/
│       └── .gitkeep
│
├── docs/
│   ├── docs/
│   │   ├── getting-started.md
│   │   └── index.md
│   ├── .gitkeep
│   ├── data-quality.md
│   └── mkdocs.yml
│
├── models/
│   └── .gitkeep
│
├── notebooks/
│   ├── 01_environment_validation.ipynb
│   ├── 02_bronze_ingestion.ipynb
│   ├── 03_silver_validation.ipynb
│   └── 04_gold_feature_engineering.ipynb
│
├── references/
│   └── .gitkeep
│
├── reports/
│   ├── figures/
│   │   └── .gitkeep
|   ├── query_sudoku_bronze_raw_games.sql
│   └── .gitkeep
│
├── sudoku_intelligence/
│   ├── modeling/
│   │   ├── __init__.py
│   │   ├── predict.py
│   │   └── train.py
│   ├── __init__.py
│   ├── config.py
│   ├── dataset.py
│   ├── features.py
│   └── plots.py
│
├── .gitignore
├── Makefile
├── pyproject.toml
├── README.md
└── requirements.txt
```

### Directory Overview

| Directory | Description |
|---|---|
| `data/` | Data storage structure for raw, external, intermediate, and processed datasets. |
| `docs/` | Technical documentation managed with MkDocs. |
| `models/` | Directory reserved for trained model artifacts. |
| `notebooks/` | Jupyter notebooks for EDA, feature engineering, and experimentation. |
| `references/` | Reference materials and supporting documentation. |
| `reports/` | Generated reports, visualizations, and project results. |
| `sudoku_intelligence/` | Main Python package containing data processing, feature engineering, modeling, and visualization modules. |

**Note:** Datasets, virtual environments, credentials, and generated model artifacts are excluded from Git version control through `.gitignore`. Only the directory structure and project source files are maintained in the repository.

### Prerequisites & used softwares

- WSL Linux/Ubuntu for Windows 11 System
- Python version 3.12.3
- Cookiecutter 2.7.1
- Databricks Free Edition
- Delta Lake

> Attention! Consult the requirements.txt file for more information about python libraries used.

### Collaborators

<table>
  <tr>
    <td align="center">
      <a href="https://github.com/luiz-ed-ferreira" title="Luiz Eduardo">
        <img src="https://avatars3.githubusercontent.com/u/145693602" width="100px;" alt="Foto do Iuri Silva no GitHub"/><br>
        <sub>
          <b>Luiz Eduardo</b>
        </sub>
      </a>
    </td>
</table>
