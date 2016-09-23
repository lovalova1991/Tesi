from Types import Excel
from Types import Prolog
from openpyxl import load_workbook

def loadProlog(filename):
    file = open(filename, 'r')
    for line in file:
        if str(line).startswith("corso("):
            temp0 = str(line).replace("corso(", '')
            temp1 = temp0.replace(").\n", '')
            Prolog.addToList(temp1)
    print("Prolog Loaded")
    return filename

def loadExcel(filename, prologFileName):
    excel = load_workbook(filename, data_only=True)
    semester = None
    ws = excel['Corsi']
    if str(prologFileName).endswith("1.pl"):
        semester = "1S"
    elif str(prologFileName).endswith("3.pl"):
        semester = "2S"
    Excel.addToList(ws, semester)
    print("Excel Loaded")