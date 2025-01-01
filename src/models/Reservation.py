"""
Reservation table representation in code. Has the queries to Reservation table
"""
from models import DataBase as db
from datetime import date

def add_reservation(user, datetime_start, datetime_end, equipments_radio) -> None:
    conn = db.connect()
    cursor = conn.cursor()

    id_user = user.split()[0]
    print(id_user)

    current_date = date.today()
    status_res = "Waiting"
    assigned_to = 0
    cursor.execute("""
        INSERT INTO TblReservation (id_user, time_start, time_end, reg_date, status_res)
        VALUES (?,?,?,?,?);
    """, (id_user, datetime_start, datetime_end, current_date, status_res,))

    cursor.execute("SELECT * FROM TblRes_SeqId")
    id = cursor.fetchone()

    id_reserv = str(id[0]) + str(id[1]).zfill(4)
    id_reserv = id_reserv[:8]

    cursor.execute("SELECT 1 FROM TblReservation WHERE id_reserv = ?", (id_reserv,))
    id_exists = cursor.fetchone()

    while id_exists[0] != id_reserv:
        cursor.execute("SELECT id_reserv FROM TblReservation WHERE id_reserv = ?", (id_reserv,))
        id_exists = cursor.fetchone()

    print(id_reserv)
    print(id_exists)
    for equipment, selection in equipments_radio.items():
        if (selection != "Not Reserved"):

            if(selection == "Essential"):
                essencial=1
            else:
                essencial=0

            cursor.execute("INSERT INTO TblRes_Equip (id_reserv, id_equip, essential, assigned_to) VALUES (?,?,?,?)", (id_reserv, equipment, essencial, assigned_to,))

    db.close(conn)
    print(user, datetime_start, datetime_end, equipments_radio)

def edit_reservation(reservation_id, status) -> None:
    conn = db.connect()
    cursor = conn.cursor()

    cursor.execute("UPDATE TblReservation SET status_res = ? WHERE id_reserv = ?", (status, reservation_id,))

    db.close(conn)
    print(reservation_id, status)


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
