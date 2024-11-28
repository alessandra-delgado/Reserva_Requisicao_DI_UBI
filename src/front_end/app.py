import customtkinter
import os
import importlib
from PIL import Image

class App(customtkinter.CTk):
    def __init__(self):
        super().__init__()

        self.title("Gestor de Reservas e Requisições - DI")
        self.geometry("800x600")

        self.grid_rowconfigure(0, weight=1)
        self.grid_columnconfigure(1, weight=1)

        # Loaders
        self.load_images()
        self.create_frames()

        self.create_navigation_panel()

        # Select the default frame (home)
        self.select_frame("Página Inicial")

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
        frame_name_mapping = {
            "frame_home.py": "Página Inicial",
            "frame_reserva.py": "Reservas",
            "frame_requisicao.py": "Requisições"
        }

        self.loaded_frames = {}
        frames_dir = os.path.join(os.path.dirname(os.path.realpath(__file__)), "frames")

        for file in os.listdir(frames_dir):
            if file in frame_name_mapping:  # Check if the file is in the mapping
                module_name = f"frames.{file[:-3]}"  # Remove .py to get module name
                try:
                    module = importlib.import_module(module_name)
                    class_name = file[:-3].title().replace("_", "")
                    frame_class = getattr(module, class_name)
                    logical_name = frame_name_mapping[file]
                    self.loaded_frames[logical_name] = frame_class
                except (ImportError, AttributeError) as e:
                    print(f"Error loading frame '{file}': {e}")

    def create_frames(self):
        self.load_frames()
        self.frames = {}
        for logical_name, frame_class in self.loaded_frames.items():
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


        navigation_frames = ["Página Inicial", "Reservas", "Requisições"]
        self.nav_buttons = {
            name: self.add_nav_button(name.title(), self.select_frame, name, row=i + 1)
            for i, name in enumerate(navigation_frames)
        }

        # Option menu for themes
        customtkinter.CTkOptionMenu(
            self.navigation_frame, values = ["Light",  "Dark", "System"],
            command = customtkinter.set_appearance_mode
        ).grid(row = 6, column = 0, padx = 20, pady = 20, sticky = 's')

    def add_nav_button(self, text, command, frame_name, row):
        button = customtkinter.CTkButton(
            self.navigation_frame, corner_radius=0, height=40, border_spacing=10, text=text,
            fg_color="transparent", text_color=("gray10", "gray90"), hover_color=("gray70", "gray30"),
            anchor="w", command=lambda: command(frame_name)
        )
        button.grid(row=row, column=0, sticky="ew")
        return button

    def select_frame(self, frame_name):
        for name, frame in self.frames.items():
            frame.grid_forget()
            self.nav_buttons[name].configure(fg_color="transparent")
        self.frames[frame_name].grid(row=0, column=1, sticky="nsew")
        self.nav_buttons[frame_name].configure(fg_color=("gray75", "gray25"))


if __name__ == "__main__":
    app = App()
    app.mainloop()
