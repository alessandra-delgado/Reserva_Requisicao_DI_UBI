"""
UserDI table representation in code. Has the queries to UserDI table
"""
from models import DataBase as db

users = [
    {"id": "Primeiro User", "type": "Aluno", "email": "email1@email.com", "cellphone": "1111111111",
     "priority": "Alta"},
    {"id": "Segundo User", "type": "Reitor", "email": "email2@email.com", "cellphone": "2222222222",
     "priority": "Baixa"}
]


def add_user(id_input, name, id_type, email, cellphone) -> None:
    print("New User")
    print("id: ", id_input)
    print("name: ", name)
    print("type: ", id_type)
    print("email: ", email)
    print("cellphone: ", cellphone)

    id_user = id_type+'_'+id_input
    conn = db.connect()
    conn.cursor().execute("INSERT INTO TblUser_DI (id_user, id_type, name, phone_no) VALUES (?,?,?,?)", (id_user, id_type, name, cellphone,))

    if email != "":
        conn.cursor().execute("INSERT INTO TblContact (id_user, email) VALUES (?,?)", (id_user, email,))

    conn.commit()

    db.close(conn)

def get_users() -> list:
    conn = db.connect()
    result = conn.cursor().execute("SELECT * FROM TblUser_DI")
    rows = result.fetchall()
    db.close(conn)

    return rows

def get_user_by_id(user_id: str) -> list:
    conn = db.connect()
    result = conn.cursor().execute("SELECT * FROM TblUser_DI WHERE id_user LIKE ?", (user_id.upper(),))
    rows = result.fetchall()
    db.close(conn)

    return rows

def get_user_priority(user_id: str) -> list:
    conn = db.connect()
    result = conn.cursor().execute("SELECT current_priority FROM TblUser_DI WHERE id_user LIKE ?", (user_id,))
    rows = result.fetchone()
    db.close(conn)

    print(rows)

    return rows