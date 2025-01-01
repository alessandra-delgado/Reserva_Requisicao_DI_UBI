from enum import Enum


class RequisitionStatus(Enum):
    active = 'Active'
    closed = 'Closed'

    @staticmethod
    def label(status: str) -> str:
        match status:
            case RequisitionStatus.active.value:
                return 'Ativa'
            case RequisitionStatus.closed.value:
                return 'Terminada'
            case _:
                return status


    @staticmethod
    def can_edit(status: str) -> bool:
        return status in [RequisitionStatus.active.value]