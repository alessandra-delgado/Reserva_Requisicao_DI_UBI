"""
Reservation table representation in code. Has the queries to Reservation table
"""
from models import DataBase as db


def add_reservation() -> None:
    raise NotImplementedError


def get_reservations() -> list:
    conn = db.connect()
    result = conn.cursor().execute("SELECT * FROM TblReservation")
    rows = result.fetchall()
    db.close(conn)

    return rows
