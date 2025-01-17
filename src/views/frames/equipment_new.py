import customtkinter as ctk

from enums.equipmentCategory import EquipmentCategory
from models import Equipment


class FrameEquipmentNew(ctk.CTkFrame):
    def __init__(self, parent):
        super().__init__(parent, corner_radius=0, fg_color="#EBF3FA")

        self.button = None

        self.category = None
        self.combo = None
        self.category_error = None

        self.name = None
        self.name_error = None

        self.reload()

    def reload(self) -> None:
        for widget in self.winfo_children():
            widget.destroy()

        # Page title
        title = ctk.CTkLabel(self, text="Adicionar Equipamento", text_color="#20558A", font=("", 20, 'bold'))
        title.grid(row=0, column=0, padx=20, pady=(30, 40), sticky="w")

        # Name field
        ctk.CTkLabel(self, text="Nome").grid(row=1, column=0, padx=20, pady=(20, 0), sticky="w")
        self.name = ctk.CTkEntry(self, width=200)
        self.name.grid(row=2, column=0, pady=(3, 0), padx=20, sticky="w")
        self.name_error = ctk.CTkLabel(self, text="", text_color="red")
        self.name_error.grid(row=3, column=0, pady=0, padx=20, sticky="w")

        # Category field
        ctk.CTkLabel(self, text="Categoria").grid(row=1, column=3, padx=20, pady=(20, 0), sticky="w")

        self.category = ctk.StringVar(self, EquipmentCategory.all.value)

        self.combo = ctk.CTkComboBox(self, values=EquipmentCategory.get_categories(), variable=self.category, width=200)
        self.combo.grid(row=2, column=3, pady=(3, 0), padx=20, sticky="w")
        self.category_error = ctk.CTkLabel(self, text="", text_color="red")
        self.category_error.grid(row=3, column=3, pady=0, padx=20, sticky="w")

        # Submit button
        self.button = ctk.CTkButton(self, text="Submeter", command=self.submit, width=200)
        self.button.grid(row=10, column=3, pady=0, padx=20, sticky="w")

    def submit(self) -> None:
        """
        Submits the form.
        """
        if self.is_valid():
            Equipment.add_equipment(self.name.get(), self.category.get())
            self.reload()

    def is_valid(self) -> bool:
        """
        Verify if the form data is valid.
        :return: True if valid, False otherwise.
        """
        valid = True

        if self.category.get() == EquipmentCategory.all.value:
            self.category_error.configure(text="Deve selecionar uma categoria.")
            self.combo.configure(border_color="red")
            valid = False
        else:
            self.category_error.configure(text="")
            self.combo.configure(border_color="#979DA2")

        return valid
