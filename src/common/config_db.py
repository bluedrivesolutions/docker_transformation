from clickhouse_connect import get_client
from contextlib import contextmanager


class DatabaseConnection:
    def __init__(
          self, 
          host:str = 'localhost', 
          port:int = 9000, 
          username:str = 'default', 
          password: str = ''
    ):
        self.host = host
        self.port = port
        self.username = username
        self.password = password

    @contextmanager
    def managed_cursor(self):
        """Function to create a managed database cursor."""
        client = get_client(
              host=self.host, port=self.port, username=self.username, password=self.password
        )
        try:
            yield client.cursor()
        finally:
            client.close()

    def __str__(self) -> str:
        return f'{self.username}@{self.host}:{self.port}'


# Running and testing the main function
if __name__ == '__main__':
      None
      
      # db = DatabaseConnection()
      # with db.managed_cursor() as cur:
      # # cursor and connection are open
      # cur.execute("YOUR SQL QUERY")
      # # cursor and connection are closed