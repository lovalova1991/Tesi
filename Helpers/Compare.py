
from Types import Excel, Prolog
from Types.Result import ResultDef

newCorsi = []

def start():

    #inizializzo le variabili
    result = []
    listnames = []
    nomeCorso = None
    type = None
    typeHint = None
    docente = None
    docenteHint = None
    numStudenti = None
    listCorsi = None
    numOre = None
    numOreHint = None
    lab = None
    numSlot = None
    slotDur = None
    link = None

    excelist = Excel.getExcelList()
    prologlist = Prolog.getPrologList()

    for prologelement in prologlist:            #per ogni elemento nella lista del file prolog

        for excelelement in excelist:           #per ogni elemento nella lista del file excel

            if str(excelelement.com) == "None":

                if str(prologelement.fullname).lower() == (str(excelelement.nomeCorso)).lower():

                    #Controllo che dal file excel confronto solo i corsi di informatica ed elettronica
                    if(str(excelelement.cdl) == "EI" or str(excelelement.cdl) == "ETM" or str(excelelement.cdl) == "IAM"):

                        #Nome del corso è la chiave primaria
                        nomeCorso = prologelement.fullname
                        listnames.append(str(prologelement.fullname).lower())

                        #lista degli studenti che seguono il corso... qui si può fare di meglio
                        tmp = str(prologelement.seguitoda).replace('[[', '')
                        tmp1 = str(tmp).replace(']]', '')
                        tmp2 = tmp1.split("][")
                        listCorsi = tmp2

                        #trova le differenze docente
                        if str(prologelement.docente).lower() != str(excelelement.docente).lower():
                            docenteHint = excelelement.docente
                            docente = None
                        else:
                            docente = prologelement.docente

                        #numero di Studenti indicativi per ogni corso
                        numStudenti = prologelement.numstudenti

                        #numero ore settimanali da confrontare con il numero ore totali presenti nel file excel
                        #prologelement.numore è il totale di ore settimanali. Ogni corso ha durata 12 settimane quindi faccio il calcolo
                        oreTotProlog = float(prologelement.numore) * 12
                        if float(oreTotProlog) == float(excelelement.ore):
                            numOre = prologelement.numore
                        else:
                            numOreHint = excelelement.ore / 12
                            numOre = None

                        #flag tipo
                        type = prologelement.type

                        #flag laboratorio
                        if prologelement.lab != "_":
                            lab = "si"
                            type = "__"
                            numOre = "__"
                        else:
                            lab = "no"

                        #durata di ogni lezione espressa in decimale e numero di lezioni settimanali
                        slotDurtmp = str(prologelement.slotdur).replace("[", "").replace("]", "")
                        slotDurtmp1 = str(slotDurtmp).split("/")
                        if len(slotDurtmp1) == int(prologelement.numslot):
                            numSlot = prologelement.numslot
                            if (x == slotDurtmp1[0] for x in slotDurtmp1):
                                slotDur = slotDurtmp1[0] + " ore"
                            else:
                                slotDur = slotDurtmp1


                        link = str(prologelement.link).split('")',1)[0].replace('"', "")

                        result.append(ResultDef(nomeCorso, docente, docenteHint, numStudenti, listCorsi, numOre, numOreHint,
                                                lab, numSlot, slotDur, type, typeHint, link))

    for excelelement in excelist:
        if(str(excelelement.nomeCorso).lower() not in listnames) and (str(excelelement.cdl) == "EI" or str(excelelement.cdl) == "ETM" or str(excelelement.cdl) == "IAM") and excelelement.periodo == "1S":
            newCorsi.append(ResultDef(excelelement.nomeCorso, excelelement.docente, None, "Inserisci..", "Inserisci..", None, str(excelelement.ore / 12),
                                    "Inserisci..", "Inserisci..", "Inserisci..", "Inserisci..", "Inserisci...", "Inserisci.."))



    print("Compare Done")
    return result


def getNewCorsi():
    return newCorsi