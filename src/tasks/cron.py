import time
from models import DataBase as db, Reservation


def init(stop):
    while not stop.is_set():
        # Executar a tarefa
        run()

        for _ in range(60):
            if stop.is_set():
                return
            time.sleep(1)


def run():
    conn = db.connect()
    print("Running task")

    for reservation in Reservation.get_reservations():
        conn.execute(
            "exec DetermineStatus @idr = ? ", reservation[0])

    conn.commit()
    db.close(conn)