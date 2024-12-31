from enum import Enum


class ReservationEquipmentType(Enum):
    not_reserved = 'not_reserved'
    reserved = 'reserved'
    essential = 'essential'

    @staticmethod
    def label(status: str) -> str:
        match status:
            case ReservationEquipmentType.not_reserved.value:
                return 'Não'
            case ReservationEquipmentType.reserved.value:
                return 'Reservado'
            case ReservationEquipmentType.essential.value:
                return 'Essencial'
            case _:
                return status