from PyQt5 import QtCore, QtWidgets
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QBrush
from PyQt5.QtGui import QColor
from PyQt5.QtGui import QStandardItem
from PyQt5.QtWidgets import QFileDialog
from PyQt5.QtWidgets import QMenu
from PyQt5.QtWidgets import QMessageBox

from GUI.HelpDialog import HelpDialog
import webbrowser

from Helpers import Readers, Model, Save
from GUI import Resolution, ManageUI

class Ui_MainWindow(object):
    def setupUi(self, MainWindow, x, y):
        MainWindow.setObjectName("MainWindow")
        MainWindow.showMaximized()
        self.centralwidget = QtWidgets.QWidget(MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.gridLayoutWidget = QtWidgets.QWidget(self.centralwidget)
        self.gridLayoutWidget.setGeometry(QtCore.QRect(10, 10, x, 90))
        self.gridLayoutWidget.setObjectName("gridLayoutWidget")
        self.gridLayout = QtWidgets.QGridLayout(self.gridLayoutWidget)
        self.gridLayout.setContentsMargins(0, 0, 0, 0)
        self.gridLayout.setObjectName("gridLayout")
        self.label = QtWidgets.QLabel(self.gridLayoutWidget)
        self.label.setObjectName("label")
        self.gridLayout.addWidget(self.label, 0, 0, 1, 1, QtCore.Qt.AlignHCenter)
        self.label_2 = QtWidgets.QLabel(self.gridLayoutWidget)
        self.label_2.setObjectName("label_2")
        self.gridLayout.addWidget(self.label_2, 0, 1, 1, 1, QtCore.Qt.AlignHCenter)

        self.loadProlog = QtWidgets.QPushButton(self.gridLayoutWidget)
        self.loadProlog.setObjectName("loadProlog")
        self.gridLayout.addWidget(self.loadProlog, 3, 0, 1, 1)
        self.loadProlog.clicked.connect(self.pickprolog)
        self.label_3 = QtWidgets.QLabel(self.gridLayoutWidget)
        self.label_3.setObjectName("label_3")
        self.gridLayout.addWidget(self.label_3, 0, 2, 1, 1, QtCore.Qt.AlignHCenter)

        self.excelLoaded = QtWidgets.QLabel(self.gridLayoutWidget)
        self.excelLoaded.setText("")
        self.excelLoaded.setObjectName("excelLoaded")
        self.gridLayout.addWidget(self.excelLoaded, 1, 1, 1, 1)

        self.prologLoaded = QtWidgets.QLabel(self.gridLayoutWidget)
        self.prologLoaded.setText("")
        self.prologLoaded.setObjectName("prologLoaded")
        self.gridLayout.addWidget(self.prologLoaded, 1, 0, 1, 1)

        self.savedDone = QtWidgets.QLabel(self.gridLayoutWidget)
        self.savedDone.setText("")
        self.savedDone.setObjectName("savedDone")
        self.gridLayout.addWidget(self.savedDone, 1, 2, 1, 1)

        self.save = QtWidgets.QPushButton(self.gridLayoutWidget)
        self.save.setObjectName("save")
        self.gridLayout.addWidget(self.save, 3, 2, 1, 1)

        self.loadExcel = QtWidgets.QPushButton(self.gridLayoutWidget)
        self.loadExcel.setObjectName("loadExcel")
        self.loadExcel.setDisabled(True)
        self.gridLayout.addWidget(self.loadExcel, 3, 1, 1, 1)
        self.loadExcel.clicked.connect(self.pickexcel)

        self.gridLayoutWidget_2 = QtWidgets.QWidget(self.centralwidget)
        self.gridLayoutWidget_2.setGeometry(QtCore.QRect(9, 110, x, y))
        self.gridLayoutWidget_2.setObjectName("gridLayoutWidget_2")
        self.gridLayout_2 = QtWidgets.QGridLayout(self.gridLayoutWidget_2)
        self.gridLayout_2.setContentsMargins(0, 10, 0, 150)
        self.gridLayout_2.setObjectName("gridLayout_2")

        self.prologView = QtWidgets.QTableView(self.gridLayoutWidget_2)
        self.prologView.setObjectName("prologView")
        self.gridLayout_2.addWidget(self.prologView, 1, 0, 1, 1)

        self.excelView = QtWidgets.QTableView(self.gridLayoutWidget_2)
        self.excelView.setObjectName("excelView")
        self.gridLayout_2.addWidget(self.excelView, 1, 1, 1, 1)

        self.semestreLabel = QtWidgets.QLabel(self.gridLayoutWidget_2)
        self.semestreLabel.setObjectName("semestreLabel")
        self.gridLayout_2.addWidget(self.semestreLabel, 2, 0, 1, 0, QtCore.Qt.AlignHCenter)

        self.label_7 = QtWidgets.QLabel(self.gridLayoutWidget_2)
        self.label_7.setObjectName("label_7")
        self.gridLayout_2.addWidget(self.label_7, 0, 0, 1, 1, QtCore.Qt.AlignHCenter)

        self.label_8 = QtWidgets.QLabel(self.gridLayoutWidget_2)
        self.label_8.setObjectName("label_8")
        self.gridLayout_2.addWidget(self.label_8, 0, 1, 1, 1, QtCore.Qt.AlignHCenter)

        self.line = QtWidgets.QFrame(self.centralwidget)
        self.line.setGeometry(QtCore.QRect(10, 90, x, 50))
        self.line.setFrameShape(QtWidgets.QFrame.HLine)
        self.line.setFrameShadow(QtWidgets.QFrame.Sunken)
        self.line.setObjectName("line")

        MainWindow.setCentralWidget(self.centralwidget)
        self.menubar = QtWidgets.QMenuBar(MainWindow)
        self.menubar.setGeometry(QtCore.QRect(0, 0, x-100, 21))
        self.menubar.setObjectName("menubar")
        self.menuFile = QtWidgets.QMenu(self.menubar)
        self.menuFile.setObjectName("menuFile")
        self.menuInfo = QtWidgets.QMenu(self.menubar)
        self.menuInfo.setObjectName("menuInfo")
        MainWindow.setMenuBar(self.menubar)
        self.statusbar = QtWidgets.QStatusBar(MainWindow)
        self.statusbar.setObjectName("statusbar")
        MainWindow.setStatusBar(self.statusbar)

        self.actionApri_Prolog = QtWidgets.QAction(MainWindow)
        self.actionApri_Prolog.setObjectName("actionApri_Prolog")
        self.actionApri_Prolog.triggered.connect(self.pickprolog)

        self.actionApri_Excel = QtWidgets.QAction(MainWindow)
        self.actionApri_Excel.setObjectName("actionApri_Excel")
        self.actionApri_Excel.setDisabled(True)
        self.actionApri_Excel.triggered.connect(self.pickexcel)

        self.actionSalva = QtWidgets.QAction(MainWindow)
        self.actionSalva.setObjectName("actionSalva")

        self.actionEsci = QtWidgets.QAction(MainWindow)
        self.actionEsci.setObjectName("actionEsci")
        self.actionEsci.triggered.connect(self.quitbutton)

        self.actionHelp = QtWidgets.QAction(MainWindow)
        self.actionHelp.setObjectName("actionHelp")
        self.actionHelp.triggered.connect(self.openHelpWindow)
        self.actionGitHub_Repo = QtWidgets.QAction(MainWindow)
        self.actionGitHub_Repo.setObjectName("actionGitHub_Repo")
        self.actionGitHub_Repo.triggered.connect(self.openBrowser)

        self.actionAbout = QtWidgets.QAction(MainWindow)
        self.actionAbout.setObjectName("actionAbout")

        self.menuFile.addAction(self.actionApri_Prolog)
        self.menuFile.addAction(self.actionApri_Excel)
        self.menuFile.addSeparator()
        self.menuFile.addAction(self.actionSalva)
        self.menuFile.addSeparator()
        self.menuFile.addAction(self.actionEsci)
        self.menuInfo.addAction(self.actionHelp)
        self.menuInfo.addAction(self.actionGitHub_Repo)
        self.menuInfo.addSeparator()
        self.menuInfo.addAction(self.actionAbout)
        self.menubar.addAction(self.menuFile.menuAction())
        self.menubar.addAction(self.menuInfo.menuAction())

        self.prologView.setAlternatingRowColors(True)
        self.excelView.setAlternatingRowColors(True)

        self.excelView.hide()
        self.prologView.hide()
        self.label_7.hide()
        self.label_8.hide()

        prologheaders = self.prologView.verticalHeader()
        prologheaders.setContextMenuPolicy(Qt.CustomContextMenu)
        prologheaders.customContextMenuRequested.connect(self.prologClicked)

        excelheaders = self.excelView.verticalHeader()
        excelheaders.setContextMenuPolicy(Qt.CustomContextMenu)
        excelheaders.customContextMenuRequested.connect(self.excelClicked)

        self.retranslateUi(MainWindow)
        self.prologView.verticalScrollBar().valueChanged.connect(self.onValueChanged)

        QtCore.QMetaObject.connectSlotsByName(MainWindow)

        self.save.clicked.connect(self.saveClicked)

    def onValueChanged(self):
        row = self.prologView.currentIndex().row()
        if row > -1:
            h = self.excelView.horizontalHeader()
            for i in range(h.count()):
                if not h.isSectionHidden(i) and h.sectionViewportPosition(i) >= 0:
                    self.excelView.scrollTo(self.excelView.model().index(row, i))
                    break

    def openHelpWindow(self):
        print("seconda finestra di help")

    def quitbutton(self):
        msg = QMessageBox()
        msg.setIcon(QMessageBox.Question)
        msg.setText("Uscita")
        msg.setInformativeText("Sei sicuro di voler uscire?")
        msg.setWindowTitle("Uscita")
        msg.setStandardButtons(QMessageBox.Ok | QMessageBox.Cancel)
        ret = msg.exec_()
        if ret == QMessageBox.Ok:
            sys.exit()
        elif ret == QMessageBox.Cancel:
            msg.close()

    def openBrowser(self):
        new = 2
        url = "https://github.com/lovalova1991/tesiv3"
        webbrowser.open(url, new=new)

    def saveClicked(self):
        filename, _ = QFileDialog.getSaveFileName(filter="Excel files (*.pl)")
        Save.SaveFile().saveProlog(self.prologView, self.prologModel, filename, self.prologToSave)
        self.savedDone.setText("Salvato in " + str(filename))

    def prologClicked(self, point):
        menu = QMenu()
        delete = menu.addAction("Elimina")
        addRow = menu.addAction("Aggiungi riga qui..")
        answ = menu.exec_(self.prologView.mapToGlobal(point))
        if answ == delete:
            try:
                index = self.prologView.selectedIndexes()[0]
                id_us = self.prologView.model().data(index)
                msg = QMessageBox()
                msg.setIcon(QMessageBox.Warning)
                msg.setText("Attenzione")
                msg.setInformativeText("Sei sicuro di voler eliminare il corso\n" + str(id_us) + "?")
                msg.setWindowTitle("Elimina")
                msg.setStandardButtons(QMessageBox.Ok | QMessageBox.Cancel)
                ret = msg.exec_()
                if ret == QMessageBox.Ok:
                    self.prologModel.removeRow(index.row())
                    self.prologModel.insertRow(index.row())
                elif ret == QMessageBox.Cancel:
                    msg.close()
            except Exception:
                msg = QMessageBox()
                msg.setIcon(QMessageBox.Critical)
                msg.setText("Errore")
                msg.setInformativeText("Per eliminare un corso, prima devi selezionarne uno!")
                msg.setWindowTitle("Errore")
                msg.setStandardButtons(QMessageBox.Ok)
                ret = msg.exec_()
                if ret == QMessageBox.Ok:
                    msg.close()
        elif answ == addRow:
            index = self.prologView.selectedIndexes()[0]
            msg = QMessageBox()
            msg.setIcon(QMessageBox.Warning)
            msg.setText("Attenzione")
            msg.setInformativeText("Sei sicuro di voler aggiungere una riga qui?")
            msg.setWindowTitle("Aggiungi riga")
            msg.setStandardButtons(QMessageBox.Ok | QMessageBox.Cancel)
            ret = msg.exec_()
            if ret == QMessageBox.Ok:
                self.prologModel.insertRow(index.row())
            elif ret == QMessageBox.Cancel:
                msg.close()

    def excelClicked(self, newpoint):
        menu = QMenu()
        add = menu.addAction("Aggiungi Corso..")
        answ = menu.exec_(self.prologView.mapToGlobal(newpoint))
        if answ == add:
            try:
                corsoindex = self.excelView.selectedIndexes()[0]
                id_us = self.excelView.model().data(corsoindex)
                msg = QMessageBox()
                msg.setIcon(QMessageBox.Warning)
                msg.setText("Attenzione")
                msg.setInformativeText("Vuoi aggiungere il corso " + str(id_us) + "?")
                msg.setWindowTitle("Aggiungi a Prolog")
                msg.setStandardButtons(QMessageBox.Ok | QMessageBox.Cancel)
                ret = msg.exec_()
                if ret == QMessageBox.Ok:
                    nomeCorso = QStandardItem(str(self.excelModel.data(self.excelModel.index(corsoindex.row(), corsoindex.column()))))
                    nomeCorso.setBackground(QBrush(QColor(0, 255, 85, 200)))
                    self.prologModel.appendRow(nomeCorso)
                elif ret == QMessageBox.Cancel:
                    msg.close()
            except Exception:
                msg = QMessageBox()
                msg.setIcon(QMessageBox.Critical)
                msg.setText("Errore")
                msg.setInformativeText("Per aggiungere un corso alla tabella Prolog, devi prima selezionare un corso!")
                msg.setWindowTitle("Aggiungi a Prolog")
                msg.setStandardButtons(QMessageBox.Ok)
                ret = msg.exec_()
                if ret == QMessageBox.Ok:
                    msg.close()

    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "Prolog Compare"))
        self.label.setText(_translate("MainWindow", "Passo 1"))
        self.label_2.setText(_translate("MainWindow", "Passo 2"))
        self.loadProlog.setText(_translate("MainWindow", "Carica Prolog"))
        self.label_3.setText(_translate("MainWindow", "Passo 3"))
        self.save.setText(_translate("MainWindow", "Salva"))
        self.loadExcel.setText(_translate("MainWindow", "Carica Excel"))
        self.label_7.setText(_translate("MainWindow", "Prolog File"))
        self.label_8.setText(_translate("MainWindow", "Excel File"))
        self.menuFile.setTitle(_translate("MainWindow", "File"))
        self.menuInfo.setTitle(_translate("MainWindow", "Info"))
        self.actionApri_Prolog.setText(_translate("MainWindow", "Apri Prolog.."))
        self.actionApri_Excel.setText(_translate("MainWindow", "Apri Excel.."))
        self.actionSalva.setText(_translate("MainWindow", "Salva"))
        self.actionEsci.setText(_translate("MainWindow", "Esci"))
        self.actionHelp.setText(_translate("MainWindow", "Help"))
        self.actionGitHub_Repo.setText(_translate("MainWindow", "GitHub Repo"))
        self.actionAbout.setText(_translate("MainWindow", "About.."))

    def pickexcel(self):
        filename, _ = QFileDialog.getOpenFileName(filter="Excel files (*.xlsx)")
        if filename != "":
            Readers.loadExcel(filename, self.prologFileName)
            self.excelLoaded.setText("File Excel selezionato: " + filename)
            self.excelModel = Model.CreateModel().createExcelModel(self.excelView)
            ManageUI.Manage().setRows(self.excelView, self.prologView, self.prologModel, self.excelModel)
            self.excelView.show()
            self.label_8.show()
        else:
            msg = QMessageBox()
            msg.setIcon(QMessageBox.Critical)
            msg.setText("Errore")
            msg.setInformativeText("Non hai selezionato nessun file!")
            msg.setWindowTitle("File non selezionato")
            msg.setStandardButtons(QMessageBox.Ok)
            msg.exec_()

    def pickprolog(self):
        filename, _ = QFileDialog.getOpenFileName(filter="Prolog files (*.pl)")
        if filename != "":
            self.prologFileName = Readers.loadProlog(filename)
            self.prologToSave = filename
            self.prologLoaded.setText("File Prolog selezionato: " + filename)
            self.prologModel = Model.CreateModel().createPrologModel(self.prologView)
            if str(filename).endswith("1.pl"):
                self.semestreLabel.setText("1° Semestre")
            elif str(filename).endswith("3.pl"):
                self.semestreLabel.setText("2° Semestre")
            self.label_7.show()
            self.prologView.show()
            self.loadExcel.setEnabled(True)
            self.actionApri_Excel.setEnabled(True)
        else:
            msg = QMessageBox()
            msg.setIcon(QMessageBox.Critical)
            msg.setText("Errore")
            msg.setInformativeText("Non hai selezionato nessun file!")
            msg.setWindowTitle("File non selezionato")
            msg.setStandardButtons(QMessageBox.Ok)
            msg.exec_()

if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication([])
    MainWindow = QtWidgets.QMainWindow()
    ui = Ui_MainWindow()
    resolution = app.desktop().screenGeometry()
    x, y = Resolution.ResolutionManager().getResolution(resolution)
    ui.setupUi(MainWindow, x, y)
    MainWindow.show()
    sys.exit(app.exec_())
