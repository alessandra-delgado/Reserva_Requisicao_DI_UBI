import pyodbc

def close(conn):
    conn.close()

def connect():
    return pyodbc.connect(
        "DRIVER={ODBC Driver 17 for SQL Server};"
        "SERVER=localhost,1433;"
        "DATABASE=teste_di;"
        "UID=sa;"
        "PWD=sa;"
    )