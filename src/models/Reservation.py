"""
Reservation table representation in code. Has the queries to Reservation table
"""
from models import DataBase as db
from datetime import datetime
from enums.reservationEquipmentType import ReservationEquipmentType

def add_reservation(user, datetime_start, datetime_end, equipments_radio) -> None:
    conn = db.connect()
    cursor = conn.cursor()

    id_user = user.split()[0]
    print(id_user)

    current_date = datetime.today()
    status_res = "Waiting"
    assigned_to = 0

    sql = """
        SET NOCOUNT ON;
        DECLARE @rv VARCHAR(8);
        EXEC MakeId @GeneratedID = @rv OUTPUT;
        SELECT @rv AS return_value;
    """

    cursor.execute(sql)
    return_value = cursor.fetchval()

    id_reserv = return_value

    cursor.execute("""
        INSERT INTO TblReservation (id_reserv, id_user, time_start, time_end, reg_date, status_res)
        VALUES (?,?,?,?,?,?);
    """, (id_reserv, id_user, datetime_start, datetime_end, current_date, status_res,))

    for equipment, selection in equipments_radio.items():
        if(selection == ReservationEquipmentType.essential.value):
           essential = 1
        else:
           essential = 0

        if (selection != ReservationEquipmentType.not_reserved.value):
            cursor.execute("INSERT INTO TblRes_Equip (id_reserv, id_equip, essential, assigned_to) VALUES (?,?,?,?)", (id_reserv, equipment, essential, assigned_to,))

    conn.commit()
    db.close(conn)
    print(user, datetime_start, datetime_end, equipments_radio)

def edit_reservation(reservation_id, status) -> None:
    conn = db.connect()
    cursor = conn.cursor()

    cursor.execute("UPDATE TblReservation SET status_res = ? WHERE id_reserv = ?", (status, reservation_id,))

    conn.commit()
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

def active_reservations(status) -> list:
    conn = db.connect()
    result = conn.cursor().execute("SELECT COUNT(DISTINCT [Reservation id]) FROM ActiveReservations WHERE [Status] = ?", (status,))

    rows = result.fetchone()
    db.close(conn)
    return rows