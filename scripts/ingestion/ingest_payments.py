import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv
import os
from datetime import datetime
import uuid

load_dotenv()

db_user_payments = os.getenv("DB_USER")
db_pw_payments = os.getenv("DB_PASSWORD")
db_host_payments = os.getenv("DB_HOST")
db_port_payments = os.getenv("DB_PORT")
db_name_payments = os.getenv("DB_NAME")

DATABASE_URL = f"postgresql://{db_user_payments}:{db_pw_payments}@{db_host_payments}:{db_port_payments}/{db_name_payments}"
engine = create_engine(DATABASE_URL)

FILE_PATH = "data/raw/olist_order_payments_dataset.csv"

def ingest_payments():
    print("Reading CSV...")
    df = pd.read_csv(FILE_PATH)
    print(f"Rows found: {len(df)}")

    df["ingestion_time"] = datetime.now()
    df["source_file"] = "olist_order_payments_dataset.csv"
    df["batch_id"] = str(uuid.uuid4())

    print("Loading to bronze.payments...")

    df.to_sql(
        name="payments",
        con=engine,
        schema="bronze",
        if_exists="append",
        index=False,
        method="multi"
    )

    print("Ingestion completed successfully!")

if __name__ == "__main__":
    ingest_payments()