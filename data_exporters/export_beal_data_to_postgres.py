from mage_ai.settings.repo import get_repo_path
from mage_ai.io.config import ConfigFileLoader
from mage_ai.io.postgres import Postgres
from pandas import DataFrame
from os import path
import pandas as pd
import os
from sqlalchemy import create_engine, text
from dotenv import load_dotenv, dotenv_values, find_dotenv


if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter


@data_exporter
def export_data_to_postgres(df: DataFrame, **kwargs) -> None:
    """
    Template for exporting data to a PostgreSQL database.
    Specify your configuration settings in 'io_config.yaml'.

    Docs: https://docs.mage.ai/design/data-loading#postgresql
    """

    load_dotenv()
    db_user = os.environ.get('POSTGRES_DB_USER')
    db_pass = os.environ.get('POSTGRES_DB_PASS')
    db_name = 'phx_db'

    #Create Database Engine
    engine = create_engine(f'postgresql://{db_user}:{db_pass}@localhost:5432/{db_name}')

    #Connect Database engine using connection credentials
    engine.connect()

    sql = text('DROP TABLE IF EXISTS bradley_beal_shots CASCADE;')
    engine.execute(sql)

    #Create Database table using the column names from the Dataframe
    #df.head(n=0).to_sql(name='wnba_data', con=engine, if_exists='replace')

    #Insert the rest of the DataFrame whilst using %time command to see how long it takes
    df.to_sql(name='bradley_beal_shots', con=engine, if_exists='replace')