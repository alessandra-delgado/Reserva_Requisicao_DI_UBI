import customtkinter as ctk


class Nav(ctk.CTkFrame):
    def __init__(self, parent, row, callback, name, entries):
        super().__init__(parent, corner_radius=0, fg_color="transparent")
        self.grid_columnconfigure(0, weight=1)
        self.grid(row=1 + row, column=0, padx=20, pady=(0, 20))

        self.visible = False
        self.buttons = {}

        # Add content
        self.master_button = ctk.CTkButton(self, height=40, width=200, text=name, anchor="w", text_color="#163B61",
                                           hover_color="#6DA5DE",
                                           command=self.toggle)
        self.master_button.grid(row=0, column=0, sticky="nsew", padx=10)

        self.container = ctk.CTkFrame(self, corner_radius=0, fg_color="transparent")
        self.container.grid_forget()

        for i, el in enumerate(entries):
            self.buttons[el] = self.add_nav_entry(el, i, callback, name)

    def add_nav_entry(self, el, i, callback, name):
        button = ctk.CTkButton(self.container, height=40, width=200, text=" • " + el,
                               text_color="#163B61", hover_color="#6DA5DE", anchor="w",
                               command=lambda: callback(name, el))
        button.grid(row=i, column=0, pady=(10, 0), sticky="nsew", padx=10)
        return button

    def select(self, button_name):
        self.buttons[button_name].configure(fg_color="#296EB4", text_color="#E9EFF5")
        self.master_button.configure(fg_color="#296EB4", text_color="#E9EFF5")

    def unselect(self):
        self.master_button.configure(fg_color="#8BB5E0", text_color="#163B61")
        for button in self.buttons.values():
            button.configure(fg_color="#8BB5E0", text_color="#163B61")

    def toggle(self):
        if self.visible:
            self.container.grid_forget()
        else:
            self.container.grid(row=1, column=0, padx=0, pady=0)

        # Toggle visibility
        self.visible = not self.visible
