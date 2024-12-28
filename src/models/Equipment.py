"""
Requisition table representation in code. Has the queries to Requisition table
"""
from models import DataBase as db


def add_equipment(name, category) -> None:
    raise NotImplementedError


def get_equipments() -> list:
    conn = db.connect()
    result = conn.cursor().execute("SELECT * FROM TblEquipment")
    rows = result.fetchall()
    db.close(conn)

    return rows
