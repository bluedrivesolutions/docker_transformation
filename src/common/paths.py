from pathlib import Path
      
# Defining the root path
if Path(__file__).parent.name == 'common':
      SRC_PATH = Path(__file__).parent.parent
else:
      SRC_PATH = Path(__file__).parent

# Defining the paths for your project
PROJECT_PATH:Path = SRC_PATH.parent
LOGS_PATH:Path = PROJECT_PATH / 'logs'
OUTPUT_PATH = PROJECT_PATH / '.output'
TESTS_PATH = PROJECT_PATH / 'tests'

# Running the main function
if __name__ == "__main__": 
      None