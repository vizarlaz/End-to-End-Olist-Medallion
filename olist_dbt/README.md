# End-to-End Olist Data Engineering Project

Modern Data Engineering Pipeline using Medallion Architecture, PostgreSQL, Apache Airflow, dbt, Docker, and Metabase.

---

# Project Overview

This project demonstrates a complete end-to-end data engineering pipeline built using the Brazilian E-Commerce Public Dataset by Olist.

The pipeline implements Medallion Architecture (Bronze, Silver, Gold) to transform raw transactional data into business-ready analytics and executive dashboards.

The project focuses on:

- scalable data architecture
- orchestration and automation
- SQL transformation
- analytics engineering
- data quality validation
- dashboard reporting

---

# Business Problem

E-commerce stakeholders need reliable analytics to monitor:

- revenue growth
- customer retention
- product performance
- payment behavior
- operational metrics

Raw transactional data is often fragmented, inconsistent, and difficult to consume directly for business analytics.

The objective of this project is to build a scalable analytics platform that transforms raw transactional data into trusted business insights.

---

# Architecture

## Medallion Architecture

```text
Raw CSV Dataset
        ↓
Bronze Layer
(Raw Ingestion)
        ↓
Silver Layer
(Cleaning & Transformation)
        ↓
Gold Layer
(Business KPIs)
        ↓
Metabase Dashboard
```

---

# Tech Stack

| Category | Tools |
|---|---|
| Programming | Python |
| Database | PostgreSQL |
| Orchestration | Apache Airflow |
| Transformation | dbt |
| Containerization | Docker |
| Dashboard | Metabase |
| Query Language | SQL |
| Dataset | Olist Brazilian E-Commerce Dataset |

---

# Dataset

Dataset used:

Brazilian E-Commerce Public Dataset by Olist

Dataset contains:

- customers
- orders
- products
- order items
- payments
- reviews
- sellers
- geolocation

Main files used in this project:

```text
olist_orders_dataset.csv
olist_customers_dataset.csv
olist_order_items_dataset.csv
olist_order_payments_dataset.csv
olist_products_dataset.csv
```

---

# Project Structure

```text
end-to-end-olist-medallion-project/
│
├── dags/
├── dashboard/
├── data/
│   ├── raw/
│   ├── bronze/
│   ├── silver/
│   └── gold/
│
├── dbt/
├── docker/
├── notebooks/
├── scripts/
├── sql/
│
├── docker-compose.yml
├── requirements.txt
├── README.md
└── .gitignore
```

---

# Medallion Architecture Layers

# Bronze Layer

The Bronze layer stores raw append-only source data.

Purpose:

- preserve raw source data
- maintain traceability
- support auditing and reprocessing

Characteristics:

- append-only ingestion
- minimal transformation
- metadata tracking

Metadata columns:

```text
ingestion_time
source_file
batch_id
```

Bronze tables:

```text
bronze.orders
bronze.customers
bronze.products
bronze.order_items
bronze.payments
```

---

# Silver Layer

The Silver layer performs:

- data cleaning
- standardization
- validation
- deduplication
- business rule enforcement
- analytical transformation

Key transformations:

- NULL handling
- duplicate removal
- payment aggregation
- standardized city/state naming
- invalid record filtering
- revenue normalization

Silver tables:

```text
silver.customers_clean
silver.products_clean
silver.orders_clean
silver.payments_clean
silver.sales_clean
```

---

# Gold Layer

The Gold layer contains business-ready KPI tables optimized for analytics and dashboarding.

Gold tables:

```text
gold.daily_sales
gold.monthly_revenue
gold.top_products
gold.payment_performance
gold.customer_lifetime_value
gold.customer_retention
```

Business KPIs:

- total revenue
- total orders
- average order value
- top products
- payment performance
- customer lifetime value
- customer retention rate

---

# Data Pipeline Flow

```text
CSV Dataset
    ↓
Python Ingestion
    ↓
Bronze Layer
    ↓
Silver Transformation
    ↓
Gold Aggregation
    ↓
dbt Testing
    ↓
Airflow Orchestration
    ↓
Metabase Dashboard
```

---

# Airflow Orchestration

Apache Airflow is used for pipeline orchestration.

Pipeline stages:

```text
bronze_ingestion
        ↓
silver_transform
        ↓
gold_aggregation
        ↓
validation
```

Features:

- scheduled execution
- dependency management
- retry handling
- centralized monitoring
- task logging

---

# dbt Transformation Layer

dbt is used for:

- SQL model management
- dependency tracking
- lineage visualization
- automated testing
- modular transformation

Examples:

- silver_sales_clean
- gold_daily_sales
- gold_customer_retention

dbt tests implemented:

- not_null
- unique
- data validation

---

# Data Quality Validation

Validation checks implemented:

| Validation | Purpose |
|---|---|
| Null Check | Ensure critical fields are not null |
| Duplicate Check | Prevent duplicate aggregation |
| Revenue Validation | Detect invalid revenue |
| Referential Integrity | Ensure valid relationships |
| Freshness Check | Validate latest ingestion |
| Volume Check | Detect row anomalies |

Example validation:

```sql
SELECT COUNT(*)
FROM silver.sales_clean
WHERE total_order_value IS NULL;
```

---

# Dashboard & Analytics

Dashboard is built using Metabase and consumes only Gold Layer tables.

Dashboard pages:

## Executive Overview

- Total Revenue
- Total Orders
- Unique Customers
- Average Order Value
- Revenue Trend

## Product Analytics

- Top Products
- Product Revenue
- Category Performance

## Customer Analytics

- Customer Lifetime Value
- Retention Trend
- Repeat Customers

## Payment Analytics

- Payment Distribution
- Payment Revenue Contribution

---

# Dashboard Screenshots

## Executive Dashboard

Add screenshot:

```text
dashboard/screenshots/dashboard.png
```

---

# Airflow DAG

Add screenshot:

```text
dashboard/screenshots/airflow_dag.png
```

---

# dbt Lineage

Add screenshot:

```text
dashboard/screenshots/dbt_lineage.png
```

---

# How to Run

# 1. Clone Repository

```bash
git clone <repository_url>
cd end-to-end-olist-medallion-project
```

---

# 2. Start Docker Containers

```bash
docker compose up -d
```

---

# 3. Verify Containers

```bash
docker ps
```

Containers expected:

```text
postgres
airflow
metabase
```

---

# 4. Run dbt Models

```bash
dbt run
```

---

# 5. Run dbt Tests

```bash
dbt test
```

---

# 6. Generate dbt Documentation

```bash
dbt docs generate
```

---

# 7. Serve dbt Documentation

```bash
dbt docs serve
```

---

# 8. Access Applications

## Airflow

```text
http://localhost:8080
```

## Metabase

```text
http://localhost:3000
```

---

# Key Engineering Features

This project demonstrates:

- Medallion Architecture
- End-to-End ETL Pipeline
- Data Warehouse Modeling
- Modern Data Stack
- Airflow Orchestration
- dbt Transformation
- Automated Data Testing
- Dockerized Environment
- BI Dashboard Integration
- Data Quality Validation

---

# Challenges Solved

## Revenue Aggregation Issues

Handled NULL propagation issues using:

```sql
COALESCE(price, 0)
```

## Duplicate Payment Rows

Implemented payment aggregation logic to prevent revenue inflation.

## Data Quality Problems

Implemented validation checks for:

- duplicates
- nulls
- invalid revenue
- referential integrity

---

# Future Improvements

Potential future enhancements:

- Incremental loading
- CDC pipeline
- Cloud deployment
- CI/CD integration
- Slack alerting
- Great Expectations integration
- Data lake architecture
- Kafka streaming pipeline
- Partitioned tables
- SCD Type 2 implementation

---

# Learning Outcomes

This project helped improve skills in:

- SQL transformation
- Data modeling
- ETL pipeline design
- Workflow orchestration
- Analytics engineering
- Data validation
- Business KPI development
- Dashboard reporting
- Modern data stack implementation

---

# Author

Zar

Programmer focused on:

- Data Engineering
- Analytics Engineering
- Backend Development
- Modern Data Stack

---

# License

This project is for educational and portfolio purposes.
