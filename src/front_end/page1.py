import customtkinter as ctk
from CTkDatePicker import CTkDatePicker

class Page1:
    def __init__(self, tabview, tab):
        self.tabview = tabview
        self.tab = tab
        
        self.build_page()
        
    def button_function(self):
        self.tabview.set("tab 2")

    def build_page(self):
        main = ctk.CTkFrame(master=self.tab) 
        main.pack(side=ctk.TOP, padx=10, pady=10, anchor='nw', fill="both", expand=True)

        # Nome
        name_frame = ctk.CTkFrame(master=main)  # Sub-frame para organizar melhor
        name_frame.pack(side=ctk.TOP, padx=10, pady=10, fill="x")

        labelName = ctk.CTkLabel(master=name_frame, text="Nome: ")
        labelName.pack(side=ctk.LEFT, padx=10, pady=10)

        entryName = ctk.CTkEntry(master=name_frame, placeholder_text="Insira o seu Nome")
        entryName.pack(side=ctk.LEFT, padx=10, pady=10)

        # Data
        date_frame = ctk.CTkFrame(master=main)  # Sub-frame para organizar melhor
        date_frame.pack(side=ctk.TOP, padx=10, pady=10, fill="x")

        labelDate = ctk.CTkLabel(master=date_frame, text="Data: ")
        labelDate.pack(side=ctk.LEFT, padx=10, pady=10)

        entryDate = CTkDatePicker(date_frame)
        entryDate.pack(side=ctk.LEFT, padx=10, pady=10)

        # Botão
        button = ctk.CTkButton(master=main, text="CTkButton", command=self.button_function)
        button.pack(side=ctk.BOTTOM, pady=20)  # Centralizar no final do frame

        return main
