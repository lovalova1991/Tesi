from Types import Excel, Prolog
from Types.Result import ResultDef

newCorsi = []

def start():

    #inizializzo le variabili
    result = []
    listnames = []
    docente = None
    docenteHint = None
    listCorsi = None
    numOre = None
    numOreHint = None

    excelist = Excel.getExcelList()
    prologlist = Prolog.getPrologList()

    for prologelement in prologlist:            #per ogni elemento nella lista del file prolog

        for excelelement in excelist:           #per ogni elemento nella lista del file excel

                if str(prologelement.fullname).lower() == (str(excelelement.nomeCorso)).lower():

                    #Controllo che dal file excel confronto solo i corsi di informatica ed elettronica
                        #Nome del corso è la chiave primaria
                        listnames.append(str(excelelement.nomeCorso).lower())

                        #qui devo controllare con triennale o magistrale e anno
                        listCorsi = str(excelelement.cdl).split(",")

                        #trova le differenze docente
                        if str(prologelement.docente).lower() != str(excelelement.docente).lower():
                            docenteHint = prologelement.docente
                            docente = None
                        else:
                            docente = excelelement.docente

                        #numero ore settimanali da confrontare con il numero ore totali presenti nel file excel
                        #prologelement.numore è il totale di ore settimanali. Ogni corso ha durata 12 settimane quindi faccio il calcolo
                        oreTotProlog = float(prologelement.numore) * 12
                        if float(oreTotProlog) == float(excelelement.ore):
                            numOre = prologelement.numore
                        else:
                            numOreHint = excelelement.ore / 12
                            numOre = None


                        result.append(ResultDef(excelelement.nomeCorso, docente, docenteHint, listCorsi, excelelement.anno, numOre, numOreHint))

    for excelelement in excelist:
        if(str(excelelement.nomeCorso).lower() not in listnames) and (excelelement.periodo == "1S" or excelelement.periodo == "Annuale"):
            newCorsi.append(ResultDef(excelelement.nomeCorso, "", excelelement.docente, listCorsi, excelelement.anno, "", str(excelelement.ore / 12)))

    print("Compare Done")
    return result


def getNewCorsi():
    return newCorsi