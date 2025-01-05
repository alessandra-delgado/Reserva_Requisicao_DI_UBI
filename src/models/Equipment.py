"""
Requisition table representation in code. Has the queries to Requisition table
"""
from enums.equipmentCategory import EquipmentCategory
from models import DataBase as db


def add_equipment(name, category) -> None:
    conn = db.connect()
    cursor = conn.cursor()

    cursor.execute("INSERT INTO TblEquipment (name_equip, category) VALUES (?,?)", (name, category,))
    cursor.commit()

    db.close(conn)


def get_equipments(category, priority) -> list:
    conn = db.connect()

    if category == EquipmentCategory.all.value:
        result = conn.cursor().execute("SELECT * FROM ViewEquipmentPriority WHERE Status IN ('Available', 'Reserved') AND Priority <= ?", (priority,))
    else:
        result = conn.cursor().execute(
            "SELECT * FROM ViewEquipmentPriority WHERE Status IN ('Available', 'Reserved') AND Priority <= ? AND category like ?", (priority,category,))

    rows = result.fetchall()
    db.close(conn)

    return rows

def get_equipments_req(category) -> list:
    conn = db.connect()

    if category == EquipmentCategory.all.value:
        result = conn.cursor().execute("SELECT * FROM TblEquipment WHERE status_equip IN ('Available', 'Reserved')")
    else:
        result = conn.cursor().execute(
            "SELECT * FROM TblEquipment WHERE status_equip IN ('Available', 'Reserved') AND category like ?", (category,))


    rows = result.fetchall()
    db.close(conn)

    return rows


def get_all_equipments() -> list:
    conn = db.connect()

    result = conn.cursor().execute("SELECT * FROM TblEquipment")

    rows = result.fetchall()
    db.close(conn)

    return rows


def get_by_id(equipment_id) -> list:
    conn = db.connect()

    result = conn.cursor().execute("SELECT * FROM TblEquipment where id_equip = %s" % equipment_id)

    rows = result.fetchone()
    db.close(conn)

    return rows

def get_by_id_view(equipment_id) -> list:
    conn = db.connect()

    result = conn.cursor().execute("SELECT * FROM ViewEquipmentPriority where Equipment_ID = %s" % equipment_id)

    rows = result.fetchone()
    db.close(conn)

    return rows
