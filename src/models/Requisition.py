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

def get_by_id(requisition_id) -> list:
    conn = db.connect()
    result = conn.cursor().execute("SELECT * FROM TblRequisition Where id_req=?", requisition_id)
    rows = result.fetchone()
    db.close(conn)

    return rows