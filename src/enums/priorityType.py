from enum import Enum


class PriorityType(Enum):
    minimum = 1
    below = 2
    average = 3
    above = 4
    maximum = 5

    @staticmethod
    def label(status: str) -> str:
        match status:
            case PriorityType.minimum.value:
                return 'Minima'
            case PriorityType.below.value:
                return 'Abaixo'
            case PriorityType.average.value:
                return 'Média'
            case PriorityType.above.value:
                return 'Acima'
            case PriorityType.maximum.value:
                return 'Máxima'
