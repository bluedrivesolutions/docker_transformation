from common.paths import SRC_PATH
from common.config import setup_logging, load_local_env, check_env_vars
from common.config_db import DBConnectionClickhouse

from pathlib import Path
from os import getenv
import pandas as pd

# Setup common logging
logger = setup_logging(Path(__file__).stem)
load_local_env(SRC_PATH / '.env', logger=logger)

def main():
      
      # Check the environment variables if available.
      check_env_vars(
            ['CLICKHOUSE_HOST', 'CLICKHOUSE_PORT', 'CLICKHOUSE_USER', 'CLICKHOUSE_PASSWORD'], 
            logger=logger
      )
      
      # Connecting to the raw database
      raw_db = DBConnectionClickhouse(
            host=getenv('CLICKHOUSE_HOST'),
            port=getenv('CLICKHOUSE_PORT'),
            username=getenv('CLICKHOUSE_USER'),
            password=getenv('CLICKHOUSE_PASSWORD'),
            database='raw',
            logger=logger
      )
      
      # Connecting to the airbyte database
      airbyte_db = DBConnectionClickhouse(
            host=getenv('CLICKHOUSE_HOST'),
            port=getenv('CLICKHOUSE_PORT'),
            username=getenv('CLICKHOUSE_USER'),
            password=getenv('CLICKHOUSE_PASSWORD'),
            database='airbyte_internal',
            logger=logger
      )
      
      # Setup the source and target db
      source_db, target_db = airbyte_db, raw_db
      
      # Example usage with pandas outside the class
      with source_db.managed_cursor() as client:
            sample = client.execute('SELECT * FROM INFORMATION_SCHEMA.TABLES')
      
      return True

# Running the main function
if __name__ == "__main__":
      logger.debug(f'Running the main function... {Path(__file__).stem}')
      if main():
            logger.info(f'{Path(__file__).stem} executed successfully!')
      else:
            logger.info(f'{Path(__file__).stem} failed!')