"""
UserDI table representation in code. Has the queries to UserDI table
"""
from models import DataBase as db


def add_user(id_input, name, id_type, email, cellphone) -> None:
    id_user = id_type + '_' + id_input
    conn = db.conn

    if conn is None:
        return None

    conn.cursor().execute("INSERT INTO TblUser_DI (id_user, id_type, name, phone_no) VALUES (?,?,?,?)",
                          (id_user, id_type, name, cellphone,))

    if email != "":
        conn.cursor().execute("INSERT INTO TblContact (id_user, email) VALUES (?,?)", (id_user, email,))

    conn.commit()


def get_users() -> list:
    conn = db.conn

    if conn is None:
        return []

    result = conn.cursor().execute("SELECT * FROM TblUser_DI")
    rows = result.fetchall()

    return rows


def get_user_by_id(user_id: str) -> list:
    conn = db.conn

    if conn is None:
        return []

    result = conn.cursor().execute("SELECT * FROM TblUser_DI WHERE id_user LIKE ?", (user_id.upper(),))
    rows = result.fetchall()

    return rows


def get_user_priority(user_id: str) -> list:
    conn = db.conn

    if conn is None:
        return []
    
    result = conn.cursor().execute("SELECT current_priority FROM TblUser_DI WHERE id_user LIKE ?", (user_id,))
    rows = result.fetchone()

    return rows
