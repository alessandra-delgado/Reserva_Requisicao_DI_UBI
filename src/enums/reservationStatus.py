from enum import Enum


class ReservationStatus(Enum):
    satisfied = 'Satisfied'
    cancelled = 'Cancelled'
    waiting = 'Waiting'
    forgotten = 'Forgotten'
    active = 'Active'
    not_satisfied = 'NotSatisfied'

    @staticmethod
    def label(status: str) -> str:
        match status:
            case ReservationStatus.satisfied.value:
                return 'Satisfeita'
            case ReservationStatus.cancelled.value:
                return 'Cancelada'
            case ReservationStatus.waiting.value:
                return 'Em Espera'
            case ReservationStatus.forgotten.value:
                return 'Esquecida'
            case ReservationStatus.active.value:
                return 'Ativa'
            case ReservationStatus.not_satisfied.value:
                return 'Não Satisfeita'
            case _:
                return status

    @staticmethod
    def get_status_edit():
        return [ReservationStatus.satisfied.value, ReservationStatus.cancelled.value]


    @staticmethod
    def can_edit(status: str) -> bool:
        return status not in [ReservationStatus.satisfied.value, ReservationStatus.cancelled.value, ReservationStatus.cancelled.value]
