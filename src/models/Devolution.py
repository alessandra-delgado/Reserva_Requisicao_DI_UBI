from models import DataBase as db

def get_by_requisition(requisition_id) -> list:
    conn = db.conn

    if conn is None:
        return None

    result = conn.cursor().execute("SELECT * FROM TblDevolution Where id_req=?", requisition_id)
    rows = result.fetchall()

    return rows