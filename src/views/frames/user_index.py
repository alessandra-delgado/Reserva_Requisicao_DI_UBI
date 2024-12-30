import customtkinter as ctk
from models import UserDI


class FrameUserIndex(ctk.CTkFrame):
    def __init__(self, parent):
        super().__init__(parent, corner_radius=0, fg_color="#EBF3FA")
        self.grid_columnconfigure(0, weight=1)
        self.grid_rowconfigure(1, weight=1)
        # Important: columns amount
        self.cols = 6

        # Page title
        title = ctk.CTkLabel(self, text="Lista de Utilizadores", text_color="#20558A", font=("", 20, 'bold'))
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

        users = UserDI.get_users()

        # Table header
        l = ctk.CTkLabel(self.scrollableFrame, text="ID", text_color="#545F71", font=("", 12, "bold"), anchor="center")
        l.grid(row=1, column=0, padx=5, pady=15, sticky="nsew")
        l = ctk.CTkLabel(self.scrollableFrame, text="Tipo de Utilizador", text_color="#545F71", font=("", 12, "bold"),
                         anchor="center")
        l.grid(row=1, column=1, padx=5, pady=15, sticky="nsew")
        l = ctk.CTkLabel(self.scrollableFrame, text="Nome", text_color="#545F71", font=("", 12, "bold"),
                         anchor="center")
        l.grid(row=1, column=2, padx=5, pady=20, sticky="nsew")
        l = ctk.CTkLabel(self.scrollableFrame, text="Prioridade", text_color="#545F71", font=("", 12, "bold"),
                         anchor="center")
        l.grid(row=1, column=3, padx=5, pady=20, sticky="nsew")
        l = ctk.CTkLabel(self.scrollableFrame, text="Telemóvel", text_color="#545F71", font=("", 12, "bold"),
                         anchor="center")
        l.grid(row=1, column=4, padx=5, pady=20, sticky="nsew")

        self.add_divider(2)

        # Table Rows
        i = 2
        for user in users:
            i += 1

            l = ctk.CTkLabel(self.scrollableFrame, text=user[0], text_color="#545F71", anchor="center")
            l.grid(row=i, column=0, padx=5, pady=7, sticky="nsew")
            l = ctk.CTkLabel(self.scrollableFrame, text=user[1], text_color="#545F71", anchor="center")
            l.grid(row=i, column=1, padx=5, pady=7, sticky="nsew")
            l = ctk.CTkLabel(self.scrollableFrame, text=user[2], text_color="#545F71", anchor="center")
            l.grid(row=i, column=2, padx=5, pady=7, sticky="nsew")
            l = ctk.CTkLabel(self.scrollableFrame, text=user[3], text_color="#545F71", anchor="center")
            l.grid(row=i, column=3, padx=5, pady=7, sticky="nsew")
            l = ctk.CTkLabel(self.scrollableFrame, text=user[4], text_color="#545F71", anchor="center")
            l.grid(row=i, column=4, padx=5, pady=7, sticky="nsew")
            button = ctk.CTkButton(self.scrollableFrame, height=40, width=60, text="Editar",
                                   text_color="#ffffff", hover_color="#6DA5DE")
            button.grid(row=i, column=5, padx=5, pady=7)

            i += 1
            self.add_divider(i)

    # well, it is a divider
    def add_divider(self, i) -> None:
        div = ctk.CTkFrame(self.scrollableFrame, height=1, bg_color="#B3CBE5")
        div.grid(row=i, column=0, columnspan=self.cols, sticky="sew")
