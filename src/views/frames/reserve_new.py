import customtkinter as ctk
from models import Reservation, UserDI


class FrameReserveNew(ctk.CTkFrame):
    def __init__(self, parent):
        super().__init__(parent, corner_radius=0, fg_color="#EBF3FA")

        users = [u[0] + " - " + u[2] for u in UserDI.get_users()]

        # Page title
        title = ctk.CTkLabel(self, text="Criação de Reserva", text_color="#20558A", font=("", 20, 'bold'))
        title.grid(row=0, column=0, padx=20, pady=(30, 40), sticky="w")

        # Var used by CTkComboBox to store selected value. Default it to first entry
        self.user = ctk.StringVar(self, users[0])

        # User field
        ctk.CTkLabel(self, text="Utilizador").grid(row=1, column=0, padx=20, pady=(20, 0), sticky="w")
        self.combo = ctk.CTkComboBox(self, values=users, variable=self.user, width=300)
        self.combo.bind('<KeyRelease>', self.filter_users)
        #  ^^^ faz bind de um evento: quando largo uma qualquer tecla chama o filter_users
        self.combo.grid(row=2, column=0, pady=(3, 0), padx=20, sticky="w")


        # PickStartDate field
        ctk.CTkLabel(self, text="Data de Início").grid(row=1, column=3, padx=20, pady=(20, 0), sticky="w")
        self.id = ctk.CTkEntry(self, width=200)
        self.id.grid(row=2, column=3, pady=(3, 0), padx=20, sticky="w")
        self.id_error = ctk.CTkLabel(self, text="", text_color="red")
        self.id_error.grid(row=3, column=3, pady=0, padx=20, sticky="w")

        # PickEndDate field
        ctk.CTkLabel(self, text="Data de Fim").grid(row=5, column=0, padx=20, pady=(20, 0), sticky="w")
        self.id = ctk.CTkEntry(self, width=200)
        self.id.grid(row=2, column=3, pady=(3, 0), padx=20, sticky="w")
        self.id_error = ctk.CTkLabel(self, text="", text_color="red")
        self.id_error.grid(row=3, column=3, pady=0, padx=20, sticky="w")

        # Select equipments field

        # Submit button
        self.button = ctk.CTkButton(self, text="Submeter", command=self.submit, width=200)
        self.button.grid(row=10, column=3, pady=0, padx=20, sticky="s")

    def filter_users(self, event):
        # Recebe o evento
        # O evento diz qual o tipo de evento e onde ocorreu
        value = event.widget.get() # o evento ocorreu no widget combox, o valor é o que o utilizador escreveu

        users = UserDI.get_users()
        # Criar nova lista de utilizadores (a outra pode já estar desatualizada)

        if value == '':
            users = [u[0] + " - " + u[2] for u in users]
            self.combo.configure(values=users)
        else:
            data = []
            for user in users:
                for i, field in enumerate(user): # Ignorar os campos de prioridade, hit e miss para cada linha
                    if i in [3, 5, 6]:
                        continue

                    if value.lower() in str(field).lower() : # Para poder fazer a verificação de forma mais eficiente
                        data.append(user[0] + " - " + user[2])
                        # Se a string inserida está contida num registo da lista users,
                        # adicionamos esse registo à lista filtrada

            self.combo.configure(values=data) # Configuramos a combobox com os dados filtrados


    def submit(self) -> None:
        """
        Submits the form.
        """
        # Reservation.add_reservation()
