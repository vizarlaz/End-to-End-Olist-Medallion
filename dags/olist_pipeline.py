from airflow import DAG
from airflow.providers.standard.operators.bash import BashOperator
from datetime import datetime
from datetime import timedelta


default_args = {
    "owner": "vizarr",
    "start_date": datetime(2026, 1, 1),
    "retries": 1,
    

}



with DAG(
    dag_id="olist_medallion_pipeline",
    default_args=default_args,
    schedule="@daily",
    catchup=False,
) as dag:
    
    bronze_ingestion = BashOperator(
        task_id="bronze_ingestion",
        bash_command="""
        python /opt/airflow/scripts/ingestion/ingest_bronze.py
        """
    )

    silver_transform = BashOperator(
        task_id="silver_transform",
        bash_command="""
        PGPASSWORD=admin123 psql -U postgres -d olist_dw \
        -f /opt/airflow/sql/silver/silver_customers_clean.sql

        PGPASSWORD=admin123 psql -U postgres -d olist_dw \
        -f /opt/airflow/sql/silver/silver_products_clean.sql

        PGPASSWORD=admin123 psql -U postgres -d olist_dw \
        -f /opt/airflow/sql/silver/silver_orders_clean.sql

        PGPASSWORD=admin123 psql -U postgres -d olist_dw \
        -f /opt/airflow/sql/silver/silver_payments_clean.sql

        PGPASSWORD=admin123 psql -U postgres -d olist_dw \
        -f /opt/airflow/sql/silver/silver_sales_clean.sql
        """
    )

    gold_aggregation = BashOperator(
        task_id="gold_aggregation",
        bash_command="""
        PGPASSWORD=admin123 psql -U postgres -d olist_dw \
        -f /opt/airflow/sql/gold/gold_daily_sales.sql

        PGPASSWORD=admin123 psql -U postgres -d olist_dw \
        -f /opt/airflow/sql/gold/gold_monthly_revenue.sql

        PGPASSWORD=admin123 psql -U postgres -d olist_dw \
        -f /opt/airflow/sql/gold/gold_top_products.sql

        
        PGPASSWORD=admin123 psql -U postgres -d olist_dw \
        -f /opt/airflow/sql/gold/gold_customer_lifetime_value.sql

        PGPASSWORD=admin123 psql -U postgres -d olist_dw \
        -f /opt/airflow/sql/gold/gold_payment_performance.sql

        PGPASSWORD=admin123 psql -U postgres -d olist_dw \
        -f /opt/airflow/sql/gold/gold_customer_retention.sql
        """
    )

    bronze_ingestion >> silver_transform >> gold_aggregation
