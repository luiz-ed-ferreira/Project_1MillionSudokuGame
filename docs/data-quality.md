# Data Quality Validation — Sudoku Intelligence

## 1. Overview

This document describes the data quality validation process applied to the Sudoku dataset before its transformation from the Bronze layer to the Silver layer.

The dataset contains **1,000,000 Sudoku puzzles**, with each record consisting of an incomplete puzzle (`quizzes`) and its corresponding completed solution (`solutions`).

The validation process was implemented using **PySpark and Spark SQL** in Databricks, following the Medallion Architecture.

## 2. Data Source

| Property | Description |
|---|---|
| Source file | `sudoku.csv` |
| Source volume | `workspace.sudoku_bronze.raw_files` |
| Bronze table | `workspace.sudoku_bronze.raw_games` |
| Storage format | Delta Lake |
| Total records | 1,000,000 |
| Processing engine | Apache Spark 4.2.0 |
| Validation notebook | `03_silver_validation` |

The Bronze table preserves the original puzzle and solution strings, together with ingestion metadata (`ingestion_timestamp` and `source_file`).

## 3. Data Quality Rules

### 3.1 Completeness

Verify that neither `quizzes` nor `solutions` contains null values.

**Acceptance criterion:** Both fields must be non-null.

### 3.2 Structural Integrity

Verify that both fields contain exactly 81 characters, representing a 9 × 9 Sudoku grid.

**Acceptance criterion:** `length(quizzes) = 81` and `length(solutions) = 81`.

### 3.3 Character Validation

Validate the permitted characters using regular expressions.

- `quizzes`: digits from 0 to 9, where 0 represents an empty cell.
- `solutions`: digits from 1 to 9, with no empty cells.

**Acceptance criterion:** Both fields must match their corresponding patterns.

### 3.4 Duplicate Detection

Group records by `quizzes` to identify puzzles appearing more than once.

**Acceptance criterion:** Each puzzle must appear only once.

### 3.5 Puzzle–Solution Consistency

Compare the 81 positions of each puzzle against its solution.

For every non-zero digit in `quizzes`, the corresponding position in `solutions` must contain the same digit.

**Acceptance criterion:** No pre-filled puzzle digit may conflict with its solution.

### 3.6 Mathematical Sudoku Validation

Validate each completed solution against the fundamental Sudoku rules:

- **Rows:** Each of the nine rows must contain nine distinct digits.
- **Columns:** Each of the nine columns must contain nine distinct digits.
- **3 × 3 boxes:** Each of the nine boxes must contain nine distinct digits.

The implementation uses native Spark SQL higher-order functions, including `forall`, `transform`, `sequence`, `array_distinct`, and `element_at`.

**Acceptance criterion:** Every row, column, and box must contain all digits from 1 to 9 exactly once.

## 4. Validation Results

| Validation | Records failing |
|---|---:|
| Null values | 0 |
| Invalid board length | 0 |
| Invalid characters | 0 |
| Duplicate puzzle groups | 0 |
| Puzzle–solution inconsistencies | 0 |
| Invalid mathematical solutions | 0 |
| **Total records analyzed** | **1,000,000** |

**Result: 100% of records passed all implemented validation rules.**

No invalid records or duplicate puzzle groups were identified. Therefore, no records require exclusion based on the current validation criteria.

## 5. Technical Implementation

The validation workflow uses PySpark DataFrame transformations and Spark SQL expressions.

Key techniques include:

- Aggregations to measure missing and structurally invalid records.
- Regular expressions to enforce permitted character patterns.
- Grouping and counting to detect duplicated puzzles.
- Position-by-position comparison of puzzle clues and completed solutions.
- Array transformations and higher-order SQL functions to verify mathematical constraints.

These operations are executed through the Apache Spark engine, avoiding row-by-row Python UDF processing.

## 6. Known Limitations

Although every supplied solution satisfies the mathematical Sudoku rules and preserves the original clues, the current process does not verify whether each incomplete puzzle has **exactly one valid solution**.

Solution uniqueness would require a separate solving or search procedure.

Additionally, the validation confirms correctness against the defined rules but does not assign puzzle difficulty or measure computational solving complexity.

These characteristics will be addressed separately during feature engineering and model development, where appropriate.

## 7. Silver Layer Preparation

The validated dataset will be persisted as:

`workspace.sudoku_silver.validated_games`

The Silver table is planned to include:

| Column | Description |
|---|---|
| `quizzes` | Original incomplete puzzle |
| `solutions` | Validated completed solution |
| `ingestion_timestamp` | Original ingestion timestamp |
| `source_file` | Original source file |
| `valid_solution` | Mathematical validation result |
| `empty_cells` | Number of empty cells in the puzzle |
| `given_cells` | Number of pre-filled cells in the puzzle |

The Bronze table will remain unchanged to preserve the source data and support reproducibility.

## 8. Conclusion

The data quality assessment confirmed that all 1,000,000 records satisfy the implemented completeness, structural integrity, uniqueness, consistency, and mathematical validation rules.

The dataset is ready to proceed to the Silver layer under the current acceptance criteria.

Subsequent pipeline stages will focus on feature engineering, exploratory analysis, and machine learning for Sudoku complexity prediction.