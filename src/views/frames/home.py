from tkinter import StringVar

import customtkinter as ctk

from models import Reservation, Requisition, Equipment, UserDI, DataBase


class FrameHome(ctk.CTkFrame):
    def __init__(self, parent):
        super().__init__(parent, corner_radius=0, fg_color="#EBF3FA")

        self.reload()

    def reload(self) -> None:
        for widget in self.winfo_children():
            widget.destroy()

        # Page title
        title = ctk.CTkLabel(self, text="Página Inicial", text_color="#20558A", font=("", 20, 'bold'))
        title.grid(row=0, column=0, padx=20, pady=(30, 40), sticky="w")

        ctk.CTkLabel(self, text="Reservas Ativas:", font=("", 12)).grid(row=1, column=0, padx=20, pady=(20, 0),
                                                                        sticky="w")

        ctk.CTkLabel(self, text="Reservas em Espera:", font=("", 12)).grid(row=4, column=0, padx=20, pady=(20, 0),
                                                                           sticky="w")

        ctk.CTkLabel(self, text="Requisições Ativas:", font=("", 12)).grid(row=7, column=0, padx=20, pady=(20, 0),
                                                                           sticky="w")

        ctk.CTkLabel(self, text="Equipamentos Disponíveis:", font=("", 12)).grid(row=10, column=0, padx=20,
                                                                                 pady=(20, 0), sticky="w")

        ctk.CTkLabel(self, text="Equipamentos Totais:", font=("", 12)).grid(row=13, column=0, padx=20, pady=(20, 0),
                                                                            sticky="w")

        ctk.CTkLabel(self, text="Utilizadores Registados:", font=("", 12)).grid(row=16, column=0, padx=20,
                                                                                pady=(20, 0), sticky="w")

        res_act = StringVar(
            value=str(Reservation.active_reservations("Active")[0] if DataBase.conn is not None else 'N/A'))
        ctk.CTkLabel(self, textvariable=res_act, font=("", 12)).grid(row=1, column=1, padx=10, pady=(20, 0), sticky="w")

        res_wait = StringVar(
            value=str(Reservation.active_reservations("Waiting")[0] if DataBase.conn is not None else 'N/A'))
        ctk.CTkLabel(self, textvariable=res_wait, font=("", 12)).grid(row=4, column=1, padx=10, pady=(20, 0),
                                                                      sticky="w")

        num_req = StringVar(value=str(Requisition.pending_requisitions()[0] if DataBase.conn is not None else 'N/A'))
        ctk.CTkLabel(self, textvariable=num_req, font=("", 12)).grid(row=7, column=1, padx=10, pady=(20, 0), sticky="w")

        equip_avail = StringVar(value=str(Equipment.avail_equipments()[0] if DataBase.conn is not None else 'N/A'))
        ctk.CTkLabel(self, textvariable=equip_avail, font=("", 12)).grid(row=10, column=1, padx=10, pady=(20, 0),
                                                                         sticky="w")

        equip_total = StringVar(value=str(len(Equipment.get_all_equipments()) if DataBase.conn is not None else 'N/A'))
        ctk.CTkLabel(self, textvariable=equip_total, font=("", 12)).grid(row=13, column=1, padx=10, pady=(20, 0),
                                                                         sticky="w")

        users = StringVar(value=str(len(UserDI.get_users()) if DataBase.conn is not None else 'N/A'))
        ctk.CTkLabel(self, textvariable=users, font=("", 12)).grid(row=16, column=1, padx=10, pady=(20, 0), sticky="w")
