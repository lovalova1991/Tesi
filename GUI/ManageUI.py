from PyQt5.QtGui import QBrush
from PyQt5.QtGui import QColor
from PyQt5.QtGui import QStandardItem


class Manage():

    def getElementsToRemove(self, excelModel):

        for element in range(excelModel.rowCount()):

            if str(excelModel.data(excelModel.index(element,0))).lower() == str(excelModel.data(excelModel.index(element + 1, 0))).lower():
                if str(excelModel.data(excelModel.index(element, 0))).lower() == str(excelModel.data(excelModel.index(element + 2, 0))).lower():
                    excelModel.removeRow(element)
                    excelModel.removeRow(element+1)
                else:
                    excelModel.removeRow(element)

    def setRows(self, excelView, prologView, prologModel, excelModel):

        self.getElementsToRemove(excelModel)

        for row in range(excelModel.rowCount()):
            nomeProlog = prologModel.data(prologModel.index(row, 0))
            nomeExcel = excelModel.data(excelModel.index(row, 0))
            lastExcel = excelModel.data(excelModel.index(row - 1, 0))

            if str(lastExcel).lower() == str(nomeExcel).lower():
                if str(lastExcel).lower() == str(excelModel.data(excelModel.index(row - 2, 0))).lower():
                    excelModel.removeRow(row + 1)

                #devo inserire il corso mancante nella cella sopra
                excelModel.removeRow(row)
                pass
            elif str(nomeProlog).lower() != str(nomeExcel).lower():
                excelModel.insertRow(row)
                pass
            elif str(nomeProlog).lower() == str(nomeExcel).lower():
                pass

            elif str(nomeProlog).lower() != str(nomeExcel).lower():
                excelModel.removeRow(row)

        self.colorize(excelModel, prologModel)


    def colorize(self, excelModel, prologModel):

        for row in range(prologModel.rowCount()):

            if str(excelModel.data(excelModel.index(row, 0))).lower() == "none":
                if "[]" in str(prologModel.data(prologModel.index(row, 0))).lower() or "_lab" in str(prologModel.data(prologModel.index(row, 1))).lower() or "lab_" in str(prologModel.data(prologModel.index(row, 2))).lower():
                    pass
                else:
                    for column in range(prologModel.columnCount()):
                        if str(prologModel.data(prologModel.index(row, column))).lower() != str(excelModel.data(excelModel.index(row, column))).lower():
                            toAdd = QStandardItem(str(prologModel.data(prologModel.index(row, column))))
                            toAdd.setBackground(QBrush(QColor(200, 100, 200, 100)))
                            prologModel.setItem(row, column, toAdd)


            elif str(excelModel.data(excelModel.index(row, 1))).lower() != str(prologModel.data(prologModel.index(row, 2))).lower(): #confronto docente
                toAdd = QStandardItem(str(prologModel.data(prologModel.index(row, 2))))
                toAdd.setBackground(QBrush(QColor(200, 100, 200, 100)))
                prologModel.setItem(row, 2, toAdd)

            elif str(excelModel.data(excelModel.index(row, 2))).lower() != str(prologModel.data(prologModel.index(row, 4))).lower(): #confronto seguitoda
                toAdd = QStandardItem(str(prologModel.data(prologModel.index(row, 4))))
                toAdd.setBackground(QBrush(QColor(200, 100, 200, 100)))
                prologModel.setItem(row, 4, toAdd)

            elif str(excelModel.data(excelModel.index(row, 3))).lower() != str(prologModel.data(prologModel.index(row, 4))).lower(): #confronto ore
                toAdd = QStandardItem(str(prologModel.data(prologModel.index(row, 5))))
                toAdd.setBackground(QBrush(QColor(200, 100, 200, 100)))
                prologModel.setItem(row, 5, toAdd)
