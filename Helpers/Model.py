from PyQt5.QtGui import QStandardItem
from PyQt5.QtGui import QStandardItemModel
from PyQt5.QtWidgets import QComboBox
from PyQt5.QtWidgets import QMessageBox
from Types import Prolog

from Helpers import Compare

class CreateModel:

    def createPrologModel(self, prologView):
        listProlog = Prolog.getPrologList()

        self.tableModel = QStandardItemModel()
        self.tableModel.setHorizontalHeaderItem(0, QStandardItem("Nome Corso"))
        self.tableModel.setHorizontalHeaderItem(1, QStandardItem("Docente"))
        self.tableModel.setHorizontalHeaderItem(2, QStandardItem("Numero Studenti"))
        self.tableModel.setHorizontalHeaderItem(3, QStandardItem("Seguito Da"))
        self.tableModel.setHorizontalHeaderItem(4, QStandardItem("Numero Ore"))
        self.tableModel.setHorizontalHeaderItem(5, QStandardItem("Laboratorio"))
        self.tableModel.setHorizontalHeaderItem(6, QStandardItem("Numero Slot"))
        self.tableModel.setHorizontalHeaderItem(7, QStandardItem("Durata Slot"))
        self.tableModel.setHorizontalHeaderItem(8, QStandardItem("Tipo"))
        self.tableModel.setHorizontalHeaderItem(9, QStandardItem("Link"))

        prologView.setModel(self.tableModel)
        for row in range(0, len(listProlog)):
            self.tableModel.insertRow(row)
            self.tableModel.setItem(row, 0, QStandardItem(str(listProlog[row].fullname)))
            self.tableModel.setItem(row, 1, QStandardItem(str(listProlog[row].docente)))
            self.tableModel.setItem(row, 2, QStandardItem(str(listProlog[row].numstudenti)))
            self.tableModel.setItem(row, 3, QStandardItem(str(listProlog[row].seguitoda)))
            self.tableModel.setItem(row, 4, QStandardItem(str(listProlog[row].numore)))
            self.tableModel.setItem(row, 5, QStandardItem(str(listProlog[row].lab)))
            self.tableModel.setItem(row, 6, QStandardItem(str(listProlog[row].numslot)))
            self.tableModel.setItem(row, 7, QStandardItem(str(listProlog[row].slotdur)))
            self.tableModel.setItem(row, 8, QStandardItem(str(listProlog[row].type)))
            self.tableModel.setItem(row, 9, QStandardItem(str(listProlog[row].link)))

        prologView.resizeColumnsToContents()

    def createExcelModel(self, excelView):
        listCorsi = Compare.start()
        listNewCorsi = Compare.getNewCorsi()

        if (len(listNewCorsi) > 0):
            msg = QMessageBox()
            msg.setIcon(QMessageBox.Information)
            msg.setText("Attenzione")
            msg.setInformativeText("Sono stati aggiunti dei corsi!")
            msg.setWindowTitle("Attenzione")
            toPrint = ""
            for element in listNewCorsi:
                toPrint = str(toPrint) + "*" + str(element.nomecorso) + "\n"
            msg.setDetailedText(toPrint)
            msg.exec_()

        self.tableModel = QStandardItemModel()
        self.tableModel.setHorizontalHeaderItem(0, QStandardItem("Nome Corso"))
        self.tableModel.setHorizontalHeaderItem(1, QStandardItem("Docente"))
        self.tableModel.setHorizontalHeaderItem(2, QStandardItem("Numero Studenti"))
        self.tableModel.setHorizontalHeaderItem(3, QStandardItem("Seguito Da"))
        self.tableModel.setHorizontalHeaderItem(4, QStandardItem("Numero Ore"))
        self.tableModel.setHorizontalHeaderItem(5, QStandardItem("Laboratorio"))
        self.tableModel.setHorizontalHeaderItem(6, QStandardItem("Numero Slot"))
        self.tableModel.setHorizontalHeaderItem(7, QStandardItem("Durata Slot"))
        self.tableModel.setHorizontalHeaderItem(8, QStandardItem("Tipo"))
        self.tableModel.setHorizontalHeaderItem(9, QStandardItem("Link"))

        excelView.setModel(self.tableModel)

        for row in range(0, len(listCorsi)):
            self.tableModel.insertRow(row)
            self.tableModel.setItem(row, 0, QStandardItem(str(listCorsi[row].nomecorso)))

            if (str(listCorsi[row].docente)) == str(None) or str(listCorsi[row].docente) == "":
                c = QComboBox()
                c.setEditable(True)
                # c.setBackgroundRole(QColor("red"))
                c.addItem(str(listCorsi[row].docenteHint).lower())
                i = excelView.model().index(row, 1)
                excelView.setIndexWidget(i, c)
            else:
                self.tableModel.setItem(row, 1, QStandardItem(str(listCorsi[row].docente)))

            self.tableModel.setItem(row, 2, QStandardItem(str(listCorsi[row].numstudenti)))
            self.tableModel.setItem(row, 3, QStandardItem(str(listCorsi[row].seguitoda)))

            if (listCorsi[row].numore == None):
                combo = QComboBox()
                combo.setEditable(True)
                combo.addItem("Inserisci..")
                combo.addItem(str(listCorsi[row].numOreHint))
                ind = excelView.model().index(row, 4)
                excelView.setIndexWidget(ind, combo)
            else:
                self.tableModel.setItem(row, 4, QStandardItem(str(listCorsi[row].numore)))

            self.tableModel.setItem(row, 5, QStandardItem(str(listCorsi[row].lab)))
            self.tableModel.setItem(row, 6, QStandardItem(str(listCorsi[row].numslot)))
            self.tableModel.setItem(row, 7, QStandardItem(str(listCorsi[row].slotdur)))
            self.tableModel.setItem(row, 8, QStandardItem(str(listCorsi[row].type)))
            self.tableModel.setItem(row, 9, QStandardItem(str(listCorsi[row].link)))

        for row in range(0, len(listNewCorsi)):
            self.tableModel.insertRow(row + len(listCorsi))
            self.tableModel.setItem(row + len(listCorsi), 0, QStandardItem(str(listNewCorsi[row].nomecorso)))

            if (str(listNewCorsi[row].docente)) == str(None) or str(listNewCorsi[row].docente) == "":
                c = QComboBox()
                c.setEditable(True)
                # c.setBackgroundRole(QColor("red"))
                c.addItem(str(listNewCorsi[row].docenteHint).lower())
                i = excelView.model().index(row + len(listCorsi), 1)
                excelView.setIndexWidget(i, c)
            else:
                self.tableModel.setItem(row + len(listCorsi), 1, QStandardItem(str(listNewCorsi[row].docente)))

            self.tableModel.setItem(row + len(listCorsi), 2, QStandardItem(str(listNewCorsi[row].numstudenti)))
            self.tableModel.setItem(row + len(listCorsi), 3, QStandardItem(str(listNewCorsi[row].seguitoda)))

            if (listNewCorsi[row].numore == None):
                combo = QComboBox()
                combo.setEditable(True)
                combo.addItem("Inserisci..")
                combo.addItem(str(listNewCorsi[row].numOreHint))
                ind = excelView.model().index(row + len(listCorsi), 4)
                excelView.setIndexWidget(ind, combo)
            else:
                self.tableModel.setItem(row + len(listCorsi), 4, QStandardItem(str(listNewCorsi[row].numore)))

            self.tableModel.setItem(row + len(listCorsi), 5, QStandardItem(str(listNewCorsi[row].lab)))
            self.tableModel.setItem(row + len(listCorsi), 6, QStandardItem(str(listNewCorsi[row].numslot)))
            self.tableModel.setItem(row + len(listCorsi), 7, QStandardItem(str(listNewCorsi[row].slotdur)))
            self.tableModel.setItem(row + len(listCorsi), 8, QStandardItem(str(listNewCorsi[row].type)))
            self.tableModel.setItem(row + len(listCorsi), 9, QStandardItem(str(listNewCorsi[row].link)))

        excelView.resizeColumnsToContents()