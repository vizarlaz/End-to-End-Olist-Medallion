import sys

sys.path.append('/opt/airflow')

import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv
import os
from datetime import datetime
import uuid

from scripts.utils.logging_config import logger as logging
from config import TABLE_CONFIG

load_dotenv()



DB_USER = os.getenv("DB_USER", "airflow")
DB_PASSWORD = os.getenv("DB_PASSWORD", "airflow")
DB_HOST = os.getenv("DB_HOST", "postgres")
DB_PORT = os.getenv("DB_PORT", "5432")
DB_NAME = os.getenv("DB_NAME", "olist_dw")

DATABASE_URL = (
    f"postgresql+psycopg2://"
    f"{DB_USER}:{DB_PASSWORD}"
    f"@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

logging.info(f"DATABASE_URL = {DATABASE_URL}")

engine = create_engine(DATABASE_URL)

RAW_PATH = "/opt/airflow/data/raw/"

def ingest_table(table_name):
    try:
        config = TABLE_CONFIG[table_name]
        file_path = RAW_PATH + config["file"]

        if not os.path.exists(file_path):
            logging.error(f"File not found: {file_path}")
            return

        logging.info(f"Ingesting {table_name} from {file_path}")
        df = pd.read_csv(file_path)
        logging.info(f"Rows: {len(df)}")

        df["ingestion_time"] = datetime.now()
        df["source_file"] = config["file"]
        df["batch_id"] = str(uuid.uuid4())

        df.to_sql(
            name=config["table"],
            con=engine,
            schema="bronze",
            if_exists="append",
            index=False,
            method="multi"
        )
        logging.info(f"{table_name} - {len(df)} rows ingested")
    except Exception as e:
        logging.exception(f"[ERROR] {table_name} ingestion failed: {e}")
        raise

def ingest_all():
    for table in TABLE_CONFIG.keys():
        ingest_table(table)

if __name__ == "__main__":
    ingest_all()