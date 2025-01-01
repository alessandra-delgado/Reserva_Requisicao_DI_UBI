import customtkinter as ctk
from customtkinter import CTkButton

from enums.requisitionStatus import RequisitionStatus
from models import Requisition
from views.frames import requisition_edit


class FrameRequisitionIndex(ctk.CTkFrame):
    def __init__(self, parent):
        super().__init__(parent, corner_radius=0, fg_color="#EBF3FA")
        self.grid_columnconfigure(0, weight=1)
        self.grid_rowconfigure(1, weight=1)

        # Cols
        self.cols = 8
        self.frame_edit = None
        self.parent = parent

        # Page title
        title = ctk.CTkLabel(self, text="Lista de Requisições", text_color="#20558A", font=("", 20, 'bold'))
        title.grid(row=0, column=0, padx=20, pady=(30, 40), sticky="w")

        # Table frame
        self.scrollableFrame = ctk.CTkScrollableFrame(self, fg_color="#FFFFFF")
        self.scrollableFrame.grid(row=1, column=0, sticky="nsew", padx=30, pady=50)
        for i in range(self.cols):
            self.scrollableFrame.grid_columnconfigure(i, weight=1)

        # Load table data
        self.reload()

    def reload(self) -> None:
        """ Used by app.py to reload page data. """
        for widget in self.scrollableFrame.winfo_children():
            widget.destroy()

        requisitions = Requisition.get_requisitions()

        # Table header
        l = ctk.CTkLabel(self.scrollableFrame, text="ID", text_color="#545F71", font=("", 12, "bold"), anchor="center")
        l.grid(row=1, column=0, padx=5, pady=15, sticky="nsew")
        l = ctk.CTkLabel(self.scrollableFrame, text="Utilizador", text_color="#545F71", font=("", 12, "bold"), anchor="center")
        l.grid(row=1, column=1, padx=5, pady=15, sticky="nsew")
        l = ctk.CTkLabel(self.scrollableFrame, text="Data de Início", text_color="#545F71", font=("", 12, "bold"), anchor="center")
        l.grid(row=1, column=2, padx=5, pady=20, sticky="nsew")
        l = ctk.CTkLabel(self.scrollableFrame, text="Data de Devolução", text_color="#545F71", font=("", 12, "bold"), anchor="center")
        l.grid(row=1, column=3, padx=5, pady=20, sticky="nsew")
        l = ctk.CTkLabel(self.scrollableFrame, text="Devolvido", text_color="#545F71", font=("", 12, "bold"), anchor="center")
        l.grid(row=1, column=4, padx=5, pady=20, sticky="nsew")
        l = ctk.CTkLabel(self.scrollableFrame, text="Levantado", text_color="#545F71", font=("", 12, "bold"), anchor="center")
        l.grid(row=1, column=5, padx=5, pady=20, sticky="nsew")
        l = ctk.CTkLabel(self.scrollableFrame, text="Estado", text_color="#545F71", font=("", 12, "bold"), anchor="center")
        l.grid(row=1, column=6, padx=5, pady=20, sticky="nsew")

        self.add_divider(2)

        date_format = "%d-%m-%Y %H:%M"

        # Table Rows
        i = 2
        for requisition in requisitions:
            i += 1

            l = ctk.CTkLabel(self.scrollableFrame, text=requisition[0], text_color="#545F71", anchor="center")
            l.grid(row=i, column=0, padx=5, pady=7, sticky="nsew")
            l = ctk.CTkLabel(self.scrollableFrame, text=requisition[1], text_color="#545F71", anchor="center")
            l.grid(row=i, column=1, padx=5, pady=7, sticky="nsew")
            l = ctk.CTkLabel(self.scrollableFrame, text=requisition[3].strftime(date_format), text_color="#545F71", anchor="center")
            l.grid(row=i, column=2, padx=5, pady=7, sticky="nsew")
            l = ctk.CTkLabel(self.scrollableFrame, text=requisition[4].strftime(date_format), text_color="#545F71", anchor="center")
            l.grid(row=i, column=3, padx=5, pady=7, sticky="nsew")
            l = ctk.CTkLabel(self.scrollableFrame, text=requisition[5], text_color="#545F71", anchor="center")
            l.grid(row=i, column=4, padx=5, pady=7, sticky="nsew")
            l = ctk.CTkLabel(self.scrollableFrame, text=requisition[6], text_color="#545F71", anchor="center")
            l.grid(row=i, column=5, padx=5, pady=7, sticky="nsew")
            l = ctk.CTkLabel(self.scrollableFrame, text=RequisitionStatus.label(requisition[2]), text_color="#545F71", anchor="center")
            l.grid(row=i, column=6, padx=5, pady=7, sticky="nsew")

            if RequisitionStatus.can_edit(requisition[2]) and not requisition[5]:
                l = self.add_button(requisition[0])
                l.grid(row=i, column=7, padx=5, pady=7)

            i += 1
            self.add_divider(i)

    # well, it simulates a divider...
    def add_divider(self, i) -> None:
        div = ctk.CTkFrame(self.scrollableFrame, height=1, bg_color="#B3CBE5")
        div.grid(row=i, column=0, columnspan=self.cols, sticky="sew")

    def add_button(self, requisition_id) -> CTkButton:
        return ctk.CTkButton(self.scrollableFrame, height=40, width=60, text="Editar", text_color="#ffffff",
                             hover_color="#6DA5DE", command=lambda: self.edit(requisition_id))

    def delete_dependent(self):
        if self.frame_edit is not None:
            self.frame_edit.grid_forget()

    def edit(self, reserve_id) -> None:
        self.grid_forget()

        self.frame_edit = requisition_edit.FrameRequisitionEdit(self.parent, reserve_id, self)
        self.frame_edit.grid(row=0, column=1, sticky="nsew")
