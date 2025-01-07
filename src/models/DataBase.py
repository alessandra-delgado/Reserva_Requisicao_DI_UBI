from tkinter import messagebox

import pyodbc

db_ip = 'localhost'
db_name = 'teste_di'
db_user = 'sa'
db_pass = 'sa'

conn = None

def close():
    global conn

    if conn is not None:
        conn.close()

def connect():
    global conn

    # Terminate connection if there's one open
    if conn is not None:
        conn.close()

    try:
        conn = pyodbc.connect(
            f"DRIVER={{SQL Server}};SERVER={db_ip};DATABASE={db_name};UID={db_user};PWD={db_pass}")
        messagebox.showinfo("Sucesso", "Ligação efetuada com sucesso!")
    except Exception as e:
        messagebox.showerror("Erro", f"Erro ao adicionar dados: {e}")
