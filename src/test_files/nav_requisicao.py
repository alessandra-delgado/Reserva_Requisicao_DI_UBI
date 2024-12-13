import customtkinter

class FrameHome(customtkinter.CTkFrame):
    def __init__(self, parent, row, callback, name):
        super().__init__(parent, corner_radius=0, fg_color="transparent")
        self.grid_columnconfigure(0, weight=1)
        self.grid(row=1+row, column=0, padx=20, pady=20)

        self.visible = False
        self.buttons = {}

        # Add content
        customtkinter.CTkButton(self, corner_radius=0, height=40, width=240, border_spacing=10, text=name,
            fg_color="transparent", text_color=("gray10", "gray90"), hover_color=("gray70", "gray30"),
            anchor="w", command=self.toggle
        ).grid(row=0, column=0, sticky="ew")

        self.container = customtkinter.CTkFrame(self, corner_radius=0)
        self.container.grid_forget()

        self.buttons['Requisição'] = customtkinter.CTkButton(self.container, corner_radius=0, height=40, width=240, border_spacing=10, text="• Requisição",
            fg_color="transparent", text_color=("gray10", "gray90"), hover_color=("gray70", "gray30"),
            anchor="w", command=lambda: callback(name, 'Requisição')
        )
        self.buttons['Requisição'].grid(row=0, column=0, sticky="ew")

        self.buttons['Reserva'] = customtkinter.CTkButton(self.container, corner_radius=0, height=40, width=240, border_spacing=10, text="• Reserva",
            fg_color="transparent", text_color=("gray10", "gray90"), hover_color=("gray70", "gray30"),
            anchor="w", command=lambda: callback(name, 'Reserva')
        )
        self.buttons['Reserva'].grid(row=1, column=0, sticky="ew")

    def select(self, button_name):
        self.buttons[button_name].configure(fg_color=("gray75", "gray25"))

    def unselect(self):
        for button in self.buttons.values():
            button.configure(fg_color="transparent")

    def toggle(self):
        if self.visible:
            self.container.grid_forget()
        else:
            self.container.grid(row=1, column=0, padx=0, pady=0)

        # Toggle visibility
        self.visible = not self.visible
