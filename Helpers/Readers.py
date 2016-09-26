from PyQt5.QtWidgets import QMessageBox
from Types import Excel
from Types import Prolog
from openpyxl import load_workbook


def loadProlog(filename):


    try:
        file = open(filename, 'r')
        for line in file:
            if str(line).startswith("corso("):
                temp0 = str(line).replace("corso(", '')
                temp1 = temp0.replace(").\n", '')
                Prolog.addToList(temp1)
        print("Prolog Loaded")
        return filename

    except Exception:
        print(str(Exception))
        msg = QMessageBox()
        msg.setIcon(QMessageBox.Critical)
        msg.setText("Errore")
        msg.setInformativeText("Errore 1: lettura file Prolog\nControllare che sia in codifica UTF-8.")
        msg.setWindowTitle("Errore")
        msg.setStandardButtons(QMessageBox.Ok)
        msg.exec_()


def loadExcel(filename, prologFileName):

    try:
        excel = load_workbook(filename, data_only=True)
        ws = excel['Corsi']
        if str(prologFileName).endswith("1.pl"):
            Excel.addToList(ws, "1S")
        elif str(prologFileName).endswith("3.pl"):
            Excel.addToList(ws, "2S")
        print("Excel Loaded")

    except Exception:
        msg = QMessageBox()
        msg.setIcon(QMessageBox.Critical)
        msg.setText("Errore")
        msg.setInformativeText("Errore 2: lettura file Excel")
        msg.setWindowTitle("Errore")
        msg.setStandardButtons(QMessageBox.Ok)
        msg.exec_()