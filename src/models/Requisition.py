"""
Requisition table representation in code. Has the queries to Requisition table
"""
from models import DataBase as db


def add_requisition(user, datetime_start, datetime_end, equipments_radio) -> None:
    print(user, datetime_start, datetime_end, equipments_radio)
    raise NotImplementedError

def edit_requisition(requisition_id, equipment_devolutions) -> None:
    print(requisition_id, equipment_devolutions)
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