from models import DataBase as db

def get_user_priorities() -> list:

    conn = db.connect()

    result = conn.cursor().execute("SELECT id_type FROM TblUser_Priority")
    rows = result.fetchall()

    db.close(conn)

    data = []
    for row in rows:
        data.append(row[0])

    return data
