list = []
class ExcelDef():
    def __init__(self, num, nomeCorso, SSD, opt, cdl, orien, ToM, area, com, comAteneo, comunati, corInt, anno, periodo, cfu,
                       ore, att, param3, supporto, compDidattico, dataBando, dataAttr, daBandire, docenteAteneo, supplenzeEsterne, contrattiA,
                       contrattiB, docenteAnniTace, docente, tipo, ruolo, ruoloCom):
        self.num = num
        self.nomeCorso = nomeCorso
        self.SSD = SSD
        self.opt = opt
        self.cdl = cdl
        self.orien = orien
        self.ToM = ToM
        self.area = area
        self.com = com
        self.comAteneo = comAteneo
        self.comunati = comunati
        self.corInt = corInt
        self.anno = anno
        self. periodo = periodo
        self.cfu = cfu
        self.ore = ore
        self.att = att
        self.param3 = param3
        self.supporto = supporto
        self.compDidattico = compDidattico
        self.dataBando = dataBando
        self.dataAttr = dataAttr
        self.daBandire = daBandire
        self.docenteAteneo = docenteAteneo
        self.supplenzeEsterne = supplenzeEsterne
        self.contrattiA = contrattiA
        self.contrattiB = contrattiB
        self.docenteAnniTace = docenteAnniTace
        self.docente = docente
        self.tipo = tipo
        self.ruolo = ruolo
        self.ruoloCom = ruoloCom

def addToList(excelFile):
    for row in excelFile.iter_rows():
        list.append(ExcelDef(row[0].internal_value, #numero del corso presente nel file
                             row[1].internal_value, #nome del corso
                             row[3].internal_value, #SSD
                             row[4].internal_value, #penso sia l'aula
                             row[5].internal_value, #opzionale
                             row[6].internal_value, #corso di laurea
                             row[7].internal_value, #orientamento
                             row[8].internal_value, #triennale o magistrale
                             row[9].internal_value, #area
                             row[10].internal_value, #com ????
                             row[11].internal_value, #corsi tenuti in comunanza con altri atenei
                             row[12].internal_value, #comunati ????
                             row[13].internal_value, #cor int ????
                             row[14].internal_value, #anno del corso: se A è anno 1 della magistrale, 1-2 è anno 2 della magistrale, 1,2 o 3 sono triennale
                             row[15].internal_value, #periodo: 1° semestre è 1S, 2° semestre è 2S, annuale è Annuale
                             row[16].internal_value, #CFU del corso
                             row[17].internal_value, #ore di corso
                             row[18].internal_value, #tipo di corso
                             row[19].internal_value, #indicatore se è vero in caso il corso è di tipo A o B, la colonna è nascosta
                             row[20].internal_value, #supporto: SI se c'è il supporto
                             row[21].internal_value, #compito didattico
                             row[22].internal_value, #data bando
                             row[23].internal_value, #data attribuzione: contiene una data nel formato GG/MM/YYYY
                             row[24].internal_value, #da bandire: il campo contiene "bandire" se il corso è da bandire
                             row[25].internal_value, #docente ateneo
                             row[26].internal_value, #supplenze esterne
                             row[27].internal_value, #contratti A: non so a cosa serva questo campo
                             row[28].internal_value, #contratti B: vedi sopra
                             row[29].internal_value, #docente anni tace
                             row[30].internal_value, #docente in carica: contiene il nome del docente che tiene in corso o è un campo vuoto in caso di "da bandire"
                             row[31].internal_value, #tipo di profesore
                             row[32].internal_value)) #ruolo prof

def printList():
    for i in list:
        try:
           print(i.nomeCorso + "/" + i.docente + "/" + str(i.cdl) + "/" + str(i.anno) + "/" + str(i.ore) + "/" + i.periodo)
        except TypeError:
            print("\n\nerrore del corso " + i.nomeCorso)
        except ValueError:
            print("\n\nerrore")

def getExcelList():
    return list