import customtkinter as ctk
import tkinter as tk
import os
import importlib
from PIL import Image
from views.nav import nav
from controllers import about

class App(ctk.CTk):
    def __init__(self):
        super().__init__()
        self._fg_color="#8BB5E0"

        self.navigation_frame = None
        self.frames = None
        self.images = None
        self.nav_frames = {}

        self.title("Gestor de Reservas e Requisições - DI")
        self.geometry("800x600")

        ctk.set_default_color_theme("blue")

        self.grid_rowconfigure(0, weight=1)
        self.grid_columnconfigure(1, weight=1)

        # Frames mapping
        self.frame_name_mapping = {
            "frame_home.py": "Página Inicial",
            "frame_requisicao.py": "Requisição",
            "frame_reserva.py": "Reserva",
        }

        # Loaders
        self.load_images()
        self.create_frames()

        self.create_top_panel()
        self.create_navigation_panel()

        # Select the default frame (home)
        self.select_frame("Página Inicial", "Página Inicial")

    def load_images(self):
        # Load all images used in the application (I included the example ones)
        image_path = os.path.join(os.path.dirname(os.path.realpath(__file__)), "views/images")
        self.images = {
            "DI": ctk.CTkImage(Image.open(os.path.join(image_path, "DI.png")), size=(160, 160)),
            "logo": ctk.CTkImage(Image.open(os.path.join(image_path, "CustomTkinter_logo_single.png")), size=(26, 26)),
            "large_test": ctk.CTkImage(Image.open(os.path.join(image_path, "large_test_image.png")), size=(500, 150)),
            "icon": ctk.CTkImage(Image.open(os.path.join(image_path, "image_icon_light.png")), size=(20, 20)),
            "home": ctk.CTkImage(light_image=Image.open(os.path.join(image_path, "home_dark.png")),
                                           dark_image=Image.open(os.path.join(image_path, "home_light.png")), size=(20, 20)),
            "chat": ctk.CTkImage(light_image=Image.open(os.path.join(image_path, "chat_dark.png")),
                                           dark_image=Image.open(os.path.join(image_path, "chat_light.png")), size=(20, 20)),
            "add_user": ctk.CTkImage(light_image=Image.open(os.path.join(image_path, "add_user_dark.png")),
                                               dark_image=Image.open(os.path.join(image_path, "add_user_light.png")), size=(20, 20)),
        }

    def load_frames(self):
        loaded_frames = {}
        frames_dir = os.path.join(os.path.dirname(os.path.realpath(__file__)), "views/frames")

        for file in os.listdir(frames_dir):
            if file in self.frame_name_mapping:  # Check if the file is in the mapping
                module_name = f"views.frames.{file[:-3]}"  # Remove .py to get module name
                try:
                    module = importlib.import_module(module_name)
                    class_name = file[:-3].title().replace("_", "")
                    frame_class = getattr(module, class_name)
                    logical_name = self.frame_name_mapping[file]
                    loaded_frames[logical_name] = frame_class
                except (ImportError, AttributeError) as e:
                    print(f"Error loading frame '{file}': {e}")

        return loaded_frames

    def create_frames(self):
        self.frames = {}
        loaded_frames = self.load_frames()
        for logical_name, frame_class in loaded_frames.items():
            try:
                self.frames[logical_name] = frame_class(self, self.images)
            except TypeError as e:
                print(f"Error instantiating frame '{logical_name}': {e}")

    def create_top_panel(self):
        menu_bar = tk.Menu(self)

        # Create menu Tools
        menu_tools = tk.Menu(menu_bar, tearoff=0)
        menu_tools.add_command(label="Conectar à Base de Dados")
        menu_tools.add_command(label="Salvar")
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
        self.navigation_frame = ctk.CTkFrame(self, corner_radius=0, fg_color='transparent')
        self.navigation_frame.grid(row=0, column=0, sticky="nsew")
        self.navigation_frame.grid_rowconfigure(4, weight=1)

        ctk.CTkLabel(self.navigation_frame, text="", image=self.images["DI"]).grid(
            row=0, column=0, padx=0, pady=(10, 20), sticky="nsew"
        )

        nav_entries = {
            'Página Inicial': ['Página Inicial', 'Reserva'],
            'Requisição': ['Requisição', 'Reserva'],
        }

        i = 0
        for k, entries in nav_entries.items():
            self.nav_frames[k] = nav.Nav(self.navigation_frame, i, self.select_frame, k, entries)
            i+=1

    def select_frame(self, frame_name, button_name):
        for name, frame in self.frames.items():
            frame.grid_forget()

        for name, frame in self.nav_frames.items():
            self.nav_frames[name].unselect()

        self.frames[button_name].grid(row=0, column=1, sticky="nsew")
        self.nav_frames[frame_name].select(button_name)

if __name__ == "__main__":
    app = App()
    app.mainloop()
