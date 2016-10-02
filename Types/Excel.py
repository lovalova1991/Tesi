list = []

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

        checkEqual()

        if (str(row[5].internal_value) == "EI" or str(row[5].internal_value) == "ETM" or str(row[5].internal_value) == "IAM") and (row[14].internal_value == str(semester) or row[14].internal_value == "Annuale") and (str(row[30].internal_value) != "tace"):

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

def checkEqual():
    last = ExcelDef("","","","","","","","","")
    for element in list:
       if str(last.nomeCorso) == str(element.nomeCorso):
           last.cdl = str(last.cdl) + ", " + str(element.cdl)
           last.anno = str(last.anno) + ", " + str(element.anno)
           last = element
           list.remove(element)
       else:
            last = element



def getExcelList():
    list.sort(key=lambda x: x.nomeCorso, reverse=False)
    return list

def getlengthList():
    return len(list)

def clearList():
    list.clear()