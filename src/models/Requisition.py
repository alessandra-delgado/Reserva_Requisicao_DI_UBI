"""
Requisition table representation in code. Has the queries to Requisition table
"""
from models import DataBase as db


def add_requisition() -> None:
    raise NotImplementedError


def get_requisitions() -> list:
    conn = db.connect()
    result = conn.cursor().execute("SELECT * FROM TBLRequisition")
    rows = result.fetchall()
    db.close(conn)

    return rows
