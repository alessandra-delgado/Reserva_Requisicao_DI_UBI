from enum import Enum


class EquipmentCategory(Enum):
    peripherals = 'peripherals'
    computer = 'computer'
    other = 'other'
    all = 'all'

    @staticmethod
    def label(status: str) -> str:
        match status:
            case EquipmentCategory.peripherals.value:
                return 'Periféricos'
            case EquipmentCategory.computer.value:
                return 'Computador'
            case EquipmentCategory.other.value:
                return 'Outro'
            case EquipmentCategory.all.value:
                return 'Todos'
            case _:
                return status

    @staticmethod
    def get_categories():
        return ['all', 'peripherals', 'computer', 'other']