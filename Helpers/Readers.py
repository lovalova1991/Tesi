from Types import Excel
from Types import Prolog
from openpyxl import load_workbook

def loadProlog(filename):
    if filename.find(".pl") == -1:
        #messagebox.showerror("Error", "Il file specificato non è un file prolog.\n Riprova con un altro file.")
        return
    file = open(filename, 'r')
    for line in file:
        if str(line).startswith("corso("):
            temp0 = str(line).replace("corso(", '')
            temp1 = temp0.replace(").\n", '')
            Prolog.addToList(temp1)
    print("Prolog Loaded")
    return filename

def loadExcel(filename, prologFileName):
    if filename.find(".xlsx") == -1:
        #messagebox.showerror("Error", "Il file specificato non è un file excel.\nRiprova con un altro file.")
        return
    excel = load_workbook(filename, data_only=True)
    semester = None
    ws = excel['Corsi']
    if str(prologFileName).endswith("1.pl"):
        semester = "1S"
    elif str(prologFileName).endswith("3.pl"):
        semester = "2S"
    Excel.addToList(ws, semester)
    print("Excel Loaded")