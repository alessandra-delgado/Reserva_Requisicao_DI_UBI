import time
from models import DataBase as db, Reservation
from datetime import datetime
from croniter import croniter


def init(stop):
    while True:
        if stop:
             break
        scheduler = croniter('*/1 * * * *', datetime.now())
        next_schedule = scheduler.get_next(datetime)

        # Aguardar até o próximo agendamento
        wait = next_schedule - datetime.now()
        time.sleep(wait.total_seconds())

        # Executar a tarefa
        run()


def run():
    conn = db.connect()
    print ("Running task")

    for reservation in Reservation.get_reservations():
        conn.execute(
            "exec DetermineStatus @idr = ? ", reservation[0])



    conn.commit()
    db.close(conn)
