from enum import Enum


class ReservationStatus(Enum):
    cancelled = 'Cancelled'
    waiting = 'Waiting'
    forgotten = 'Forgotten'
    active = 'Active'

    @staticmethod
    def label(status: str) -> str:
        match status:
            case ReservationStatus.cancelled.value:
                return 'Cancelado'
            case ReservationStatus.waiting.value:
                return 'Em espera'
            case ReservationStatus.forgotten.value:
                return 'Esquecida'
            case ReservationStatus.active.value:
                return 'Ativa'