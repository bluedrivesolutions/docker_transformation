from clickhouse_connect import get_client
from contextlib import contextmanager


class DBConnectionClickhouse:
    def __init__(
        self, 
        host, 
        port, 
        username, 
        password,
        database = 'default',
        logger = None
    ):
        self._host = host
        self._port = port
        self._username = username
        self._password = password
        self._database = database
        
        # Utils variables
        self.__logger = logger

    @contextmanager
    def managed_cursor(self):
        """Function to create a managed database cursor."""
        if self.__logger is not None:
            self.__logger.debug(f"Connecting to database...")
        
        # Restart and recreate the client
        client = None
        try:
            client = get_client(
                host=self.host, port=self.port, username=self.username, password=self.password, database=self.database
            )
            cursor = client.cursor()
            yield cursor
            if self.__logger is not None:
                self.__logger.info("Database operations completed...")

        except Exception as e:
            if self.__logger is not None:
                self.__logger.error(f"Unexpected error during database operation: {str(e)}")
            raise e
        
        finally:
            if client:
                client.close()
                if self.__logger is not None:
                    self.__logger.debug('DB Connection closed...')

    def __str__(self) -> str:
        return f'{self._username}@{self._host}:{self._port}/{self._database}'


# Running and testing the main function
if __name__ == '__main__':
    None