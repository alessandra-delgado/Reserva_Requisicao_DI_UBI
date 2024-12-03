import customtkinter
import os
import importlib
from PIL import Image
from nav import nav_home
from nav import nav_requisicao

class App(customtkinter.CTk):
    def __init__(self):
        super().__init__()

        self.navigation_frame = None
        self.frames = None
        self.images = None
        self.nav_frames = {}

        self.title("Gestor de Reservas e Requisições - DI")
        self.geometry("800x600")

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

        self.create_navigation_panel()

        # Select the default frame (home)
        self.select_frame("Página Inicial", "Página Inicial")

    def load_images(self):
        # Load all images used in the application (I included the example ones)
        image_path = os.path.join(os.path.dirname(os.path.realpath(__file__)), "images")
        self.images = {
            "DI": customtkinter.CTkImage(Image.open(os.path.join(image_path, "DI.png")), size=(100, 100)),
            "logo": customtkinter.CTkImage(Image.open(os.path.join(image_path, "CustomTkinter_logo_single.png")), size=(26, 26)),
            "large_test": customtkinter.CTkImage(Image.open(os.path.join(image_path, "large_test_image.png")), size=(500, 150)),
            "icon": customtkinter.CTkImage(Image.open(os.path.join(image_path, "image_icon_light.png")), size=(20, 20)),
            "home": customtkinter.CTkImage(light_image=Image.open(os.path.join(image_path, "home_dark.png")),
                                           dark_image=Image.open(os.path.join(image_path, "home_light.png")), size=(20, 20)),
            "chat": customtkinter.CTkImage(light_image=Image.open(os.path.join(image_path, "chat_dark.png")),
                                           dark_image=Image.open(os.path.join(image_path, "chat_light.png")), size=(20, 20)),
            "add_user": customtkinter.CTkImage(light_image=Image.open(os.path.join(image_path, "add_user_dark.png")),
                                               dark_image=Image.open(os.path.join(image_path, "add_user_light.png")), size=(20, 20)),
                                    
        }

    def load_frames(self):
        loaded_frames = {}
        frames_dir = os.path.join(os.path.dirname(os.path.realpath(__file__)), "frames")

        for file in os.listdir(frames_dir):
            if file in self.frame_name_mapping:  # Check if the file is in the mapping
                module_name = f"frames.{file[:-3]}"  # Remove .py to get module name
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

    def create_navigation_panel(self):
        self.navigation_frame = customtkinter.CTkFrame(self, corner_radius=0)
        self.navigation_frame.grid(row=0, column=0, sticky="nsew")
        self.navigation_frame.grid_rowconfigure(4, weight=1)

        customtkinter.CTkLabel(
        self.navigation_frame, 
        text="Departamento de\nInformática", #ill change this later T-T
        image=self.images["DI"], 
        compound="left",  # Ensures the image is to the left of the text
        font=customtkinter.CTkFont(size=15, weight="bold"),
        anchor="w"  # Aligns content to the left
        ).grid(row=0, column=0, padx=(10, 0), pady=20, sticky="w")

        self.nav_frames['Página Inicial'] = nav_home.FrameHome(self.navigation_frame, 0, self.select_frame, 'Página Inicial')
        self.nav_frames['Requisição'] = nav_requisicao.FrameHome(self.navigation_frame, 1, self.select_frame, 'Requisição')

        # Option menu for themes
        customtkinter.CTkOptionMenu(
            self.navigation_frame, values = ["Light",  "Dark", "System"],
            command = customtkinter.set_appearance_mode
        ).grid(row = 6, column = 0, padx = 20, pady = 20, sticky = 's')

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
