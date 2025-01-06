from datetime import datetime

import customtkinter as ctk
from tktimepicker import constants, SpinTimePickerOld

from enums.equipmentCategory import EquipmentCategory
from enums.reservationEquipmentType import ReservationEquipmentType
from models import Reservation, UserDI, Equipment
from views.widgets.ctk_date_picker import CTkDatePicker


class FrameReserveNew(ctk.CTkScrollableFrame):
    def __init__(self, parent):
        super().__init__(parent, corner_radius=0, fg_color="#EBF3FA")

        self.grid_columnconfigure(0, weight=1)
        self.grid_rowconfigure(1, weight=1)

        self.cols = 4

        self.button = None
        self.categories = None
        self.category = ctk.StringVar(self, EquipmentCategory.all.value)

        self.scrollableFrame = None
        self.scrollableFrame_error = None
        self.scrollableFrame_error2 = None

        self.equipments_radio = None

        self.date_start = None
        self.date_start_error = None

        self.time_start_error = None
        self.time_start = None

        self.time_end = None
        self.time_end_error = None

        self.date_end = None
        self.date_end_error = None

        self.combo = None
        self.combo_error = None

        self.user = None
        self.form_frame = None

        self.reload()

    def reload(self) -> None:
        for widget in self.winfo_children():
            widget.destroy()

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

        self.user = ctk.StringVar(self.form_frame, users[0] if len(users) > 0 else '')

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
        self.time_start_error = ctk.CTkLabel(self.form_frame, text="", text_color="red")
        self.time_start_error.grid(row=7, column=3, pady=0, padx=20, sticky="w")

        # PickEndDate field
        ctk.CTkLabel(self.form_frame, text="Data de Fim").grid(row=8, column=0, padx=20, pady=(20, 0), sticky="w")
        self.date_end = CTkDatePicker(self.form_frame, width=200)
        self.date_end.grid(row=9, column=0, padx=20, pady=(3, 0), sticky="w")
        self.date_end_error = ctk.CTkLabel(self.form_frame, text="", text_color="red")
        self.date_end_error.grid(row=10, column=0, pady=0, padx=20, sticky="w")

        # PickEndTime field
        ctk.CTkLabel(self.form_frame, text="Hora de Fim").grid(row=8, column=3, padx=20, pady=(20, 0), sticky="w")
        self.time_end = SpinTimePickerOld(self.form_frame)
        self.time_end.addAll(constants.HOURS24)
        self.time_end.grid(row=9, column=3, padx=20, pady=(3, 0), sticky="w")
        self.time_end_error = ctk.CTkLabel(self.form_frame, text="", text_color="red")
        self.time_end_error.grid(row=10, column=3, pady=0, padx=20, sticky="w")
        # EndOf DATETIME pickers -----------------------------------------------------------------------
        # EndOf form_frame ------------------------------------------------------------------------------------------------------

        # Second frame (scrollable) ---------------------------------------------------------------------------------------------
        self.equipments_radio = {}
        # Select equipments field

        ctk.CTkLabel(self, text="Lista de Equipamentos").grid(row=1, column=0, padx=20, pady=(20, 0), sticky="w")
        self.scrollableFrame = ctk.CTkScrollableFrame(self, fg_color="#FFFFFF")
        self.scrollableFrame.grid(row=5, column=0, sticky="nsew", padx=30, pady=(3, 0))
        for i in range(self.cols):
            self.scrollableFrame.grid_columnconfigure(i, weight=1)

        self.scrollableFrame_error = ctk.CTkLabel(self, text="", text_color="red")
        self.scrollableFrame_error.grid(row=6, column=0, pady=0, padx=20, sticky="w")

        self.scrollableFrame_error2 = ctk.CTkLabel(self, text="", text_color="red")
        self.scrollableFrame_error2.grid(row=7, column=0, pady=0, padx=20, sticky="w")

        # EndOf scrollable frame ------------------------------------------------------------------------------------------------

        ctk.CTkLabel(self, text="Categoria do Equipamento").grid(row=3, column=0, padx=20, pady=(20, 0), sticky="w")
        self.categories = ctk.CTkComboBox(self, values=EquipmentCategory.get_categories(), variable=self.category,
                                          command=self.reload_scroll, width=300)
        self.categories.grid(row=4, column=0, pady=(3, 0), padx=20, sticky="w")

        self.reload_scroll()

        # User field
        ctk.CTkLabel(self.form_frame, text="Utilizador").grid(row=1, column=0, padx=20, pady=(20, 0), sticky="w")
        self.combo = ctk.CTkComboBox(self.form_frame, values=users, variable=self.user,
                                     command=lambda _: self.reload_scroll(self.category.get()), width=300)
        self.combo.bind('<KeyRelease>', self.filter_users)
        #  ^^^ faz bind de um evento: quando largo uma qualquer tecla chama o filter_users
        self.combo.grid(row=2, column=0, pady=(3, 0), padx=20, sticky="w")
        self.combo_error = ctk.CTkLabel(self.form_frame, text="", text_color="red")
        self.combo_error.grid(row=3, column=0, pady=0, padx=20, sticky="w")

        # Submit button
        self.button = ctk.CTkButton(self, text="Submeter", command=self.submit, width=200)
        self.button.grid(row=8, column=0, pady=20, padx=20, sticky="e")

    def reload_scroll(self, category=None) -> None:
        """ Used by app.py to reload page data. """

        for widget in self.scrollableFrame.winfo_children():
            widget.destroy()

        user_priority = UserDI.get_user_priority(self.user.get().split(' ')[0])[0] if self.user.get() != '' else 1

        if category is not None:
            equipments = Equipment.get_equipments(category, user_priority)
        else:
            equipments = Equipment.get_equipments(self.category.get(), user_priority)

        # Table header
        l = ctk.CTkLabel(self.scrollableFrame, text="Reservar", text_color="#545F71", font=("", 12, "bold"))
        l.grid(row=1, column=0, padx=5, pady=5, sticky="w")
        l = ctk.CTkLabel(self.scrollableFrame, text="Equipamento", text_color="#545F71", font=("", 12, "bold"))
        l.grid(row=1, column=3, padx=5, pady=5, sticky="w")
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

            l = ctk.CTkLabel(self.scrollableFrame, text=equipment[1], text_color="#545F71")
            l.grid(row=i, column=3, padx=5, pady=7, sticky="w")

            i += 1
            self.add_divider(i)

    # well, it simulates a divider...
    def add_divider(self, i) -> None:
        div = ctk.CTkFrame(self.scrollableFrame, height=1, bg_color="#B3CBE5")
        div.grid(row=i, column=0, columnspan=self.cols, sticky="sew")

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

        if self.is_valid():
            equipments_radio = {}
            for k, v in self.equipments_radio.items():
                equipments_radio[k] = v.get()

            mega_data = self.date_start.get_date() + " " + str(self.time_start.hours24()) + ":" + str(
                self.time_start.minutes())
            datetime_start = datetime.strptime(mega_data, "%Y/%m/%d %H:%M")

            mega_data2 = self.date_end.get_date() + " " + str(self.time_end.hours24()) + ":" + str(
                self.time_end.minutes())
            datetime_end = datetime.strptime(mega_data2, "%Y/%m/%d %H:%M")

            Reservation.add_reservation(self.user.get(), datetime_start, datetime_end, equipments_radio)

            self.reload()

    def is_valid(self) -> bool:
        """
        Verify if the form data is valid.
        :return: True if valid, False otherwise.
        """
        valid = True

        # Validate Start Date
        try:
            datetime.strptime(self.date_start.get_date(), "%Y/%m/%d")
            self.date_start_error.configure(text="")
            self.date_start.configure(border_color="#979DA2")

            mega_data = self.date_start.get_date() + " " + str(self.time_start.hours24()) + ":" + str(
                self.time_start.minutes())
            datetime_start = datetime.strptime(mega_data, "%Y/%m/%d %H:%M")

            # datetime_start needs to be after now
            if datetime_start <= datetime.now():
                self.date_start_error.configure(text="Data de inicio não pode ser\nanterior à atual.")
                self.date_start.configure(border_color="red")
                valid = False
            else:
                self.date_start_error.configure(text="")
                self.date_start.configure(border_color="#979DA2")
        except ValueError:
            valid = False
            self.date_start_error.configure(text="Formato inválido.")
            self.date_start.configure(border_color="red")

        # Validate Start Time
        try:
            datetime.strptime(f"{self.time_start.hours24()}:{self.time_start.minutes()}", "%H:%M")
            self.time_start_error.configure(text="")
        except ValueError:
            valid = False
            self.time_start_error.configure(text="Formato inválido.")

        # Validate End Date
        try:
            datetime.strptime(self.date_end.get_date(), "%Y/%m/%d")
            self.date_end_error.configure(text="")
            self.date_end.configure(border_color="#979DA2")

            mega_data2 = self.date_end.get_date() + " " + str(self.time_end.hours24()) + ":" + str(
                self.time_end.minutes())
            datetime_end = datetime.strptime(mega_data2, "%Y/%m/%d %H:%M")

            # datetime_end needs to be after now
            if datetime_end < datetime.now():
                self.date_end_error.configure(text="Data de fim não pode ser\nanterior à atual.")
                self.date_end.configure(border_color="red")
                valid = False
            else:
                self.date_end_error.configure(text="")
                self.date_end.configure(border_color="#979DA2")

            try:
                # Verify if end date is after start date
                mega_data = self.date_start.get_date() + " " + str(self.time_start.hours24()) + ":" + str(
                    self.time_start.minutes())
                datetime_start = datetime.strptime(mega_data, "%Y/%m/%d %H:%M")

                mega_data2 = self.date_end.get_date() + " " + str(self.time_end.hours24()) + ":" + str(
                    self.time_end.minutes())
                datetime_end = datetime.strptime(mega_data2, "%Y/%m/%d %H:%M")

                if datetime_start >= datetime_end:
                    self.date_end_error.configure(text="Data de inicio não pode ser\nmaior ou igual à de termino.")
                    self.date_start.configure(border_color="red")
                    valid = False
                else:
                    self.date_end_error.configure(text="")
                    self.date_start.configure(border_color="#979DA2")
            except ValueError:
                pass
        except ValueError:
            valid = False
            self.date_end_error.configure(text="Formato inválido.")
            self.date_end.configure(border_color="red")

        # Validate Start Time
        try:
            datetime.strptime(f"{self.time_end.hours24()}:{self.time_end.minutes()}", "%H:%M")
            self.time_end_error.configure(text="")
        except ValueError:
            valid = False
            self.time_end_error.configure(text="Formato inválido.")

        has_equipments = False
        self.scrollableFrame_error.configure(text="Deve selecionar pelo menos um equipamento.")
        # At least one equipment must be essential
        for v in self.equipments_radio.values():
            if v.get() in [ReservationEquipmentType.essential.value]:
                has_equipments = True
                self.scrollableFrame_error.configure(text="")
                break

        # validar priority
        preempcao = True

        try:
            # Verify if end date is after start date
            mega_data = self.date_start.get_date() + " " + str(self.time_start.hours24()) + ":" + str(
                self.time_start.minutes())
            datetime_start = datetime.strptime(mega_data, "%Y/%m/%d %H:%M")

            mega_data2 = self.date_end.get_date() + " " + str(self.time_end.hours24()) + ":" + str(
                self.time_end.minutes())
            datetime_end = datetime.strptime(mega_data2, "%Y/%m/%d %H:%M")

            # Qualquer utilizador que não seja o presidente
            if self.combo.get()[:2] != "PD":
                for id, v in self.equipments_radio.items():
                    if v.get() in [ReservationEquipmentType.essential.value, ReservationEquipmentType.reserved.value]:
                        equip = Equipment.get_by_id_view(id)

                        # não há comparação por hora -> converter para segundos
                        print(equip)
                        if equip is not None and equip[4] is not None:
                            delta = (equip[4] - datetime_end).total_seconds() / 3600

                            if 0 <= delta < 48:
                                preempcao = False
                                break
        except ValueError:  # formato da data errado
            pass

        if preempcao:
            self.scrollableFrame_error2.configure(text="")
        else:
            self.scrollableFrame_error2.configure(text="Preempção.")

        # Merge boolean values
        valid = has_equipments and valid and preempcao

        return valid
