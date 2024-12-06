import customtkinter


class FrameReserva(customtkinter.CTkFrame):
    def __init__(self, parent, images):
        super().__init__(parent, corner_radius=0, fg_color="#EBF3FA")
        # Add content here for Frame 2 if needed.
        customtkinter.CTkLabel(self, text="", image=images["large_test"]).grid(row=0, column=0, padx=20, pady=10)
        for i, compound in enumerate(["", "right", "top", "bottom"], start=1):
            customtkinter.CTkButton(
                self, text="CTkButton" if compound else "", image=images["icon"], compound=compound
            ).grid(row=i, column=0, padx=20, pady=10)
