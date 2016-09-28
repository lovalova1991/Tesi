import time
from PyQt5.QtWidgets import QMessageBox


class SaveFile():
    def saveProlog(self, prologModel, filename, prologToSave):
        self.toSaveList = []
        for row in range(prologModel.rowCount()):
            try:
                nomecorso = prologModel.data(prologModel.index(row, 0)),  # nomecorso
                nomeschem = prologModel.data(prologModel.index(row, 1)),  # nome schematico
                docente = prologModel.data(prologModel.index(row, 2)),  # docente
                numstudenti = prologModel.data(prologModel.index(row, 3)),  # numero studenti
                seguitoda = prologModel.data(prologModel.index(row, 4)),  # corso / anno
                numore = prologModel.data(prologModel.index(row, 5)),  # numero ore
                lab = prologModel.data(prologModel.index(row, 6)),  # lab
                numslot = prologModel.data(prologModel.index(row, 7)),  # num slot
                durataslot = prologModel.data(prologModel.index(row, 8)),  # durata slot
                type = prologModel.data(prologModel.index(row, 9)), # tipo
                link = prologModel.data(prologModel.index(row, 10)) #link
                commento = prologModel.data(prologModel.index(row, 11)) #commento

                if commento == None:
                    commento = " "
                elif str(commento) == "Inserisci Commento...":
                    commento = " "
                else:
                    commento = "% " + commento
            except TypeError:
                msg = QMessageBox()
                msg.setIcon(QMessageBox.Critical)
                msg.setText("Errore")
                msg.setInformativeText("Errore 5: contenuto non valido.")
                msg.setWindowTitle("Errore")
                msg.setStandardButtons(QMessageBox.Ok)
                msg.exec_()


            stringToPrint = "corso(" + str(nomeschem).replace("(", "").replace(")", "").replace("'","")  + \
                            str(docente).replace("(", "").replace(")", "").replace("'","") + \
                            str(numstudenti).replace("(", "").replace(")", "").replace("'","")  + \
                            str(seguitoda).replace("(", "").replace(")", "").replace("'","").replace('"',"") + \
                            str(numore).replace("(", "").replace(")", "").replace("'","") + \
                            str(lab).replace("(", "").replace(")", "").replace("'","") + \
                            str(numslot).replace("(", "").replace(")", "").replace("'","").replace("/",",") + \
                            str(durataslot).replace("(", "").replace(")", "").replace("'","") + \
                            str(type).replace("('", "").replace("',)", ",").replace("'","") \
                             + "_," + str(nomecorso).replace("('", '"').replace("',)", '"').replace('("','"').replace('",)', '"') + "," + '"' +\
                            str(link).replace(" '", "") + '").' + str(commento)

            self.toSaveList.append(stringToPrint)

        file = open(prologToSave, 'r')
        out_file = open(filename, "w")
        counter = 0
        try:
            out_file.writelines("%Creazione documento " + time.strftime("%d/%m/%Y"))
            for line in file:
                if str(line).startswith("corso(un_lab_indisponibile,"):
                    out_file.writelines(line)
                elif str(line).startswith("corso(Nomecorso,"):
                    out_file.writelines(line)
                elif str(line).startswith("corso("):
                    if counter == len(self.toSaveList):
                        continue
                    line = "%" + str(line)
                    out_file.writelines(line + "\n")
                    out_file.writelines(self.toSaveList[counter])
                    counter = counter + 1
                else:
                    out_file.writelines(line)
        except Exception:
            msg = QMessageBox()
            msg.setIcon(QMessageBox.Critical)
            msg.setText("Errore")
            msg.setInformativeText("Errore 6: Salvataggio non riuscito.")
            msg.setWindowTitle("Errore")
            msg.setStandardButtons(QMessageBox.Ok)
            msg.exec_()
            return
        out_file.close()



