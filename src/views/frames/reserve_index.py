from datetime import datetime

import customtkinter as ctk

from enums.reservationStatus import ReservationStatus
from models import Reservation


class FrameReserveIndex(ctk.CTkFrame):
    def __init__(self, parent):
        super().__init__(parent, corner_radius=0, fg_color="#EBF3FA")
        self.grid_columnconfigure(0, weight=1)
        self.grid_rowconfigure(1, weight=1)

        # Page title
        title = ctk.CTkLabel(self, text="Lista de Reservas", text_color="#20558A", font=("", 20, 'bold'))
        title.grid(row=0, column=0, padx=20, pady=(30, 40), sticky="w")

        # Table frame
        self.scrollableFrame = ctk.CTkScrollableFrame(self, fg_color="#FFFFFF")
        self.scrollableFrame.grid(row=1, column=0, sticky="nsew", padx=30, pady=50)
        self.scrollableFrame.grid_columnconfigure(6, weight=1)

        # Load table data
        self.reload()

    def reload(self) -> None:
        """ Used by app.py to reload page data. """
        reservations = Reservation.get_reservations()

        # Table header
        l = ctk.CTkLabel(self.scrollableFrame, text="ID", text_color="#545F71", font=("", 12, "bold"))
        l.grid(row=1, column=0, padx=5, pady=15, sticky="w")
        l = ctk.CTkLabel(self.scrollableFrame, text="Utilizador", text_color="#545F71", font=("", 12, "bold"))
        l.grid(row=1, column=1, padx=5, pady=15, sticky="w")
        l = ctk.CTkLabel(self.scrollableFrame, text="Data de Registo", text_color="#545F71", font=("", 12, "bold"))
        l.grid(row=1, column=2, padx=5, pady=20, sticky="w")
        l = ctk.CTkLabel(self.scrollableFrame, text="Data de Início", text_color="#545F71", font=("", 12, "bold"))
        l.grid(row=1, column=3, padx=5, pady=20, sticky="w")
        l = ctk.CTkLabel(self.scrollableFrame, text="Data de Devolução", text_color="#545F71", font=("", 12, "bold"))
        l.grid(row=1, column=4, padx=5, pady=20, sticky="w")
        l = ctk.CTkLabel(self.scrollableFrame, text="Estado", text_color="#545F71", font=("", 12, "bold"))
        l.grid(row=1, column=5, padx=5, pady=20, sticky="w")

        self.add_divider(2)

        date_format = "%d-%m-%Y %H:%M"

        # Table Rows
        i = 2
        for reservation in reservations:
            i += 1

            l = ctk.CTkLabel(self.scrollableFrame, text=reservation[0], text_color="#545F71")
            l.grid(row=i, column=0, padx=5, pady=7, sticky="w")
            l = ctk.CTkLabel(self.scrollableFrame, text=reservation[1], text_color="#545F71")
            l.grid(row=i, column=1, padx=5, pady=7, sticky="w")
            l = ctk.CTkLabel(self.scrollableFrame, text= reservation[2].strftime(date_format), text_color="#545F71")
            l.grid(row=i, column=2, padx=5, pady=7, sticky="w")
            l = ctk.CTkLabel(self.scrollableFrame, text=reservation[3].strftime(date_format), text_color="#545F71")
            l.grid(row=i, column=3, padx=5, pady=7, sticky="w")
            l = ctk.CTkLabel(self.scrollableFrame, text=reservation[4].strftime(date_format), text_color="#545F71")
            l.grid(row=i, column=4, padx=5, pady=7, sticky="w")
            l = ctk.CTkLabel(self.scrollableFrame, text= ReservationStatus.label(reservation[5]), text_color="#545F71")
            l.grid(row=i, column=5, padx=5, pady=7, sticky="w")

            i += 1
            self.add_divider(i)

    # well, it simulates a divider...
    def add_divider(self, i) -> None:
        ctk.CTkFrame(self.scrollableFrame, width=110, height=1, bg_color="#B3CBE5").grid(row=i, column=0, sticky="s")
        ctk.CTkFrame(self.scrollableFrame, width=130, height=1, bg_color="#B3CBE5").grid(row=i, column=1, sticky="s")
        ctk.CTkFrame(self.scrollableFrame, width=150, height=1, bg_color="#B3CBE5").grid(row=i, column=2, sticky="s")
        ctk.CTkFrame(self.scrollableFrame, width=130, height=1, bg_color="#B3CBE5").grid(row=i, column=3, sticky="s")
        ctk.CTkFrame(self.scrollableFrame, width=130, height=1, bg_color="#B3CBE5").grid(row=i, column=4, sticky="s")
        ctk.CTkFrame(self.scrollableFrame, width=130, height=1, bg_color="#B3CBE5").grid(row=i, column=5, sticky="s")
