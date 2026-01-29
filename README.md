# 📊 Sales Analytics dbt Project 
Medallion Architecture on Databricks with CI/CD

## 🛠️ Technologies Used ##
- dbt
- Databricks
- Apache Spark SQL
- Git & GitHub
- GitHub Actions (CI/CD)
- Medallion Architecture

## 📌 Project Overview ##

This project demonstrates an end-to-end Sales analytics pipeline built using dbt on Databricks, following the Medallion Architecture (Bronze, Silver, Gold).
It showcases how raw source data is incrementally transformed into analytics-ready datasets with strong emphasis on data quality, documentation, lineage, and CI/CD automation.

*The project uses sample data to simulate real-world enterprise analytics workflows.*

### 🏗️ Architecture Overview (Medallion Pattern) ###

The pipeline is structured into three logical layers:

🥉 Bronze Layer – Raw Ingestion
- Ingests raw data from source systems
- Minimal transformations
- Preserves source-level granularity

🥈 Silver Layer 
- Business Logic & Cleansing 
- Applies data cleansing and standardization
- Joins multiple Bronze entities

🥇 Gold Layer – Analytics-Ready Models 
- Produces curated, business-facing datasets
- Optimized for reporting and downstream analytics
- Represents a single source of truth

### 🧪 Data Quality & Testing ###
Data quality is enforced using dbt tests, including:
- not_null
- unique
- Relationship tests
- Custom generic tests (e.g. non-negative value validation)

*These tests prevent invalid data from propagating across layers and are executed as part of the pipeline.*

### 📚 Documentation & Lineage ###

dbt Docs is used to auto-generate:
- Model and column-level documentation
- Test visibility
- End-to-end lineage graph
Documentation is derived directly from code to ensure it remains accurate and up to date

