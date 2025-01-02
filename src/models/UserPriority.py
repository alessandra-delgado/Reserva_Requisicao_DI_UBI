from models import DataBase as db

def get_user_priorities() -> list:

    conn = db.connect()

    result = conn.cursor().execute("SELECT id_type FROM TblUser_Priority")
    rows = result.fetchall()


    data = []
    for row in rows:
        data.append(row[0])


    # If there's a president then hide PD option
    result = conn.cursor().execute("SELECT id_user FROM TblUser_DI WHERE id_type = 'PD'")

    if len(result.fetchall()) > 0:
        data.remove('PD')


    db.close(conn)
    return data
