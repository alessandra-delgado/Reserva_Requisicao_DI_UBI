from models import DataBase as db

def get_by_reservation(reservation_id) -> list:
    conn = db.conn

    if conn is None:
        return []

    result = conn.cursor().execute("SELECT * FROM TblRes_Equip Where id_reserv=?", reservation_id)
    rows = result.fetchall()

    return rows