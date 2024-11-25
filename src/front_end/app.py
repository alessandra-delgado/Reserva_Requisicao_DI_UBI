import customtkinter
import os
from PIL import Image
from frame_home import HomeFrame
from frame_reserva import FrameReserva
from frame_requisicao import FrameRequisicao

class App(customtkinter.CTk):
    def __init__(self):
        super().__init__()

        self.title("Gestor de Reservas e Requisições - DI")
        self.geometry("800x600")

        self.grid_rowconfigure(0, weight = 1)
        self.grid_columnconfigure(1, weight = 1)

        #loaders
        self.load_images()

        self.create_navigation_panel()
        self.create_frames()

        self.select_frame("home") # view default frame (home)


    def load_images(self):
            image_path = os.path.join(os.path.dirname(os.path.realpath(__file__)), "images")
            self.images = {
                "DI": customtkinter.CTkImage(Image.open(os.path.join(image_path, "DI.png")), size = (26, 26)),
            }


    def create_navigation_panel(self):
        self.navigation_frame = customtkinter.CTkFrame(self, corner_radius = 0)
        self.navigation_frame.grid(row = 0, column = 0, sticky = "nsew")
        self.navigation_frame.grid_rowconfigure(4, weight = 1)

        customtkinter.CTkLabel(
            self.navigation_frame, text = "Departamento Informática", image = self.images["DI"], compound = "left",
            font = customtkinter.CTkFont(size = 15, weight = "bold")
        ).grid(row = 0, column = 0, padx = 20, pady = 20)

        self.nav_buttons = {
            "home" : self.add_nav_button("Página Inicial", self.select_frame, "home", row = 1),
            "frame_reserva" : self.add_nav_button("Reservas", self.select_frame, "frame_reserva", row = 2),
            "frame_requisicao" : self.add_nav_button("Requisições", self.select_frame, "frame_requisicao", row = 3),
        }

        customtkinter.CTkOptionMenu(
            self.navigation_frame, values = ["Light",  "Dark", "System"],
            command = customtkinter.set_appearance_mode
        ).grid(row = 6, column = 0, padx = 20, pady = 20, sticky = 's')

    def add_nav_button(self, text, command, frame_name, row):
        #add_nav_button helper
        button = customtkinter.CTkButton(
            self.navigation_frame, corner_radius = 0, height = 40, border_spacing = 10, text = text,
            fg_color = "transparent", text_color = ("gray10", "gray90"), hover_color=("gray70", "gray30"),
            anchor = "w", command = lambda: command(frame_name)
        )
        button.grid(row = row, column = 0, sticky = "ew")
        return button
    
    def create_frames(self):
        self.frames = {
            "home" : HomeFrame(self),
            "frame_reserva": FrameReserva(self),
            "frame_requisicao": FrameRequisicao(self),
        }

    def select_frame(self, frame_name):
        #select frame -> display specified frame

        for name, frame in self.frames.items():
            frame.grid.forget()
            self.nav_buttons[name].configure(fg_color = "transparent")
        self.frames[frame_name].grid(row = 0, column = 1, sticky = "nsew")
        self.nav_buttons[frame_name].configure(fg_color = ("gray75", "gray25"))

if __name__ == "__main__":
    app = App()
    app.mainloop()

        