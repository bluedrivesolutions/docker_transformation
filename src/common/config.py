# def load_airflow_env(env_file:str=None) -> None:
#       ''' Load Airflow environment. '''
#       return None


def load_local_env(env_file:str=None, logger=None) -> None:
      ''' Load local environment. '''
      
      from dotenv import load_dotenv
      from common.paths import ROOT_PATH
      from pathlib import Path
      
      # Check for the arguments
      if env_file is None:
            env_file = ROOT_PATH / '.env'
      if not isinstance(env_file, Path):
            env_file = Path(env_file)
      
      # Check if the env file exists
      if not env_file.exists():
            raise FileNotFoundError(
                  f'Environment file not found!'
            )
      
      # Check if the env file is a .env file
      if logger is not None:
            logger.debug(f'Loading environment from {env_file}...')
      return load_dotenv(env_file)


def check_env_vars(env_vars:list=None, logger=None) -> None:
      ''' Check if the environment variables are available. '''
      from os import getenv
      
      # Check if the argument is a list
      if not isinstance(env_vars, list):
            env_vars = [env_vars]
            
      # Check if the credentials exists
      for var in env_vars:
            if getenv(var) is None:
                  raise ValueError(
                        f'Environment variable {var} not found!'
                  )
      if logger is not None:
            logger.debug(f'Environment variables checked successfully!')


def setup_logging(name:str=None) -> None:
      from loguru import logger
      from common.paths import LOGS_PATH
      
      # Check for the arguments
      if name is None:
            name = 'app'
            
      # Setup the logger
      logger.remove()
      logger.add(
            LOGS_PATH / f'{name}.log',
            level='DEBUG',
            rotation='10 MB',
            retention='7 days',
            colorize=True,
            compression='zip'
      )
      
      return logger


# Running the main file
if __name__ == "__main__":
      None