from PyQt5.QtGui import QBrush
from PyQt5.QtGui import QColor
from PyQt5.QtGui import QStandardItem
from PyQt5.QtGui import QStandardItemModel
from PyQt5.QtWidgets import QMessageBox
from PyQt5.QtWidgets import QPushButton

from Types import Prolog, Excel

from Helpers import Compare

class CreateModel:

    def createPrologModel(self, prologView):
        listProlog = Prolog.getPrologList()
        listExcel = Excel.getExcelList()

        for element in listProlog:
            if str(element.fullname).startswith("[pre"):
                listProlog.remove(element)

        self.tableModel = QStandardItemModel()
        self.tableModel.setHorizontalHeaderItem(0, QStandardItem("Elimina"))
        self.tableModel.setHorizontalHeaderItem(1, QStandardItem("Nome Corso"))
        self.tableModel.setHorizontalHeaderItem(2, QStandardItem("Nome Schematico"))
        self.tableModel.setHorizontalHeaderItem(3, QStandardItem("Docente"))
        self.tableModel.setHorizontalHeaderItem(4, QStandardItem("Numero Studenti"))
        self.tableModel.setHorizontalHeaderItem(5, QStandardItem("Seguito Da"))
        self.tableModel.setHorizontalHeaderItem(6, QStandardItem("Numero Ore"))
        self.tableModel.setHorizontalHeaderItem(7, QStandardItem("Laboratorio"))
        self.tableModel.setHorizontalHeaderItem(8, QStandardItem("Numero Slot"))
        self.tableModel.setHorizontalHeaderItem(9, QStandardItem("Durata Slot"))
        self.tableModel.setHorizontalHeaderItem(10, QStandardItem("Tipo"))
        self.tableModel.setHorizontalHeaderItem(11, QStandardItem("Link"))
        self.tableModel.setHorizontalHeaderItem(12, QStandardItem("Commento"))


        for row in range(0, len(listProlog)):

            nomecorso = QStandardItem(str(listProlog[row].fullname))
            shortName = QStandardItem(str(listProlog[row].nomecorso))
            docente = QStandardItem(str(listProlog[row].docente))
            numstudenti = QStandardItem(str(listProlog[row].numstudenti))
            seguitoda = QStandardItem(str(listProlog[row].seguitoda))
            numore = QStandardItem(str(listProlog[row].numore))
            lab = QStandardItem(str(listProlog[row].lab))
            numslot = QStandardItem(str(listProlog[row].numslot))
            slotdur = QStandardItem(str(listProlog[row].slotdur))
            type = QStandardItem(str(listProlog[row].type))
            link = QStandardItem(str(listProlog[row].link))

            self.tableModel.insertRow(row)

            self.tableModel.setItem(row, 1, nomecorso)
            self.tableModel.setItem(row, 2, shortName)
            self.tableModel.setItem(row, 3, docente)
            self.tableModel.setItem(row, 4, numstudenti)
            self.tableModel.setItem(row, 5, seguitoda)
            self.tableModel.setItem(row, 6, numore)
            self.tableModel.setItem(row, 7, lab)
            self.tableModel.setItem(row, 8, numslot)
            self.tableModel.setItem(row, 9, slotdur)
            self.tableModel.setItem(row, 10, type)
            self.tableModel.setItem(row, 11, link)
            self.tableModel.setItem(row, 12, QStandardItem("Commenta..."))

            prologView.setModel(self.tableModel)

    def createExcelModel(self, excelView):
        listCorsi = Compare.start()
        listNewCorsi = Compare.getNewCorsi()
        for element in listNewCorsi:
            listCorsi.append(element)

        #messagebox per controllare i nuovi corsi
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
        try:
            self.tableModel = QStandardItemModel()
            self.tableModel.setHorizontalHeaderItem(0, QStandardItem("Aggiungi a Prolog"))
            self.tableModel.setHorizontalHeaderItem(1, QStandardItem("Nome Corso"))
            self.tableModel.setHorizontalHeaderItem(2, QStandardItem("Docente"))
            self.tableModel.setHorizontalHeaderItem(3, QStandardItem("Seguito Da"))
            self.tableModel.setHorizontalHeaderItem(4, QStandardItem("Numero Ore"))
            self.tableModel.setHorizontalHeaderItem(5, QStandardItem("Laboratorio"))
            self.tableModel.setHorizontalHeaderItem(6, QStandardItem("Tipo"))
        except AttributeError:
            print("uops")

        excelView.setModel(self.tableModel)

        for row in range(0, len(listCorsi)):

            nomecorso = QStandardItem(str(listCorsi[row].nomecorso))
            docente = QStandardItem(str(listCorsi[row].docente))
            seguitoda = QStandardItem(str(listCorsi[row].seguitoda))
            numore = QStandardItem(str(listCorsi[row].numore))
            lab = QStandardItem(str(listCorsi[row].lab))
            type = QStandardItem(str(listCorsi[row].type))
            docenteHint = QStandardItem(str(listCorsi[row].docenteHint.lower()))
            numoreHint = QStandardItem(str(listCorsi[row].numOreHint))
            typeHint = QStandardItem(str(listCorsi[row].typeHint))

            self.tableModel.insertRow(row)

            #se sono corsi nuovi li evidenzio
            if listCorsi[row].seguitoda == "Inserisci.." and listCorsi[row].numore == "Inserisci.." and listCorsi[row].type == "Inserisci..":
                nomecorso.setBackground(QBrush(QColor(100,200,100,100)))
                docente.setBackground(QBrush(QColor(100, 200, 100, 100)))
                seguitoda.setBackground(QBrush(QColor(100, 200, 100, 100)))
                numore.setBackground(QBrush(QColor(100, 200, 100, 100)))
                lab.setBackground(QBrush(QColor(100, 200, 100, 100)))
                type.setBackground(QBrush(QColor(100, 200, 100, 100)))
                docenteHint.setBackground(QBrush(QColor(100, 200, 100, 100)))
                numoreHint.setBackground(QBrush(QColor(100, 200, 100, 100)))
                typeHint.setBackground(QBrush(QColor(100, 200, 100, 100)))

            #button per spostamento
            b = QPushButton()
            b.setText("Aggiungi")
            x = excelView.model().index(row, 0)
            excelView.setIndexWidget(x, b)
            #b.connect()

            self.tableModel.setItem(row, 1, nomecorso)

            if (str(listCorsi[row].docente)) == str(None) or str(listCorsi[row].docente) == "":
                docenteHint.setBackground(QBrush(QColor(100,100,100,200)))
                self.tableModel.setItem(row, 2, docenteHint)
            else:
                self.tableModel.setItem(row, 2, docente)

            self.tableModel.setItem(row, 3, seguitoda)

            if (listCorsi[row].numore == None):
                numoreHint.setBackground(QBrush(QColor(200,100,100,100)))
                self.tableModel.setItem(row, 4, numoreHint)
            else:
                self.tableModel.setItem(row, 4, numore)

            self.tableModel.setItem(row, 5, lab)
            if(listCorsi[row].type == None):
                typeHint.setBackground(QBrush(QColor(100,100,200,100)))
                self.tableModel.setItem(row, 5, typeHint)

            self.tableModel.setItem(row, 6, type)



        excelView.resizeColumnsToContents()

