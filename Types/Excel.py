from Types.Result import ResultDef

list = []
toReturn = []
class ExcelDef():
    def __init__(self, num, nomeCorso, cdl, ToM, com, anno, periodo, ore, docente):
        self.num = num #0
        self.nomeCorso = nomeCorso #1
        self.cdl = cdl
        self.ToM = ToM
        self.com = com
        self.anno = anno
        self.periodo = periodo
        self.ore = ore
        self.docente = docente

def addToList(excelFile, semester):
    for row in excelFile.iter_rows():
        if (str(row[5].internal_value) == "EI" or str(row[5].internal_value) == "ETM" or str(row[5].internal_value) == "IAM") and (row[14].internal_value == str(semester) or row[14].internal_value == "Annuale"):
            list.append(ExcelDef(row[0].internal_value, #numero del corso presente nel file
                             str(row[1].internal_value), #nome del corso
                             row[5].internal_value, #cdl
                             row[7].internal_value, #ToM
                             row[9].internal_value, #com
                             row[13].internal_value, #anno
                             row[14].internal_value, #periodo
                             row[16].internal_value, #ore
                             row[29].internal_value, #docente
                             ))
    #checkCom()

def checkCom():
   for i in range(0, len(list)):
       try:
            if(str(list[i].com) == str(list[i+1].num)) or (str(list[i].com) == str(list[i-1].num)):
                if (str(list[i].com) == str(list[i+1].num) and str(list[i].com) == str(list[i+2].num)):
                    list[i].cdl = str(list[i].cdl) + "," + str(list[i+1].cdl) + "," + str(list[i+2].cdl)
                    print(list[i+1].nomeCorso)
                    print(list[i+2].nomeCorso)
                    list.remove(list[i+1])
                    list.remove(list[i+2])
                elif (str(list[i].com) == str(list[i-1].num) and str(list[i].com) == str(list[i-2].num)):
                    list[i].cdl = str(list[i].cdl) + "," + str(list[i - 1].cdl) + "," + str(list[i - 2].cdl)
                    print(list[i - 1].nomeCorso)
                    print(list[i - 2].nomeCorso)
                    list.remove(list[i - 1])
                    list.remove(list[i - 2])
                else:
                    list[i].cdl = str(list[i].cdl) + "," + str(list[i+1].cdl)
                    print(list[i-1].nomeCorso)
                    list.remove(list[i+1])
       except IndexError:
           print("ops")

def getExcelList():
    list.sort(key=lambda x: x.nomeCorso, reverse=False)
    return list

