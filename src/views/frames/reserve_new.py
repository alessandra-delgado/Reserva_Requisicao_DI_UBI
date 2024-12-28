from datetime import datetime

import customtkinter as ctk
from tktimepicker import constants, SpinTimePickerModern, SpinTimePickerOld

from enums.equipmentCategory import EquipmentCategory
from enums.reservationEquipmentType import ReservationEquipmentType
from models import Reservation, UserDI, Equipment
from views.widgets.ctk_date_picker import CTkDatePicker


class FrameReserveNew(ctk.CTkScrollableFrame):
    def __init__(self, parent):
        super().__init__(parent, corner_radius=0, fg_color="#EBF3FA")
        self.grid_columnconfigure(0, weight=1)
        self.grid_rowconfigure(1, weight=1)

        # This page is divided in two frames
        # The first frame (form_frame) is directed to TblReservation ------------------------------------------------------------
        self.form_frame = ctk.CTkFrame(self, fg_color="#EBF3FA")
        self.form_frame.grid(row=0, column=0, sticky="nsew")

        # Page title
        title = ctk.CTkLabel(self.form_frame, text="Criação de Reserva", text_color="#20558A", font=("", 20, 'bold'))
        title.grid(row=0, column=0, padx=20, pady=(30, 40), sticky="w")

        # Select all users from database
        users = [u[0] + " - " + u[2] for u in UserDI.get_users()]
        # Var used by CTkComboBox to store selected value. Default it to first entry
        self.user = ctk.StringVar(self.form_frame, users[0])

        # User field
        ctk.CTkLabel(self.form_frame, text="Utilizador").grid(row=1, column=0, padx=20, pady=(20, 0), sticky="w")
        self.combo = ctk.CTkComboBox(self.form_frame, values=users, variable=self.user, width=300)
        self.combo.bind('<KeyRelease>', self.filter_users)
        #  ^^^ faz bind de um evento: quando largo uma qualquer tecla chama o filter_users
        self.combo.grid(row=2, column=0, pady=(3, 0), padx=20, sticky="w")
        self.combo_error = ctk.CTkLabel(self.form_frame, text="", text_color="red")
        self.combo_error.grid(row=3, column=0, pady=0, padx=20, sticky="w")

        # DATETIME pickers -----------------------------------------------------------------------------
        # PickStartDate field
        ctk.CTkLabel(self.form_frame, text="Data de Início").grid(row=5, column=0, padx=20, pady=(20, 0), sticky="w")
        self.date_start = CTkDatePicker(self.form_frame, width=200)
        self.date_start.grid(row=6, column=0, padx=20, pady=(3, 0), sticky="w")
        self.date_start_error = ctk.CTkLabel(self.form_frame, text="", text_color="red")
        self.date_start_error.grid(row=7, column=0, pady=0, padx=20, sticky="w")

        # PickStartTime field
        ctk.CTkLabel(self.form_frame, text="Hora de Inicio").grid(row=5, column=3, padx=20, pady=(20, 0), sticky="w")
        self.time_start = SpinTimePickerOld(self.form_frame)
        self.time_start.addAll(constants.HOURS24)
        self.time_start.grid(row=6, column=3, padx=20, pady=(3, 0), sticky="w")

        # PickEndDate field
        ctk.CTkLabel(self.form_frame, text="Data de Fim").grid(row=8, column=0, padx=20, pady=(20, 0), sticky="w")
        self.date_end = CTkDatePicker(self.form_frame, width=200)
        self.date_end.grid(row=9, column=0, padx=20, pady=(3, 0), sticky="w")
        self.date_end_error = ctk.CTkLabel(self, text="", text_color="red")
        self.date_end_error.grid(row=10, column=0, pady=0, padx=20, sticky="w")

        # PickEndTime field
        ctk.CTkLabel(self.form_frame, text="Hora de Fim").grid(row=8, column=3, padx=20, pady=(20, 0), sticky="w")
        self.time_end = SpinTimePickerOld(self.form_frame)
        self.time_end.addAll(constants.HOURS24)
        self.time_end.grid(row=9, column=3, padx=20, pady=(3, 0), sticky="w")
        # EndOf DATETIME pickers -----------------------------------------------------------------------
        # EndOf form_frame ------------------------------------------------------------------------------------------------------


        # Second frame (scrollable) ---------------------------------------------------------------------------------------------
        self.equipments_radio = {}
        # Select equipments field
        ctk.CTkLabel(self, text="Lista de Equipamentos").grid(row=1, column=0, padx=20, pady=(20, 0), sticky="w")
        self.scrollableFrame = ctk.CTkScrollableFrame(self, fg_color="#FFFFFF")
        self.scrollableFrame.grid(row=3, column=0, sticky="nsew", padx=30, pady=(3, 0))
        self.scrollableFrame.grid_columnconfigure(4, weight=1)


        # EndOf scrollable frame ------------------------------------------------------------------------------------------------

        self.category = ctk.StringVar(self, EquipmentCategory.all.value)

        ctk.CTkLabel(self, text="Categoria do Equipamento").grid(row=1, column=0, padx=20, pady=(20, 0), sticky="w")
        self.combo = ctk.CTkComboBox(self, values=EquipmentCategory.get_categories(), variable=self.category, command=self.reload ,width=300)
        self.combo.grid(row=2, column=0, pady=(3, 0), padx=20, sticky="w")

        # Submit button
        self.button = ctk.CTkButton(self, text="Submeter", command=self.submit, width=200)
        self.button.grid(row=4, column=0, pady=20, padx=20, sticky="e")

    def reload(self, category=None) -> None:
        """ Used by app.py to reload page data. """

        for widget in self.scrollableFrame.winfo_children():
            widget.destroy()

        if category is not None:
            equipments = Equipment.get_equipments(category)
        else:
            equipments = Equipment.get_equipments(self.category.get())

        # todo: make a combobox for category and load
        #  equipments from that category, or put all
        #  (select from equip where category in (...))

        # Table header
        l = ctk.CTkLabel(self.scrollableFrame, text="Reservar", text_color="#545F71", font=("", 12, "bold"))
        l.grid(row=1, column=0, padx=5, pady=15, sticky="w")
        l = ctk.CTkLabel(self.scrollableFrame, text="Equipamento", text_color="#545F71", font=("", 12, "bold"))
        l.grid(row=1, column=3, padx=5, pady=20, sticky="w")
        self.add_divider(2)

        # Table Rows
        i = 2
        for equipment in equipments:
            i += 1

            self.equipments_radio[equipment[0]] = ctk.StringVar(value=ReservationEquipmentType.not_reserved.value)

            l = ctk.CTkRadioButton(self.scrollableFrame, text="Não", value=ReservationEquipmentType.not_reserved.value,
                                   variable=self.equipments_radio[equipment[0]],
                                   text_color="#545F71")
            l.grid(row=i, column=0, padx=5, pady=7, sticky="w")

            l = ctk.CTkRadioButton(self.scrollableFrame, text="Sim", value=ReservationEquipmentType.reserved.value,
                                   variable=self.equipments_radio[equipment[0]],
                                   text_color="#545F71")
            l.grid(row=i, column=1, padx=5, pady=7, sticky="w")

            l = ctk.CTkRadioButton(self.scrollableFrame, text="Essencial",
                                   value=ReservationEquipmentType.essential.value,
                                   variable=self.equipments_radio[equipment[0]],
                                   text_color="#545F71")
            l.grid(row=i, column=2, padx=5, pady=7, sticky="w")

            l = ctk.CTkLabel(self.scrollableFrame, text=equipment[2], text_color="#545F71")
            l.grid(row=i, column=3, padx=5, pady=7, sticky="w")

            i += 1
            self.add_divider(i)

    # well, it simulates a divider...
    def add_divider(self, i) -> None:
        ctk.CTkFrame(self.scrollableFrame, width=120, height=1, bg_color="#B3CBE5").grid(row=i, column=0, sticky="s")
        ctk.CTkFrame(self.scrollableFrame, width=120, height=1, bg_color="#B3CBE5").grid(row=i, column=1, sticky="s")
        ctk.CTkFrame(self.scrollableFrame, width=120, height=1, bg_color="#B3CBE5").grid(row=i, column=2, sticky="s")
        ctk.CTkFrame(self.scrollableFrame, width=200, height=1, bg_color="#B3CBE5").grid(row=i, column=3, sticky="s")

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

        equipments_radio = {}
        for k, v in self.equipments_radio.items():
            equipments_radio[k] = v.get()

        mega_data = self.date_start.get_date() + " " + str(self.time_start.hours24()) + ":" + str(self.time_start.minutes())
        datetime_start = datetime.strptime(mega_data, "%Y/%m/%d %H:%M")

        mega_data2 = self.date_end.get_date() + " " + str(self.time_end.hours24()) + ":" + str(self.time_end.minutes())
        datetime_end = datetime.strptime(mega_data2, "%Y/%m/%d %H:%M")

        Reservation.add_reservation(self.user.get(), datetime_start, datetime_end, equipments_radio)

        # Todo: validate date entries
