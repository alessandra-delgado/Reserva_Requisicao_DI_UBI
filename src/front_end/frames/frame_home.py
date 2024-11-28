import customtkinter
from PIL import Image


class FrameHome(customtkinter.CTkFrame):
    def __init__(self, parent, images):
        super().__init__(parent, corner_radius=0, fg_color="transparent")
        self.grid_columnconfigure(0, weight=1)

        # Add content
        customtkinter.CTkLabel(self, text="", image=images["large_test"]).grid(row=0, column=0, padx=20, pady=10)
        for i, compound in enumerate(["", "right", "top", "bottom"], start=1):
            customtkinter.CTkButton(
                self, text="CTkButton" if compound else "", image=images["icon"], compound=compound
            ).grid(row=i, column=0, padx=20, pady=10)