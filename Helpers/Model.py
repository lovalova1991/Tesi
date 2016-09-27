from PyQt5.QtGui import QBrush
from PyQt5.QtGui import QColor
from PyQt5.QtGui import QStandardItem
from PyQt5.QtGui import QStandardItemModel
from PyQt5.QtWidgets import QMessageBox

from Types import Prolog

from Helpers import Compare

class CreateModel:

    def createPrologModel(self, prologView):
        listProlog = Prolog.getPrologList()
        for element in listProlog:
            if str(element.fullname).startswith("[pre"):
                listProlog.remove(element)

        self.prologModel = QStandardItemModel()


        self.prologModel.setHorizontalHeaderItem(0, QStandardItem("Nome Corso"))
        self.prologModel.setHorizontalHeaderItem(1, QStandardItem("Nome Schematico"))
        self.prologModel.setHorizontalHeaderItem(2, QStandardItem("Docente"))
        self.prologModel.setHorizontalHeaderItem(3, QStandardItem("Numero Studenti"))
        self.prologModel.setHorizontalHeaderItem(4, QStandardItem("Corso / Anno"))
        self.prologModel.setHorizontalHeaderItem(5, QStandardItem("Numero Ore"))
        self.prologModel.setHorizontalHeaderItem(6, QStandardItem("Laboratorio"))
        self.prologModel.setHorizontalHeaderItem(7, QStandardItem("Numero Slot"))
        self.prologModel.setHorizontalHeaderItem(8, QStandardItem("Durata Slot"))
        self.prologModel.setHorizontalHeaderItem(9, QStandardItem("Tipo"))
        self.prologModel.setHorizontalHeaderItem(10, QStandardItem("Link"))
        self.prologModel.setHorizontalHeaderItem(11, QStandardItem("Commento"))

        for row in range(0, len(listProlog)):
            listCorsi =  str(listProlog[row].seguitoda).replace("][", "],[")
            nomecorso = QStandardItem(str(listProlog[row].fullname))
            shortName = QStandardItem(str(listProlog[row].nomecorso))
            docente = QStandardItem(str(listProlog[row].docente))
            numstudenti = QStandardItem(str(listProlog[row].numstudenti))
            seguitoda = QStandardItem(str(listCorsi))
            numore = QStandardItem(str(listProlog[row].numore))
            lab = QStandardItem(str(listProlog[row].lab))
            numslot = QStandardItem(str(listProlog[row].numslot))
            if str(listProlog[row].slotdur) != "None":
                slotdur = QStandardItem(str(listProlog[row].slotdur))
            else:
                slotdur = QStandardItem("_")
            type = QStandardItem(str(listProlog[row].type))
            link = QStandardItem(str(listProlog[row].link))

            prologView.setModel(self.prologModel)

            self.prologModel.insertRow(row)

            #imposto il background dei laboratori
            if listProlog[row].fullname == "[]" or "_lab" in str(listProlog[row].nomecorso) or "lab_" in str(listProlog[row].nomecorso):
                nomecorso.setBackground(QBrush(QColor(65, 205, 255, 200)))
                shortName.setBackground(QBrush(QColor(65, 205, 255, 200)))
                docente.setBackground(QBrush(QColor(65, 205, 255, 200)))
                numstudenti.setBackground(QBrush(QColor(65, 205, 255, 200)))
                seguitoda.setBackground(QBrush(QColor(65, 205, 255, 200)))
                numore.setBackground(QBrush(QColor(65, 205, 255, 200)))
                lab.setBackground(QBrush(QColor(65, 205, 255, 200)))
                numslot.setBackground(QBrush(QColor(65, 205, 255, 200)))
                slotdur.setBackground(QBrush(QColor(65, 205, 255, 200)))
                type.setBackground(QBrush(QColor(65, 205, 255, 200)))
                link.setBackground(QBrush(QColor(65, 205, 255, 200)))

            self.prologModel.setItem(row, 0, nomecorso)
            self.prologModel.setItem(row, 1, shortName)
            self.prologModel.setItem(row, 2, docente)
            self.prologModel.setItem(row, 3, numstudenti)
            self.prologModel.setItem(row, 4, seguitoda)
            self.prologModel.setItem(row, 5, numore)
            self.prologModel.setItem(row, 6, lab)
            self.prologModel.setItem(row, 7, numslot)
            self.prologModel.setItem(row, 8, slotdur)
            self.prologModel.setItem(row, 9, type)
            self.prologModel.setItem(row, 10, link)
            self.prologModel.setItem(row, 11, QStandardItem("Commenta..."))

            prologView.resizeColumnsToContents()

        return self.prologModel

    def createExcelModel(self, excelView):
        listCorsi = Compare.Compare().startCompare()
        listNewCorsi = Compare.Compare().getNewCorsi()
        for element in listNewCorsi:
            listCorsi.append(element)

        #messagebox per controllare i nuovi corsi
        if (len(listNewCorsi) > 0):
            msg = QMessageBox()
            msg.setIcon(QMessageBox.Information)
            msg.resize(400, 400)
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
            self.tableModel.setHorizontalHeaderItem(0, QStandardItem("Nome Corso"))
            self.tableModel.setHorizontalHeaderItem(1, QStandardItem("Docente"))
            self.tableModel.setHorizontalHeaderItem(2, QStandardItem("Seguito Da"))
            self.tableModel.setHorizontalHeaderItem(3, QStandardItem("Anno"))
            self.tableModel.setHorizontalHeaderItem(4, QStandardItem("Numero Ore"))
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

            #se sono corsi nuovi li evidenzio in verde
            if listCorsi[row].docente == "" and listCorsi[row].numore == "":
                nomecorso.setBackground(QBrush(QColor(0,255,85,200)))
                docente.setBackground(QBrush(QColor(0, 255, 85, 200)))
                seguitoda.setBackground(QBrush(QColor(0, 255, 85, 200)))
                numore.setBackground(QBrush(QColor(0, 255, 85, 200)))
                anno.setBackground(QBrush(QColor(0, 255, 85, 200)))
                docenteHint.setBackground(QBrush(QColor(0, 255, 85, 200)))
                numoreHint.setBackground(QBrush(QColor(0, 255, 85, 200)))

            self.tableModel.setItem(row, 0, nomecorso)
            if (str(listCorsi[row].docente)) == str(None) or str(listCorsi[row].docente) == "":
                docenteHint.setBackground(QBrush(QColor(255,0,0,100)))
                self.tableModel.setItem(row, 1, docenteHint)
            else:
                self.tableModel.setItem(row, 1, docente)

            self.tableModel.setItem(row, 2, seguitoda)
            self.tableModel.setItem(row, 3, anno)

            if (listCorsi[row].numore == None):
                numoreHint.setBackground(QBrush(QColor(255,0,0,100)))
                self.tableModel.setItem(row, 4, numoreHint)
            else:
                self.tableModel.setItem(row, 4, numore)

        excelView.resizeColumnsToContents()
        return self.tableModel
