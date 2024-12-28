
import customtkinter as ctk
from tktimepicker import constants, SpinTimePickerModern, SpinTimePickerOld

from models import Reservation, UserDI, Equipment
from views.widgets.ctk_date_picker import CTkDatePicker


class FrameReserveNew(ctk.CTkScrollableFrame):
    def __init__(self, parent):
        super().__init__(parent, corner_radius=0, fg_color="#EBF3FA")

        users = [u[0] + " - " + u[2] for u in UserDI.get_users()]

        # Page title
        title = ctk.CTkLabel(self, text="Criação de Reserva", text_color="#20558A", font=("", 20, 'bold'))
        title.grid(row=0, column=0, padx=20, pady=(30, 40), sticky="w")

        # Var used by CTkComboBox to store selected value. Default it to first entry
        self.user = ctk.StringVar(self, users[0])

        self.equipments = []

        # User field
        ctk.CTkLabel(self, text="Utilizador").grid(row=1, column=0, padx=20, pady=(20, 0), sticky="w")
        self.combo = ctk.CTkComboBox(self, values=users, variable=self.user, width=300)
        self.combo.bind('<KeyRelease>', self.filter_users)
        #  ^^^ faz bind de um evento: quando largo uma qualquer tecla chama o filter_users
        self.combo.grid(row=2, column=0, pady=(3, 0), padx=20, sticky="w")
        self.combo_error = ctk.CTkLabel(self, text="", text_color="red")
        self.combo_error.grid(row=3, column=0, pady=0, padx=20, sticky="w")

        # PickStartDate field
        ctk.CTkLabel(self, text="Data de Início").grid(row=5, column=0, padx=20, pady=(20, 0), sticky="w")
        self.date_start = CTkDatePicker(self, width=200)
        self.date_start.grid(row=6, column=0, padx=20, pady=(3, 0), sticky="w")
        self.date_start_error = ctk.CTkLabel(self, text="", text_color="red")
        self.date_start_error.grid(row=7, column=0, pady=0, padx=20, sticky="w")

        # PickStartTime field
        ctk.CTkLabel(self, text="Hora de Inicio").grid(row=5, column=3, padx=20, pady=(20, 0), sticky="w")
        self.time_start = SpinTimePickerOld(self)
        self.time_start.addAll(constants.HOURS24)
        self.time_start.grid(row=6, column=3, padx=20, pady=(3, 0), sticky="w")

        # PickEndDate field
        ctk.CTkLabel(self, text="Data de Fim").grid(row=8, column=0, padx=20, pady=(20, 0), sticky="w")
        self.date_end = CTkDatePicker(self, width=200)
        self.date_end.grid(row=9, column=0, padx=20, pady=(3, 0), sticky="w")
        self.date_end_error = ctk.CTkLabel(self, text="", text_color="red")
        self.date_end_error.grid(row=10, column=0, pady=0, padx=20, sticky="w")

        # PickStartTime field
        ctk.CTkLabel(self, text="Hora de Fim").grid(row=8, column=3, padx=20, pady=(20, 0), sticky="w")
        self.time_start = SpinTimePickerOld(self)
        self.time_start.addAll(constants.HOURS24)
        self.time_start.grid(row=9, column=3, padx=20, pady=(3, 0), sticky="w")

        # Select equipments field
        self.scrollableFrame = ctk.CTkScrollableFrame(self, fg_color="#FFFFFF")
        self.scrollableFrame.grid(row=10, column=0, sticky="nsew", padx=30, pady=50)
        self.scrollableFrame.grid_columnconfigure(3, weight = 1)

        self.reload()

        # Submit button
        self.button = ctk.CTkButton(self, text="Submeter", command=self.submit, width=200)
        self.button.grid(row=12, column=3, pady=0, padx=20, sticky="s")

    def reload(self) -> None:
        """ Used by app.py to reload page data. """
        equipments = Equipment.get_equipments()

        # todo: make a combobox for category and load
        #  equipments from that category, or put all
        #  (select from equip where category in (...))

        # Table header
        l = ctk.CTkLabel(self.scrollableFrame, text="", text_color="#545F71", font=("", 12, "bold"))
        l.grid(row=1, column=1, padx=5, pady=15, sticky="w")
        l = ctk.CTkLabel(self.scrollableFrame, text="Equipamento", text_color="#545F71", font=("", 12, "bold"))
        l.grid(row=1, column=0, padx=5, pady=15, sticky="w")
        l = ctk.CTkLabel(self.scrollableFrame, text="Essencial", text_color="#545F71", font=("", 12, "bold"))
        l.grid(row=1, column=2, padx=5, pady=20, sticky="w")

        self.add_divider(2)
        # Table Rows
        i = 2
        for equipment in equipments:
            i += 1

            l = ctk.CTkCheckBox(self.scrollableFrame, text=equipment[2], text_color="#545F71")
            l.grid(row=i, column=0, padx=5, pady=7, sticky="w")
            l = ctk.CTkCheckBox(self.scrollableFrame, text='Essencial', text_color="#545F71")
            l.grid(row=i, column=1, padx=5, pady=7, sticky="w")

            i += 1
            self.add_divider(i)

    # well, it simulates a divider...
    def add_divider(self, i) -> None:
        ctk.CTkFrame(self.scrollableFrame, width=110, height=1, bg_color="#B3CBE5").grid(row=i, column=0, sticky="s")
        ctk.CTkFrame(self.scrollableFrame, width=130, height=1, bg_color="#B3CBE5").grid(row=i, column=1, sticky="s")
        ctk.CTkFrame(self.scrollableFrame, width=150, height=1, bg_color="#B3CBE5").grid(row=i, column=2, sticky="s")


    def filter_users(self, event):
        # Recebe o evento
        # O evento diz qual o tipo de evento e onde ocorreu
        value = event.widget.get()  # o evento ocorreu no widget combox, o valor é o que o utilizador escreveu

        users = UserDI.get_users()
        # Criar nova lista de utilizadores (a outra pode já estar desatualizada)

        if value == '':
            users = [u[0] + " - " + u[2] for u in users]
            self.combo.configure(values=users)
        else:
            data = []
            for user in users:
                for i, field in enumerate(user):  # Ignorar os campos de prioridade, hit e miss para cada linha
                    if i in [3, 5, 6]:
                        continue

                    if value.lower() in str(field).lower():  # Para poder fazer a verificação de forma mais eficiente
                        data.append(user[0] + " - " + user[2])
                        break
                        # Se a string inserida está contida num registo da lista users,
                        # adicionamos esse registo à lista filtrada

            self.combo.configure(values=data)  # Configuramos a combobox com os dados filtrados

    def submit(self) -> None:
        """
        Submits the form.
        """
        # Reservation.add_reservation()
