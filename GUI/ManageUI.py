from PyQt5.QtGui import QBrush
from PyQt5.QtGui import QColor
from PyQt5.QtGui import QStandardItem


class Manage():
    def setRows(self, prologModel, excelModel):

        for row in range(prologModel.rowCount()):
            nomeProlog = prologModel.data(prologModel.index(row, 0))
            nomeExcel = excelModel.data(excelModel.index(row, 0))
            if str(nomeProlog).lower() == str(nomeExcel).lower() or (str(nomeProlog).lower() + " ") == str(nomeExcel).lower():
                pass
            elif str(nomeProlog).lower() != str(nomeExcel).lower():
                excelModel.insertRow(row)
                continue
            elif str(nomeProlog) == "":
                excelModel.insertRow(row)
            elif str(nomeProlog).lower() != str(nomeExcel).lower():
                excelModel.removeRow(row)

        self.colorize(excelModel, prologModel)


    def colorize(self, excelModel, prologModel):

        for row in range(prologModel.rowCount()):

            if str(excelModel.data(excelModel.index(row, 0))).lower() == "none":
                if "_lab" in str(prologModel.data(prologModel.index(row, 1))).lower() or "lab_" in str(prologModel.data(prologModel.index(row, 2))).lower():
                    pass
                else:
                    for column in range(prologModel.columnCount()):
                        if str(prologModel.data(prologModel.index(row, column))).lower() != str(excelModel.data(excelModel.index(row, column))).lower():
                            toAdd = QStandardItem(str(prologModel.data(prologModel.index(row, column))))
                            toAdd.setBackground(QBrush(QColor(255, 155, 55, 200)))
                            prologModel.setItem(row, column, toAdd)


            elif str(prologModel.data(prologModel.index(row, 2))).lower() not in str(excelModel.data(excelModel.index(row, 1))).lower(): #confronto docente
                toAdd = QStandardItem(str(prologModel.data(prologModel.index(row, 2))))
                toAdd.setBackground(QBrush(QColor(255, 0, 0, 100)))
                prologModel.setItem(row, 2, toAdd)

            elif str(excelModel.data(excelModel.index(row, 4))).lower() != str(prologModel.data(prologModel.index(row, 5))).lower(): #confronto ore
                toAdd = QStandardItem(str(prologModel.data(prologModel.index(row, 5))))
                toAdd.setBackground(QBrush(QColor(255, 0, 0, 100)))
                prologModel.setItem(row, 5, toAdd)

            """"
            elif str(excelModel.data(excelModel.index(row, 2))).lower() != str(prologModel.data(prologModel.index(row, 4))).lower(): #confronto seguitoda
                toAdd = QStandardItem(str(prologModel.data(prologModel.index(row, 4))))
                toAdd.setBackground(QBrush(QColor(255, 0, 0, 100)))
                prologModel.setItem(row, 4, toAdd)
            """

