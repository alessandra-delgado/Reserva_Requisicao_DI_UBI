from tkinter import StringVar

import customtkinter as ctk

from models.Equipment import avail_equipments, get_all_equipments
from models.Requisition import pending_requisitions
from models.Reservation import active_reservations
from models.UserDI import get_users


class FrameHome(ctk.CTkFrame):
    def __init__(self, parent):
        super().__init__(parent, corner_radius=0, fg_color="#EBF3FA")

        # Page title
        title = ctk.CTkLabel(self, text="Página Inicial", text_color="#20558A", font=("", 20, 'bold'))
        title.grid(row=0, column=0, padx=20, pady=(30, 40), sticky="w")

        ctk.CTkLabel(self, text="Reservas Ativas:", font=("", 12)).grid(row=1, column=0, padx=20, pady=(20, 0), sticky="w")

        ctk.CTkLabel(self, text="Reservas Pendentes:", font=("", 12)).grid(row=4, column=0, padx=20, pady=(20, 0), sticky="w")

        ctk.CTkLabel(self, text="Requisições Ativas:", font=("", 12)).grid(row=7, column=0, padx=20, pady=(20, 0), sticky="w")

        ctk.CTkLabel(self, text="Equipamentos disponiveis:", font=("", 12)).grid(row=10, column=0, padx=20, pady=(20, 0), sticky="w")

        ctk.CTkLabel(self, text="Equipamentos totais:", font=("", 12)).grid(row=13, column=0, padx=20, pady=(20, 0), sticky="w")

        ctk.CTkLabel(self, text="Utilizadores registados:", font=("", 12)).grid(row=16, column=0, padx=20, pady=(20, 0), sticky="w")

        self.reload()

    def reload(self) -> None:
        res_act = StringVar(value=str(active_reservations("Active")[0]))
        ctk.CTkLabel(self, textvariable=res_act, font=("", 12)).grid(row=1, column=1, padx=10, pady=(20, 0), sticky="w")

        res_wait = StringVar(value=str(active_reservations("Waiting")[0]))
        ctk.CTkLabel(self, textvariable=res_wait, font=("", 12)).grid(row=4, column=1, padx=10, pady=(20, 0), sticky="w")

        num_req = StringVar(value=str(pending_requisitions()[0]))
        ctk.CTkLabel(self, textvariable=num_req, font=("", 12)).grid(row=7, column=1, padx=10, pady=(20, 0), sticky="w")

        num_req = StringVar(value=str(pending_requisitions()[0]))
        ctk.CTkLabel(self, textvariable=num_req, font=("", 12)).grid(row=7, column=1, padx=10, pady=(20, 0), sticky="w")

        equip_avail = StringVar(value=str(avail_equipments()[0]))
        ctk.CTkLabel(self, textvariable=equip_avail, font=("", 12)).grid(row=10, column=1, padx=10, pady=(20, 0), sticky="w")

        equip_total = StringVar(value=str(len(get_all_equipments())))
        ctk.CTkLabel(self, textvariable=equip_total, font=("", 12)).grid(row=13, column=1, padx=10, pady=(20, 0), sticky="w")

        users = StringVar(value=str(len(get_users())))
        ctk.CTkLabel(self, textvariable=users, font=("", 12)).grid(row=16, column=1, padx=10, pady=(20, 0), sticky="w")