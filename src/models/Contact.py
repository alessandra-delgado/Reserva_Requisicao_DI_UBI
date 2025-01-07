from models import DataBase as db


def get_by_id(user_id) -> str:
    conn = db.conn

    if conn is None:
        return 'N/A'

    result = conn.cursor().execute("SELECT email FROM TblContact WHERE id_user LIKE ?", (user_id.upper(),))
    contact = result.fetchone()

    return contact[0] if contact is not None else 'N/A'
