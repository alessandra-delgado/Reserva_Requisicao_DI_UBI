import pyodbc
import tkinter as tk
from tkinter import messagebox
from tkinter import ttk

# Conexão com o banco de dados SQL Server
def conectar_bd():
    try:
        conn = pyodbc.connect(
            'DRIVER={ODBC Driver 17 for SQL Server};'  # Atualize o driver se necessário
            'SERVER=172.31.160.1,1433;'                # Nome do servidor ou IP
            'DATABASE=testeUbi;'                       # Nome do banco de dados
            'UID=ubi;'                                 # Usuário do banco
            'PWD=ubi;'                                 # Senha do banco
        )
        return conn
    except pyodbc.Error as e:
        print("Erro de conexão:", e)
        messagebox.showerror("Erro de Conexão", "Não foi possível conectar ao banco de dados")
        return None

conn = conectar_bd()
cursor = conn.cursor()

# Função para adicionar equipamento
def adicionar_equipamento():
    nome = entry_nome.get()  # Obter nome do equipamento
    estado = entry_estado.get()  # Obter estado do equipamento
    estado = 'Available'

    if nome:
        cursor.execute("INSERT INTO Equipamento (nome, estado) VALUES (?, ?)", (nome, estado))
        conn.commit()
        messagebox.showinfo("Sucesso", "Equipamento adicionado com sucesso!")
        entry_nome.delete(0, tk.END)
        entry_estado.delete(0, tk.END)
        atualizar_lista_equipamentos()
    else:
        messagebox.showwarning("Erro", "Nome do equipamento é obrigatório.")

# Função para atualizar a lista de equipamentos (interface)
def atualizar_lista_equipamentos():
    lista_equipamentos.delete(*lista_equipamentos.get_children())
    cursor.execute("SELECT * FROM Equipamento")
    for equipamento in cursor.fetchall():
        lista_equipamentos.insert("", tk.END, values=(equipamento[0], equipamento[1], equipamento[2]))

# Função para registrar uma reserva
def registrar_reserva():
    try:
        ide = int(entry_ide_equipamento.get())
        essencial = entry_essencial.get()
        inicio = entry_data_inicio.get()
        fim = entry_data_fim.get()
        idu = entry_utilizador.get()
        inUse = ''

        # Verifica se o equipamento existe
        cursor.execute("SELECT * FROM Equipamento WHERE ide = ?", (ide,))
        equipamento = cursor.fetchone()
        if equipamento is None:
            messagebox.showwarning("Erro", "Equipamento não encontrado.")
            return

        cursor.execute("""
            EXEC CriarReserva
            @IDutilizador = ?,
            @inicio = ?,
            @fim = ?,
            @ide = ?,
            @essencial = ?,
            @inUse = ? OUTPUT
        """, idu, inicio, fim, ide, essencial, inUse)

        # Para capturar o valor do parâmetro OUTPUT
        inUse = cursor.fetchone()[0]
        print(inUse)

        conn.commit()
        messagebox.showinfo("Sucesso", "Reserva registrada com sucesso!")
        atualizar_lista_reservas()
    except ValueError:
        messagebox.showerror("Erro", "ID do equipamento deve ser um número.")

# Função para atualizar a lista de reservas
def atualizar_lista_reservas():
    lista_reservas.delete(*lista_reservas.get_children())
    cursor.execute("SELECT r.idr, r.periodo_uso_inicio, r.periodo_uso_fim, r.idu "
                   "FROM Reserva r")
    for reserva in cursor.fetchall():
        lista_reservas.insert("", tk.END, values=reserva)

# Interface principal com Tkinter
app = tk.Tk()
app.title("Sistema de Reservas de Equipamentos")
app.geometry("600x500")

# Seção de Cadastro de Equipamento
frame_equipamento = tk.LabelFrame(app, text="Adicionar Equipamento")
frame_equipamento.pack(fill="x", padx=5, pady=5)

tk.Label(frame_equipamento, text="Nome do Equipamento:").grid(row=0, column=0)
entry_nome = tk.Entry(frame_equipamento)
entry_nome.grid(row=0, column=1)

tk.Label(frame_equipamento, text="Estado:").grid(row=1, column=0)
entry_estado = tk.Entry(frame_equipamento)
entry_estado.grid(row=1, column=1)

tk.Button(frame_equipamento, text="Adicionar", command=adicionar_equipamento).grid(row=2, columnspan=2, pady=5)

# Lista de Equipamentos
frame_lista_equip = tk.LabelFrame(app, text="Equipamentos")
frame_lista_equip.pack(fill="both", padx=5, pady=5)

lista_equipamentos = ttk.Treeview(frame_lista_equip, columns=("Ide", "Nome", "Estado"), show="headings")
lista_equipamentos.heading("Ide", text="Ide")
lista_equipamentos.heading("Nome", text="Nome")
lista_equipamentos.heading("Estado", text="Estado")
lista_equipamentos.pack(fill="both", expand=True)

# Seção de Registro de Reserva
frame_reserva = tk.LabelFrame(app, text="Registrar Reserva")
frame_reserva.pack(fill="x", padx=5, pady=5)

tk.Label(frame_reserva, text="Ide do Equipamento:").grid(row=0, column=0)
entry_ide_equipamento = tk.Entry(frame_reserva)
entry_ide_equipamento.grid(row=0, column=1)

tk.Label(frame_reserva, text="Data Início (YYYY-MM-DD HH:MM):").grid(row=1, column=0)
entry_data_inicio = tk.Entry(frame_reserva)
entry_data_inicio.grid(row=1, column=1)

tk.Label(frame_reserva, text="Data Fim (YYYY-MM-DD HH:MM):").grid(row=2, column=0)
entry_data_fim = tk.Entry(frame_reserva)
entry_data_fim.grid(row=2, column=1)

tk.Label(frame_reserva, text="Utilizador:").grid(row=3, column=0)
entry_utilizador = tk.Entry(frame_reserva)
entry_utilizador.grid(row=3, column=1)

tk.Label(frame_reserva, text="Essencial:").grid(row=4, column=0)
entry_essencial = tk.Entry(frame_reserva)
entry_essencial.grid(row=4, column=1)

tk.Button(frame_reserva, text="Registrar Reserva", command=registrar_reserva).grid(row=5, columnspan=2, pady=5)

# Lista de Reservas
frame_lista_reserva = tk.LabelFrame(app, text="Reservas")
frame_lista_reserva.pack(fill="both", padx=6, pady=6)

lista_reservas = ttk.Treeview(frame_lista_reserva, columns=("ID", "Equipamento", "Início", "Fim", "Utilizador", "Essencial"), show="headings")
lista_reservas.heading("ID", text="ID Reserva")
lista_reservas.heading("Equipamento", text="Equipamento")
lista_reservas.heading("Início", text="Data Início")
lista_reservas.heading("Fim", text="Data Fim")
lista_reservas.heading("Utilizador", text="Utilizador")
lista_reservas.heading("Essencial", text="Essencial")
lista_reservas.pack(fill="both", expand=True)

# Atualiza as listas ao iniciar
atualizar_lista_equipamentos()
atualizar_lista_reservas()

app.mainloop()

# Fechar a conexão com o banco ao sair
conn.close()

