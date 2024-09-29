from pathlib import Path
from common.paths import SRC_PATH
from common.config import setup_logging, \
      load_local_env, check_env_vars

# Setup common logging
logger = setup_logging(Path(__file__).stem)
load_local_env(SRC_PATH / '.env', logger=logger)
check_env_vars(
      ['DBT_PROFILES_DIR'], 
      logger=logger
)

def main():
      return None

# Running the main function
if __name__ == "__main__":
      logger.debug(f'Running the main function... {Path(__file__).stem}')
      if main():
            logger.info(f'{Path(__file__).stem} executed successfully!')
      else:
            logger.info(f'{Path(__file__).stem} failed!')