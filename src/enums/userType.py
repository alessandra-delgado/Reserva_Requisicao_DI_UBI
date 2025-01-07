from enum import Enum


class UserType(Enum):
    bs = 'BS'
    ds = 'DS'
    ms = 'MS'
    pd = 'PD'
    pr = 'PR'
    rs = 'RS'
    sf = 'SF'
    xt = 'XT'

    @staticmethod
    def label(status: str) -> str:
        match status:
            case UserType.bs.value:
                return 'Licenciatura'
            case UserType.ds.value:
                return 'Doutoramento'
            case UserType.ms.value:
                return 'Mestrado'
            case UserType.pd.value:
                return 'Presidente'
            case UserType.pr.value:
                return 'Professor'
            case UserType.rs.value:
                return 'Investigador'
            case UserType.sf.value:
                return 'Apoio'
            case UserType.xt.value:
                return 'Externo'
