from PyQt5.QtGui import QBrush
from PyQt5.QtGui import QColor
from PyQt5.QtGui import QStandardItem
from PyQt5.QtGui import QStandardItemModel
from PyQt5.QtWidgets import QMessageBox
from PyQt5.QtWidgets import QPushButton

from Types import Prolog

from Helpers import Compare

class CreateModel:

    def createPrologModel(self, prologView):
        listProlog = Prolog.getPrologList()

        for element in listProlog:
            if str(element.fullname).startswith("[pre"):
                listProlog.remove(element)

        self.prologModel = QStandardItemModel()
        self.prologModel.setHorizontalHeaderItem(0, QStandardItem("Elimina"))
        self.prologModel.setHorizontalHeaderItem(1, QStandardItem("Nome Corso"))
        self.prologModel.setHorizontalHeaderItem(2, QStandardItem("Nome Schematico"))
        self.prologModel.setHorizontalHeaderItem(3, QStandardItem("Docente"))
        self.prologModel.setHorizontalHeaderItem(4, QStandardItem("Numero Studenti"))
        self.prologModel.setHorizontalHeaderItem(5, QStandardItem("Seguito Da"))
        self.prologModel.setHorizontalHeaderItem(6, QStandardItem("Numero Ore"))
        self.prologModel.setHorizontalHeaderItem(7, QStandardItem("Laboratorio"))
        self.prologModel.setHorizontalHeaderItem(8, QStandardItem("Numero Slot"))
        self.prologModel.setHorizontalHeaderItem(9, QStandardItem("Durata Slot"))
        self.prologModel.setHorizontalHeaderItem(10, QStandardItem("Tipo"))
        self.prologModel.setHorizontalHeaderItem(11, QStandardItem("Link"))
        self.prologModel.setHorizontalHeaderItem(12, QStandardItem("Commento"))


        for row in range(0, len(listProlog)):

            # lista degli studenti che seguono il corso... qui si può fare di meglio
            tmp = str(listProlog[row].seguitoda).replace('[[', '')
            tmp1 = str(tmp).replace(']]', '')
            tmp2 = tmp1.split("][")
            listCorsi = tmp2

            nomecorso = QStandardItem(str(listProlog[row].fullname))
            shortName = QStandardItem(str(listProlog[row].nomecorso))
            docente = QStandardItem(str(listProlog[row].docente))
            numstudenti = QStandardItem(str(listProlog[row].numstudenti))
            seguitoda = QStandardItem(str(listCorsi))
            numore = QStandardItem(str(listProlog[row].numore))
            lab = QStandardItem(str(listProlog[row].lab))
            numslot = QStandardItem(str(listProlog[row].numslot))
            slotdur = QStandardItem(str(listProlog[row].slotdur))
            type = QStandardItem(str(listProlog[row].type))
            link = QStandardItem(str(listProlog[row].link))

            prologView.setModel(self.prologModel)

            self.prologModel.insertRow(row)

            # button per spostamento
            button = QPushButton()
            button.setText("Aggiungi")
            x = prologView.model().index(row, 0)
            prologView.setIndexWidget(x, button)
            # b.connect()

            #imposto il background dei laboratori
            if listProlog[row].fullname == "[]" or "lab" in str(listProlog[row].nomecorso):
                nomecorso.setBackground(QBrush(QColor(100, 200, 100, 100)))
                shortName.setBackground(QBrush(QColor(100, 200, 100, 100)))
                docente.setBackground(QBrush(QColor(100, 200, 100, 100)))
                numstudenti.setBackground(QBrush(QColor(100, 200, 100, 100)))
                seguitoda.setBackground(QBrush(QColor(100, 200, 100, 100)))
                numore.setBackground(QBrush(QColor(100, 200, 100, 100)))
                lab.setBackground(QBrush(QColor(100, 200, 100, 100)))
                numslot.setBackground(QBrush(QColor(100, 200, 100, 100)))
                slotdur.setBackground(QBrush(QColor(100, 200, 100, 100)))
                type.setBackground(QBrush(QColor(100, 200, 100, 100)))
                link.setBackground(QBrush(QColor(100, 200, 100, 100)))

            self.prologModel.setItem(row, 1, nomecorso)
            self.prologModel.setItem(row, 2, shortName)
            self.prologModel.setItem(row, 3, docente)
            self.prologModel.setItem(row, 4, numstudenti)
            self.prologModel.setItem(row, 5, seguitoda)
            self.prologModel.setItem(row, 6, numore)
            self.prologModel.setItem(row, 7, lab)
            self.prologModel.setItem(row, 8, numslot)
            self.prologModel.setItem(row, 9, slotdur)
            self.prologModel.setItem(row, 10, type)
            self.prologModel.setItem(row, 11, link)
            self.prologModel.setItem(row, 12, QStandardItem("Commenta..."))

            prologView.resizeColumnsToContents()

        return self.prologModel

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
            self.tableModel.setHorizontalHeaderItem(4, QStandardItem("Anno"))
            self.tableModel.setHorizontalHeaderItem(5, QStandardItem("Numero Ore"))
        except AttributeError:
            print("uops")

        excelView.setModel(self.tableModel)

        for row in range(0, len(listCorsi)):

            nomecorso = QStandardItem(str(listCorsi[row].nomecorso))
            docente = QStandardItem(str(listCorsi[row].docente))
            seguitoda = QStandardItem(str(listCorsi[row].seguitoda))
            anno = QStandardItem(str(listCorsi[row].anno))
            numore = QStandardItem(str(listCorsi[row].numore))
            docenteHint = QStandardItem(str(listCorsi[row].docenteHint))
            numoreHint = QStandardItem(str(listCorsi[row].numOreHint))

            self.tableModel.insertRow(row)

            #se sono corsi nuovi li evidenzio
            if listCorsi[row].docente == "" and listCorsi[row].numore == "":
                nomecorso.setBackground(QBrush(QColor(100,200,100,100)))
                docente.setBackground(QBrush(QColor(100, 200, 100, 100)))
                seguitoda.setBackground(QBrush(QColor(100, 200, 100, 100)))
                numore.setBackground(QBrush(QColor(100, 200, 100, 100)))
                anno.setBackground(QBrush(QColor(100, 200, 100, 100)))
                docenteHint.setBackground(QBrush(QColor(100, 200, 100, 100)))
                numoreHint.setBackground(QBrush(QColor(100, 200, 100, 100)))



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
            self.tableModel.setItem(row, 4, anno)

            if (listCorsi[row].numore == ""):
                numoreHint.setBackground(QBrush(QColor(200,100,100,100)))
                self.tableModel.setItem(row, 5, numoreHint)
            else:
                self.tableModel.setItem(row, 5, numore)

        excelView.resizeColumnsToContents()
        return self.tableModel

