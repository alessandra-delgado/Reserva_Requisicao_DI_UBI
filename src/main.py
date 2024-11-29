import customtkinter as ctk

# Create main window
main = ctk.CTk()
main.configure(fg_color="#23272D")
main.title("Main Window")

# Create scrollable navigation bar using CTkScrollableFrame
framenavbar = ctk.CTkScrollableFrame(master=main, fg_color="#EDECEC", width=250)
framenavbar.pack(side=ctk.LEFT, padx=5, pady=5, anchor='nw', fill="y")

# Add content to the scrollable frame
frameimage = ctk.CTkFrame(master=framenavbar, fg_color="#EDECEC")
frameimage.pack(side=ctk.TOP, padx=5, pady=5, anchor='nw')

label = ctk.CTkLabel(master=frameimage, text="Reservas", fg_color="#E4E2E2", text_color="#000", width=80, height=40)
label.pack(side=ctk.TOP, padx=10, pady=10, anchor='nw')

buttonhome = ctk.CTkButton(master=framenavbar, text="Página Inicial", fg_color="#029CFF", text_color="#fff",
                           border_color="#000", cursor="hand2", width=333, height=52)
buttonhome.pack(side=ctk.TOP, padx=5, pady=5, anchor='nw')

buttonreserva = ctk.CTkButton(master=framenavbar, text="Reservas", fg_color="#029CFF", text_color="#fff",
                              border_color="#000", cursor="hand2", width=337, height=52)
buttonreserva.pack(side=ctk.TOP, padx=5, pady=5, anchor='nw')

framereservabuttons = ctk.CTkFrame(master=framenavbar, fg_color="#EDECEC")
framereservabuttons.pack(side=ctk.TOP, padx=5, pady=5, anchor='nw')

buttonreservacriar = ctk.CTkButton(master=framereservabuttons, text="Criar", fg_color="#029CFF", text_color="#fff",
                                   border_color="#000", width=185, height=38)
buttonreservacriar.pack(side=ctk.TOP, padx=10, pady=10, anchor='nw')

buttonreservalista = ctk.CTkButton(master=framereservabuttons, text="Lista", fg_color="#029CFF", text_color="#fff",
                                   border_color="#000", width=185, height=44)
buttonreservalista.pack(side=ctk.TOP, padx=10, pady=10, anchor='nw')

buttonrequisicao = ctk.CTkButton(master=framenavbar, text="Requisições", fg_color="#029CFF", text_color="#fff",
                                 border_color="#000", cursor="hand2", width=185, height=44)
buttonrequisicao.pack(side=ctk.TOP, padx=5, pady=5, anchor='nw')

framerequisicaobuttons = ctk.CTkFrame(master=framenavbar, fg_color="#EDECEC")
framerequisicaobuttons.pack(side=ctk.TOP, padx=5, pady=5, anchor='nw')

buttonrequisicaocriar = ctk.CTkButton(master=framerequisicaobuttons, text="Criar", fg_color="#029CFF", text_color="#fff",
                                      border_color="#000", width=164, height=42)
buttonrequisicaocriar.pack(side=ctk.TOP, padx=10, pady=10, anchor='nw')

buttonrequisicaolista = ctk.CTkButton(master=framerequisicaobuttons, text="Lista", fg_color="#029CFF", text_color="#fff",
                                      border_color="#000", width=165, height=42)
buttonrequisicaolista.pack(side=ctk.TOP, padx=10, pady=10, anchor='nw')

# Main content frame
frametest = ctk.CTkFrame(master=main, fg_color="#EDECEC")
frametest.pack(side=ctk.LEFT, padx=10, pady=10, anchor='nw', fill="both", expand=True)

main.mainloop()
