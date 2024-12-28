import customtkinter as ctk


class FrameRequisitionIndex(ctk.CTkFrame):
    def __init__(self, parent):
        super().__init__(parent, corner_radius=0, fg_color="#EBF3FA")

        # Page title
        title = ctk.CTkLabel(self, text="Lista de Requisições", text_color="#20558A", font=("", 20, 'bold'))
        title.grid(row=0, column=0, padx=20, pady=(30, 40), sticky="w")