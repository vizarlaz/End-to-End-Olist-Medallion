import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv
import os
from datetime import datetime
import uuid

#load env
load_dotenv()

dbuser = os.getenv("DB_USER")
dbpassword = os.getenv("DB_PASSWORD")
dbhost = os.getenv("DB_HOST")
dbport = os.getenv("DB_PORT")
dbname = os.getenv("DB_NAME")

DATABASE_URL = f"postgresql://{dbuser}:{dbpassword}@{dbhost}:{dbport}/{dbname}"
engine = create_engine(DATABASE_URL)

#file path
FILE_PATH = "data/raw/olist_orders_dataset.csv"

def ingest__orders():
    print("Reading CSV...")

    df = pd.read_csv(FILE_PATH)

    # Metadata
    df["ingestion_time"] = datetime.now()
    df["source_file"] = "olist_orders_dataset.csv"
    df["batch_id"] = str(uuid.uuid4())

    print("Loading to bronze.orders....")

    df.to_sql(
        name="orders",
        con=engine,
        schema="bronze",
        if_exists="append",
        index=False,
        method="multi"
    )

    print("Ingestion completed successfully!")

if __name__ == "__main__":
    ingest__orders()