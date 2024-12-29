import customtkinter as ctk

from models import Requisition, Req_Equip, Equipment, Devolution


class FrameRequisitionEdit(ctk.CTkScrollableFrame):
    def __init__(self, parent, requisition_id):
        super().__init__(parent, corner_radius=0, fg_color="#EBF3FA")
        self.grid_columnconfigure(0, weight=1)
        self.grid_rowconfigure(1, weight=1)

        self.requisition = Requisition.get_by_id(requisition_id)

        self.form_frame = ctk.CTkFrame(self, fg_color="#EBF3FA")
        self.form_frame.grid(row=0, column=0, sticky="nsew")

        # Page title
        title = ctk.CTkLabel(self.form_frame, text="Edição da Requisição", text_color="#20558A", font=("", 20, 'bold'))
        title.grid(row=0, column=0, padx=20, pady=(30, 40), sticky="w")

        # User field
        ctk.CTkLabel(self.form_frame, text="Utilizador").grid(row=1, column=0, padx=20, pady=(20, 0), sticky="w")
        ctk.CTkLabel(self.form_frame, text=self.requisition[1]).grid(row=2, column=0, pady=(20, 0), padx=20, sticky="w")

        date_format = "%d-%m-%Y %H:%M:%S"

        # DateTimeStart
        ctk.CTkLabel(self.form_frame, text="Data de Inicio").grid(row=3, column=0, padx=20, pady=(20, 0), sticky="w")
        ctk.CTkLabel(self.form_frame, text=self.requisition[3].strftime(date_format)).grid(row=4, column=0, padx=20,
                                                                                           pady=(20, 0), sticky="w")

        # DateTimeEnd
        ctk.CTkLabel(self.form_frame, text="Data de Fim").grid(row=3, column=3, padx=20, pady=(20, 0), sticky="w")
        ctk.CTkLabel(self.form_frame, text=self.requisition[4].strftime(date_format)).grid(row=4, column=3, padx=20,
                                                                                           pady=(20, 0), sticky="w")

        # Select equipments field
        ctk.CTkLabel(self, text="Lista de Equipamentos").grid(row=7, column=0, padx=20, pady=(20, 0), sticky="w")
        self.scrollableFrame = ctk.CTkScrollableFrame(self, fg_color="#FFFFFF")
        self.scrollableFrame.grid(row=8, column=0, sticky="nsew", padx=30, pady=(3, 0))
        self.scrollableFrame.grid_columnconfigure(3, weight=1)

        self.reload()

        # Submit button
        self.button = ctk.CTkButton(self, text="Submeter", command=self.submit, width=200)
        self.button.grid(row=9, column=0, pady=20, padx=20, sticky="e")

    def reload(self) -> None:
        """ Used by app.py to reload page data. """

        for widget in self.scrollableFrame.winfo_children():
            widget.destroy()

        equipments = Req_Equip.get_by_requisition(self.requisition[0])
        returned = [r[1] for r in Devolution.get_by_requisition(self.requisition[0])]

        # Table header
        l = ctk.CTkLabel(self.scrollableFrame, text="Equipamento", text_color="#545F71", font=("", 12, "bold"))
        l.grid(row=1, column=0, padx=5, pady=15, sticky="w")
        l = ctk.CTkLabel(self.scrollableFrame, text="Devolvido", text_color="#545F71", font=("", 12, "bold"))
        l.grid(row=1, column=1, padx=5, pady=20, sticky="w")
        self.add_divider(2)

        # Table Rows
        i = 2
        for equipment in equipments:
            i += 1

            l = ctk.CTkLabel(self.scrollableFrame, text=Equipment.get_by_id(equipment[1])[2], text_color="#545F71")
            l.grid(row=i, column=0, padx=5, pady=7, sticky="w")

            if equipment[1] not in returned:
                l = ctk.CTkCheckBox(self.scrollableFrame, text="", text_color="#545F71")
                l.grid(row=i, column=1, padx=5, pady=7, sticky="w")
            else:
                l = ctk.CTkLabel(self.scrollableFrame, text='Devolvido', text_color="#545F71")
                l.grid(row=i, column=1, padx=5, pady=7, sticky="w")

            i += 1
            self.add_divider(i)

    # well, it simulates a divider...
    def add_divider(self, i) -> None:
        ctk.CTkFrame(self.scrollableFrame, width=200, height=1, bg_color="#B3CBE5").grid(row=i, column=0, sticky="s")
        ctk.CTkFrame(self.scrollableFrame, width=120, height=1, bg_color="#B3CBE5").grid(row=i, column=1, sticky="s")
        ctk.CTkFrame(self.scrollableFrame, width=120, height=1, bg_color="#B3CBE5").grid(row=i, column=2, sticky="s")

    def submit(self) -> None:
        """
        Submits the form.
        """

        # Todo: validate date entries
