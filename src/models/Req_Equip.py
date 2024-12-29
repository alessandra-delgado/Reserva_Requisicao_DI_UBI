from models import DataBase as db

def get_by_requisition(requisition_id) -> list:
    conn = db.connect()
    result = conn.cursor().execute("SELECT * FROM TblReq_Equip Where id_req=?", requisition_id)
    rows = result.fetchall()
    db.close(conn)

    return rows