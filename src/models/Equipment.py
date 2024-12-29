"""
Requisition table representation in code. Has the queries to Requisition table
"""
from enums.equipmentCategory import EquipmentCategory
from models import DataBase as db


def add_equipment(name, category) -> None:
    raise NotImplementedError


def get_equipments(category) -> list:
    conn = db.connect()

    if category == EquipmentCategory.all.value:
        result = conn.cursor().execute("SELECT * FROM TblEquipment")
    else:
        result = conn.cursor().execute("SELECT * FROM TblEquipment where category like '%s'" % category)

    rows = result.fetchall()
    db.close(conn)

    return rows

def get_by_id(equipment_id) -> list:
    conn = db.connect()

    result = conn.cursor().execute("SELECT * FROM TblEquipment where id_equip = %s" % equipment_id)

    rows = result.fetchone()
    db.close(conn)

    return rows