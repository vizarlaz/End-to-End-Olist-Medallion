import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv
import os
from datetime import datetime
import uuid

load_dotenv()

db_user_product = os.getenv("DB_USER")
db_password_product = os.getenv("DB_PASSWORD")
db_host_product = os.getenv("DB_HOST")
db_port_product = os.getenv("DB_PORT")
db_name_product = os.getenv("DB_NAME")

DATABASE_URL = f"postgresql://{db_user_product}:{db_password_product}@{db_host_product}:{db_port_product}/{db_name_product}"
engine = create_engine(DATABASE_URL)

FILE_PATH = "data/raw/olist_products_dataset.csv"

def ingest_products():
    print("Reading CSV...")
    df = pd.read_csv(FILE_PATH)
    print(f"Rows found: {len(df)}")


    df["ingestion_time"] = datetime.now()
    df["source_file"] = "olist_products_dataset.csv"
    df["batch_id"] = str(uuid.uuid4())

    print("Loading to bronze.orders...")

    df.to_sql(
        name="products",
        con=engine,
        schema="bronze",
        if_exists="append",
        index=False,
        method="multi"
    )

    print("Ingestion completed successfully!")

if __name__ == "__main__":
    ingest_products()