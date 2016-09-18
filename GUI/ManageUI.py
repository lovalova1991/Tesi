from PyQt5.QtGui import QBrush
from PyQt5.QtGui import QColor
from PyQt5.QtGui import QStandardItem


class Manage():

    def getElementsToRemove(self, prologModel, excelModel):
        prologList = []
        excelList = []
        templist = []

        for row in range(prologModel.rowCount()):
            prologList.append(str(prologModel.data(prologModel.index(row,1))).lower())
        for row in range(excelModel.rowCount()):
            excelList.append(str(excelModel.data(excelModel.index(row,1))).lower())

        for element in prologList:
            if element not in excelList and element != "[]":
                print(element)
                templist.append(element)

        for name in templist:
            for row in range(prologModel.rowCount()):
                if str(name).lower() == str(prologModel.data(prologModel.index(row, 1))).lower():
                    prologModel.appendRow(prologModel.takeRow(row))
                    prologModel.removeRow(row)
                    break

    def setRows(self, excelView, prologView, prologModel, excelModel):

        self.getElementsToRemove(prologModel, excelModel)

        for row in range(excelModel.rowCount()+2):
            nomecorso = prologModel.data(prologModel.index(row, 1))
            nomecorso1 = excelModel.data(excelModel.index(row, 1))

            if nomecorso == None:
                pass
            elif str(nomecorso) == "[]":
                pass
            elif str(nomecorso).lower() == str(nomecorso1).lower():
                pass
            else:
                prologModel.insertRow(row)
                for column in range(prologModel.columnCount()):         #inserisco le righe vuote per creare una maggiore corrispondenza
                    toAdd = QStandardItem(str(""))
                    toAdd.setBackground(QBrush(QColor(100,100,100,200)))
                    prologModel.setItem(row, column, toAdd)
