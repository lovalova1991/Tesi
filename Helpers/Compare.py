from Types import Excel, Prolog
from Types.Prolog import PrologDef
from Types.Result import ResultDef

newCorsi = []
class Compare():
    def startCompare(self):

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

        for excelelement in excelist:            #per ogni elemento nella lista del file excel

            lastelement = PrologDef("","","","","","","","","","","","")

            for prologelement in prologlist:           #per ogni elemento nella lista del file excprologel
                    if str(prologelement.fullname).lower() == str(lastelement.fullname).lower():
                        break
                    if str(prologelement.fullname).lower() == (str(excelelement.nomeCorso)).lower():
                            lastelement = prologelement
                            #Controllo che dal file excel confronto solo i corsi di informatica ed elettronica
                            #Nome del corso è la chiave primaria
                            listnames.append(str(excelelement.nomeCorso).lower())

                            #qui devo controllare con triennale o magistrale e anno
                            listCorsi = str(excelelement.cdl)

                            #qui devo aggiungere uno spazio tra numero e parola

                            #trova le differenze docente
                            if str(prologelement.docente).lower() not in str(excelelement.docente).lower():
                                if str(excelelement.docente) == "":
                                    docenteHint = "Tace"
                                    docente = None
                                else:
                                    docenteHint = excelelement.docente
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
            if(str(excelelement.nomeCorso).lower() not in listnames):
                newCorsi.append(ResultDef(excelelement.nomeCorso, "", excelelement.docente, excelelement.cdl, excelelement.anno, "", str(excelelement.ore / 12)))

        print("Compare Done")
        result.sort(key=lambda x: x.nomecorso, reverse=False)
        return result

    def getNewCorsi(self):
        return newCorsi

    def clearNewList(self):
        newCorsi.clear()