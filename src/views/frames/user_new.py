import customtkinter as ctk
from models import UserPriority
from models import UserDI


class FrameUserNew(ctk.CTkFrame):
    def __init__(self, parent):
        super().__init__(parent, corner_radius=0, fg_color="#EBF3FA")
        self.button = None

        self.email = None
        self.email_error = None

        self.cellphone = None
        self.cellphone_error = None

        self.id = None
        self.id_error = None

        self.name = None
        self.name_error = None

        self.user_type = None

        self.reload()

    def reload(self) -> None:
        """ Used by app.py to reload page data. """
        for widget in self.winfo_children():
            widget.destroy()

        # Page title
        title = ctk.CTkLabel(self, text="Criação de Utilizador", text_color="#20558A", font=("", 20, 'bold'))
        title.grid(row=0, column=0, padx=20, pady=(30, 40), sticky="w")

        user_priorities = UserPriority.get_user_priorities()

        # Var used by CTkComboBox to store selected value. Default it to first entry
        self.user_type = ctk.StringVar(self, user_priorities[0])

        # Name field
        ctk.CTkLabel(self, text="Nome").grid(row=1, column=0, padx=20, pady=(20, 0), sticky="w")
        self.name = ctk.CTkEntry(self, width=200)
        self.name.grid(row=2, column=0, pady=(3, 0), padx=20, sticky="w")
        self.name_error = ctk.CTkLabel(self, text="", text_color="red")
        self.name_error.grid(row=3, column=0, pady=0, padx=20, sticky="w")

        # ID field
        ctk.CTkLabel(self, text="ID").grid(row=1, column=3, padx=20, pady=(20, 0), sticky="w")
        self.id = ctk.CTkEntry(self, width=200)
        self.id.grid(row=2, column=3, pady=(3, 0), padx=20, sticky="w")
        self.id_error = ctk.CTkLabel(self, text="", text_color="red")
        self.id_error.grid(row=3, column=3, pady=0, padx=20, sticky="w")

        # Type field
        ctk.CTkLabel(self, text="Tipo de Utilizador").grid(row=5, column=0, padx=20, pady=(20, 0), sticky="w")
        combo = ctk.CTkComboBox(self, values=user_priorities, variable=self.user_type, width=200)
        combo.grid(row=6, column=0, pady=(3, 0), padx=20, sticky="w")

        # Cellphone field
        ctk.CTkLabel(self, text="Telemóvel").grid(row=5, column=3, padx=20, pady=(20, 0), sticky="w")
        self.cellphone = ctk.CTkEntry(self, width=200)
        self.cellphone.grid(row=6, column=3, pady=(3, 0), padx=20, sticky="w")
        self.cellphone_error = ctk.CTkLabel(self, text="", text_color="red")
        self.cellphone_error.grid(row=7, column=3, pady=0, padx=20, sticky="w")

        # Email field
        ctk.CTkLabel(self, text="Email").grid(row=9, column=0, padx=20, pady=(20, 0), sticky="w")
        self.email = ctk.CTkEntry(self, width=200)
        self.email.grid(row=10, column=0, pady=(3, 0), padx=20, sticky="w")
        self.email_error = ctk.CTkLabel(self, text="", text_color="red")
        self.email_error.grid(row=11, column=0, pady=0, padx=20, sticky="w")

        # Submit button
        self.button = ctk.CTkButton(self, text="Submeter", command=self.submit, width=200)
        self.button.grid(row=10, column=3, pady=0, padx=20, sticky="s")

    def submit(self) -> None:
        """
        Submits the form.
        """
        if self.is_valid():
            UserDI.add_user(self.id.get(), self.name.get(), self.user_type.get(), self.email.get(),
                            self.cellphone.get())
            self.reload()

    def is_valid(self) -> bool:
        """
        Verify if the form data is valid.
        :return: True if valid, False otherwise.
        """
        # todo: validate if user id and phone number are unique before insert
        valid = True
        # Validate name
        if self.name.get() == "" or len(self.name.get()) > 50:
            valid = False
            self.name_error.configure(text="Nome inválido.")
            self.name.configure(border_color="red")
        else:
            self.name_error.configure(text="")
            self.name.configure(border_color="#979DA2")

        # Validate id
        if self.id.get() == "" or len(self.id.get()) > 7:
            valid = False
            self.id_error.configure(text="ID inválido.")
            self.id.configure(border_color="red")
        else:
            self.id_error.configure(text="")
            self.id.configure(border_color="#979DA2")

        # Validate cellphone
        if not self.cellphone.get().isnumeric() or len(self.cellphone.get()) != 9:
            valid = False
            self.cellphone_error.configure(text="Número inválido.")
            self.cellphone.configure(border_color="red")
        else:
            self.cellphone_error.configure(text="")
            self.cellphone.configure(border_color="#979DA2")

        # Validate email
        if self.email.get() != "" and (
                not self.email.get().endswith("@ubi.pt") and not self.email.get().endswith("@di.ubi.pt")):
            valid = False
            self.email_error.configure(text="Introduza um email da UBI.")
            self.email.configure(border_color="red")
        else:
            self.email_error.configure(text="")
            self.email.configure(border_color="#979DA2")

        return valid
