from enum import Enum


class EquipmentStatus(Enum):
    available = 'Available'
    reserved = 'Reserved'
    inUse = 'InUse'

    @staticmethod
    def label(status: str) -> str:
        match status:
            case EquipmentStatus.available.value:
                return 'Disponível'
            case EquipmentStatus.reserved.value:
                return 'Reservado'
            case EquipmentStatus.inUse.value:
                return 'Em Uso'
            case _:
                return status
