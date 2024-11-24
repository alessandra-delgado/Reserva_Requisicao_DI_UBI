import customtkinter as ctk
import page1
import page2


ctk.set_appearance_mode("dark")
ctk.set_default_color_theme("blue")
app = ctk.CTk()  # create CTk window like you do with the Tk window
app.geometry("800x600")
    
tabview = ctk.CTkTabview(app)
tabview.pack(padx=20, pady=20)
tab_1 = tabview.add("tab 1")
tab_2 = tabview.add("tab 2")

page1.Page1(tabview, tab_1)
page2.Page2(tabview, tab_2)

app.mainloop()

