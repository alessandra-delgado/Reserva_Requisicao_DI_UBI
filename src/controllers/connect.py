from tkinter import simpledialog

from models import DataBase


def to_db():
    DataBase.db_ip = simpledialog.askstring("Ligação", "Insira o IP do servidor:")
    DataBase.db_name = simpledialog.askstring("Ligação", "Insira o nome da base de dados:")
    DataBase.db_user = simpledialog.askstring("Ligação", "Insira o utilizador:")
    DataBase.db_pass = simpledialog.askstring("Ligação", "Insira a password:", show="*")

    DataBase.connect()
