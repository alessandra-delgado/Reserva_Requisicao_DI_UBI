"""
UserDI table representation in code. Has the queries to UserDI table
"""
import pyodbc

users = [
    {"id": "Primeiro User", "type": "Aluno", "email": "email1@email.com", "cellphone": "1111111111",
     "priority": "Alta"},
    {"id": "Segundo User", "type": "Reitor", "email": "email2@email.com", "cellphone": "2222222222",
     "priority": "Baixa"}
]

def connectBD():
        conn = pyodbc.connect(
                'DRIVER={ODBC Driver 17 for SQL Server};'
                'SERVER=172.30.96.1,1433;'
                'DATABASE=teste_di;'
                'UID=sa;'
                'PWD=sa;'
        )
        return conn

conn = connectBD()
cursor = conn.cursor()

def add_user(id, name, user_type, email, cellphone) -> None:
    print("New User")
    print("id: ", id)
    print("name: ", name)
    print("type: ", user_type)
    print("email: ", email)
    print("cellphone: ", cellphone)

    id_user = id_type+'_'+id

    cursor.execute("INSERT INTO TblUser_DI (id_user, id_type, name, phone_no) VALUES (?,?,?,?)", (id_user, id_type, name, cellphone,))

    if(email != ""):
        cursor.execute("INSERT INTO TblContact (id_user, email) VALUES (?,?)", (id_user, email,))

def get_users() -> list:
    cursor.execute("SELECT * FROM TblUser_DI")
    rows = cursor.fetchall()

    return rows

#cursor.commit()
#if you want it to affect the bd for real, you need to uncomment the cursor.commit()
cursor.close()
conn.close()
