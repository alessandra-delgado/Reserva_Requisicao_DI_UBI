from enum import Enum


class RequisitionStatus(Enum):
    cancelled = 'Cancelled'
    waiting = 'Waiting'
    forgotten = 'Forgotten'
    active = 'Active'

    @staticmethod
    def label(status: str) -> str:
        match status:
            case RequisitionStatus.cancelled.value:
                return 'Cancelado'
            case RequisitionStatus.waiting.value:
                return 'Em espera'
            case RequisitionStatus.forgotten.value:
                return 'Esquecida'
            case RequisitionStatus.active.value:
                return 'Ativa'
            case _:
                return status


    @staticmethod
    def can_edit(status: str) -> bool:
        return status in [RequisitionStatus.active.value]