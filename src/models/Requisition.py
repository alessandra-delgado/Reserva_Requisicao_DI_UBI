"""
Requisition table representation in code. Has the queries to Requisition table
"""
from models import DataBase as db
from enums.reservationEquipmentType import ReservationEquipmentType

def add_requisition(user, datetime_start, datetime_end, equipments_radio) -> None:
    # todo: after insert, update number of collected equipments with size of equip list (radio)
    conn = db.connect()
    cursor = conn.cursor()

    id_user = user.split()[0]
    status_req = 'Active'
    collected = 0

    cursor.execute("""
        INSERT INTO TblRequisition (id_user, time_start, time_end, status_req)
        OUTPUT INSERTED.id_req
        VALUES (?, ?, ?, ?);
    """, (id_user, datetime_start, datetime_end, status_req))

    id_req = cursor.fetchone()[0]

    for equipment, selection in equipments_radio.items():
        if(selection == ReservationEquipmentType.reserved.value):
            cursor.execute("INSERT INTO TblReq_Equip (id_req, id_equip) VALUES (?,?)", (id_req, equipment,))
            collected+=1

    cursor.execute("UPDATE TblRequisition SET collected = ? WHERE id_req = ?", (collected, id_req,))
    conn.commit()
    print(user, datetime_start, datetime_end, equipments_radio)

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
