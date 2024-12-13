"""
UserDI table representation in code. Has the queries to UserDI table
"""

users = [
    {"id": "Primeiro User", "type": "Aluno", "email": "email1@email.com", "cellphone": "1111111111",
     "priority": "Alta"},
    {"id": "Segundo User", "type": "Reitor", "email": "email2@email.com", "cellphone": "2222222222",
     "priority": "Baixa"}
]


def add_user(user_type, email, cellphone) -> None:
    print("New User")
    print("type: ", user_type)
    print("email: ", email)
    print("cellphone: ", cellphone)

    users.append({"id": "Names", "type": user_type, "email": email, "cellphone": cellphone, "priority": "Alta"})


def get_users() -> list:
    return users
