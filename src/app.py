import customtkinter as ctk
import tkinter as tk
import os
from PIL import Image

from models import DataBase
from views.frames import home, equipment_index, equipment_new,reserve_index, reserve_new, requisition_index, requisition_new, user_new, user_index
from views.nav import nav
from controllers import about, connect
import threading
from tasks import cron

class App(ctk.CTk):
    def __init__(self):
        super().__init__()
        self._fg_color = "#8BB5E0"

        self.navigation_frame = None
        self.images = None
        self.nav_frames = {}

        self.title("Gestor de Reservas e Requisições - DI")
        self.geometry("1000x600")

        ctk.set_default_color_theme("blue")

        # Resize frame to fill all window
        self.grid_rowconfigure(0, weight=1)
        self.grid_columnconfigure(1, weight=1)

        # Frames mapping
        self.frames = {
            "Página Inicial": home.FrameHome(self),
            "Lista de Equipamentos": equipment_index.FrameEquipmentIndex(self),
            "Adicionar Equipamento": equipment_new.FrameEquipmentNew(self),
            "Lista de Reservas": reserve_index.FrameReserveIndex(self),
            "Criar Reserva": reserve_new.FrameReserveNew(self),
            "Lista de Requisições": requisition_index.FrameRequisitionIndex(self),
            "Criar Requisição": requisition_new.FrameRequisitionNew(self),
            "Lista de Utilizadores": user_index.FrameUserIndex(self),
            "Criar Utilizador": user_new.FrameUserNew(self),
        }

        # Loaders
        self.load_images()

        self.create_top_panel()
        self.create_navigation_panel()

        # Select the default frame (home)
        self.select_frame("Página Inicial", "Página Inicial")

    def load_images(self):
        # Load all images used in the application
        image_path = os.path.join(os.path.dirname(os.path.realpath(__file__)), "views/images")

        self.images = {
            "DI": ctk.CTkImage(Image.open(os.path.join(image_path, "DI.png")), size=(160, 160)),
        }

    def create_top_panel(self):
        menu_bar = tk.Menu(self)

        # Create menu Tools
        menu_tools = tk.Menu(menu_bar, tearoff=0)
        menu_tools.add_command(label="Conectar à Base de Dados", command=connect.to_db)
        menu_tools.add_separator()
        menu_tools.add_command(label="Sair", command=self.quit)

        # Create menu About
        menu_sobre = tk.Menu(menu_bar, tearoff=0)
        menu_sobre.add_command(label="Sobre", command=about.about)

        menu_bar.add_cascade(label="Ferramentas", menu=menu_tools)
        menu_bar.add_cascade(label="Sobre", menu=menu_sobre)

        # Configurar a barra de menu na janela principal
        self.config(menu=menu_bar)

    def create_navigation_panel(self):
        self.navigation_frame = ctk.CTkScrollableFrame(self, corner_radius=0, width=250, fg_color='transparent')
        self.navigation_frame.grid(row=0, column=0, sticky="nsew")
        self.navigation_frame.grid_rowconfigure(4, weight=1)

        ctk.CTkLabel(self.navigation_frame, text="", image=self.images["DI"]).grid(
            row=0, column=0, padx=0, pady=(10, 20), sticky="nsew"
        )

        nav_entries = {
            'Página Inicial': ['Página Inicial'],
            'Equipamento': ['Lista de Equipamentos', 'Adicionar Equipamento'],
            'Reserva': ['Lista de Reservas', 'Criar Reserva'],
            'Requisição': ['Lista de Requisições', 'Criar Requisição'],
            'Utilizador': ['Lista de Utilizadores', 'Criar Utilizador'],
        }

        i = 0
        for k, entries in nav_entries.items():
            self.nav_frames[k] = nav.Nav(self.navigation_frame, i, self.select_frame, k, entries)
            i += 1

    def select_frame(self, frame_name, button_name):
        for name, frame in self.frames.items():
            frame.grid_forget()
            if hasattr(frame, "delete_dependent"):
                frame.delete_dependent()

        for name, frame in self.nav_frames.items():
            self.nav_frames[name].unselect()

        # Crucial to reload re query data from DB
        if hasattr(self.frames[button_name], "reload"):
            self.frames[button_name].reload()

        self.frames[button_name].grid(row=0, column=1, sticky="nsew")
        self.nav_frames[frame_name].select(button_name)


if __name__ == "__main__":
    app = App()

    stop = threading.Event()
    # Starts cronjob thread

    thread = threading.Thread(target = cron.init, args=(stop,))
    thread.start()

    app.mainloop()
    # Marks cronjob to stop
    stop.set()
    thread.join()

    if DataBase.conn is not None:
        DataBase.close()
