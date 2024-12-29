"""
Reservation table representation in code. Has the queries to Reservation table
"""
from models import DataBase as db


def add_reservation(user, datetime_start, datetime_end, equipments_radio) -> None:
    print(user, datetime_start, datetime_end, equipments_radio)


def get_reservations() -> list:
    conn = db.connect()
    result = conn.cursor().execute("SELECT * FROM TblReservation")
    rows = result.fetchall()
    db.close(conn)

    return rows

def get_by_id(reservation_id) -> list:
    conn = db.connect()
    result = conn.cursor().execute("SELECT * FROM TblReservation Where id_reserv=?", reservation_id)
    rows = result.fetchone()
    db.close(conn)

    return rows