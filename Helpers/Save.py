
class SaveFile():
    def saveProlog(self, prologView, prologModel, filename, prologToSave):
        self.toSaveList = []
        for row in range(prologModel.rowCount()):
            try:
                nomecorso = str(prologModel.data(prologModel.index(row, 0))),  # nomecorso
                nomeschem = prologModel.data(prologModel.index(row, 1)),  # nome schematico
                docente = prologModel.data(prologModel.index(row, 2)),  # docente
                numstudenti = prologModel.data(prologModel.index(row, 3)),  # numero studenti
                seguitoda = prologModel.data(prologModel.index(row, 4)),  # corso / anno
                numore = prologModel.data(prologModel.index(row, 5)),  # numero ore
                lab = prologModel.data(prologModel.index(row, 6)),  # lab
                numslot = prologModel.data(prologModel.index(row, 7)),  # num slot
                durataslot = prologModel.data(prologModel.index(row, 8)),  # durata slot
                type = prologModel.data(prologModel.index(row,9)), # tipo
                link = prologModel.data(prologModel.index(row, 10)) #link
                commento = prologModel.data(prologModel.index(row, 11)) #commento

                if commento == None:
                    commento = " "
                elif str(commento) == "Commenta...":
                    commento = " "
                else:
                    commento = "% " + commento
            except TypeError:
                print("ops")

            stringToPrint = "corso(" + str(nomeschem).replace("(", "").replace(")", "").replace("'","")  + \
                            str(docente).replace("(", "").replace(")", "").replace("'","") + \
                            str(numstudenti).replace("(", "").replace(")", "").replace("'","")  + \
                            str(seguitoda).replace("(", "").replace(")", "").replace("'","").replace('"',"") + \
                            str(numore).replace("(", "").replace(")", "").replace("'","") + \
                            str(lab).replace("(", "").replace(")", "").replace("'","") + \
                            str(numslot).replace("(", "").replace(")", "").replace("'","").replace("/",",") + \
                            str(durataslot).replace("(", "").replace(")", "").replace("'","") + \
                            str(type).replace("(", "").replace(")", "").replace("'","") \
                             + "_," + str(nomecorso).replace("(", "").replace(")", "") .replace("'",'"')+ \
                             '"' + str(link).replace("(", "").replace(")", "").replace("'","") + ").  " + str(commento)

            self.toSaveList.append(stringToPrint)

        file = open(prologToSave, 'r')
        out_file = open(filename, "w")
        counter = 0
        for line in file:
            if str(line).startswith("corso("):
                if counter == len(self.toSaveList):
                    continue
                line = "%" + str(line)
                out_file.writelines(line + "\n")
                out_file.writelines(self.toSaveList[counter])
                counter = counter + 1
            else:
                out_file.writelines(line)
        out_file.close()



