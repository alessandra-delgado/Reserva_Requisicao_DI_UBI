"""
Requisition table representation in code. Has the queries to Requisition table
"""
from enums.equipmentCategory import EquipmentCategory
from models import DataBase as db


def add_equipment(name, category) -> None:
    conn = db.conn

    if conn is None:
        return

    cursor = conn.cursor()

    cursor.execute("INSERT INTO TblEquipment (name_equip, category) VALUES (?,?)", (name, category,))
    cursor.commit()


def get_equipments(category, priority) -> list:
    conn = db.conn

    if conn is None:
        return []

    if category == EquipmentCategory.all.value:
        result = conn.cursor().execute("SELECT * FROM ViewEquipmentPriority WHERE Priority <= ? or Priority IS NULL ", (priority,))
    else:
        result = conn.cursor().execute(
            "SELECT * FROM ViewEquipmentPriority WHERE (Priority <= ? OR Priority is NULL) AND Category like ?", (priority,category,))

    rows = result.fetchall()

    return rows

def get_all_equipments() -> list:
    conn = db.conn

    if conn is None:
        return []

    result = conn.cursor().execute("SELECT * FROM TblEquipment")

    rows = result.fetchall()

    return rows


def get_by_id(equipment_id) -> list:
    conn = db.conn

    if conn is None:
        return []

    result = conn.cursor().execute("SELECT * FROM TblEquipment where id_equip = %s" % equipment_id)

    rows = result.fetchone()

    return rows

def get_by_id_view(equipment_id) -> list:
    conn = db.conn

    if conn is None:
        return []

    result = conn.cursor().execute("SELECT * FROM ViewEquipmentPriority where Equipment_ID = %s" % equipment_id)

    rows = result.fetchone()

    return rows

def avail_equipments() -> list:
    conn = db.conn

    if conn is None:
        return []
    
    result = conn.cursor().execute("""
        SELECT COUNT(DISTINCT [Equipment ID])
        FROM ResourceState
        WHERE [Status] IN ('Available')
        """)

    rows = result.fetchone()

    return rows