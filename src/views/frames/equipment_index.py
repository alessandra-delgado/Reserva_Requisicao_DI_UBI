import customtkinter as ctk

from enums.equipmentCategory import EquipmentCategory
from enums.equipmentStatus import EquipmentStatus
from models import Equipment


class FrameEquipmentIndex(ctk.CTkFrame):
    def __init__(self, parent):
        super().__init__(parent, corner_radius=0, fg_color="#EBF3FA")
        self.grid_columnconfigure(0, weight=1)
        self.grid_rowconfigure(1, weight=1)

        # Page title
        title = ctk.CTkLabel(self, text="Lista de Equipamentos", text_color="#20558A", font=("", 20, 'bold'))
        title.grid(row=0, column=0, padx=20, pady=(30, 40), sticky="w")

        # Table frame
        self.scrollableFrame = ctk.CTkScrollableFrame(self, fg_color="#FFFFFF")
        self.scrollableFrame.grid(row=1, column=0, sticky="nsew", padx=30, pady=50)
        self.scrollableFrame.grid_columnconfigure(4, weight=1)

        # Load table data
        self.reload()

    def reload(self) -> None:
        """ Used by app.py to reload page data. """
        equipments = Equipment.get_equipments(EquipmentCategory.all.value)

        # Table header
        l = ctk.CTkLabel(self.scrollableFrame, text="ID", text_color="#545F71", font=("", 12, "bold"))
        l.grid(row=1, column=0, padx=5, pady=15, sticky="w")
        l = ctk.CTkLabel(self.scrollableFrame, text="Nome", text_color="#545F71", font=("", 12, "bold"))
        l.grid(row=1, column=1, padx=5, pady=15, sticky="w")
        l = ctk.CTkLabel(self.scrollableFrame, text="Categoria", text_color="#545F71", font=("", 12, "bold"))
        l.grid(row=1, column=2, padx=5, pady=20, sticky="w")
        l = ctk.CTkLabel(self.scrollableFrame, text="Estado", text_color="#545F71", font=("", 12, "bold"))
        l.grid(row=1, column=3, padx=5, pady=20, sticky="w")
        self.add_divider(2)
        # Table Rows
        i = 2
        for equipment in equipments:
            i += 1

            l = ctk.CTkLabel(self.scrollableFrame, text=equipment[0], text_color="#545F71")
            l.grid(row=i, column=0, padx=5, pady=7, sticky="w")
            l = ctk.CTkLabel(self.scrollableFrame, text=equipment[2], text_color="#545F71")
            l.grid(row=i, column=1, padx=5, pady=7, sticky="w")
            l = ctk.CTkLabel(self.scrollableFrame, text= equipment[3], text_color="#545F71")
            l.grid(row=i, column=2, padx=5, pady=7, sticky="w")
            l = ctk.CTkLabel(self.scrollableFrame, text=EquipmentStatus.label(equipment[1]), text_color="#545F71")
            l.grid(row=i, column=3, padx=5, pady=7, sticky="w")

            i += 1
            self.add_divider(i)

    # well, it simulates a divider...
    def add_divider(self, i) -> None:
        ctk.CTkFrame(self.scrollableFrame, width=130, height=1, bg_color="#B3CBE5").grid(row=i, column=0, sticky="s")
        ctk.CTkFrame(self.scrollableFrame, width=140, height=1, bg_color="#B3CBE5").grid(row=i, column=1, sticky="s")
        ctk.CTkFrame(self.scrollableFrame, width=150, height=1, bg_color="#B3CBE5").grid(row=i, column=2, sticky="s")
        ctk.CTkFrame(self.scrollableFrame, width=130, height=1, bg_color="#B3CBE5").grid(row=i, column=3, sticky="s")
