from common.paths import SRC_PATH
from common.config import setup_logging, \
      load_local_env, check_env_vars
from common.config_db import DBConnectionClickhouse

from pathlib import Path
from os import getenv

# Setup common logging
logger = setup_logging(Path(__file__).stem)
load_local_env(SRC_PATH / '.env', logger=logger)

def main():
      
      # Check the environment variables if available.
      check_env_vars(
            ['CLICKHOUSE_HOST', 'CLICKHOUSE_PORT', 'CLICKHOUSE_USER', 'CLICKHOUSE_PASSWORD'], 
            logger=logger
      )
      
      # Connecting to the database
      
      
      # db = DatabaseConnection()
      # with db.managed_cursor() as cur:
      # # cursor and connection are open
      # cur.execute("YOUR SQL QUERY")
      # # cursor and connection are closed

      return True

# Running the main function
if __name__ == "__main__":
      logger.debug(f'Running the main function... {Path(__file__).stem}')
      if main():
            logger.info(f'{Path(__file__).stem} executed successfully!')
      else:
            logger.info(f'{Path(__file__).stem} failed!')