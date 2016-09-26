

trimestre(3).

:- [macro].
:- lib(gfd).
%:- lib(edge_finder3).
%:- lib(fd_global).
%:- lib(propia).
%:- import alldifferent/1 from fd_global.

:- local struct(slot(idslot,nomecorso,start,duration,aula,day,chann,start_in_day,end_in_day)).

dates(prenotazione(Start,End),Start,End):-!.
%dates([auto,5],'27/02/2012','07/04/2012').
%dates([auto_seconda,5],'8/04/2012','05/06/2012').
dates(_,'02/03/2015','05/06/2015').

:- dynamic other_opt/1.
%other_opt([applia,ricercaoperativa,teorianumeri,sist_elaborazione]). % gli esami tipici degli info, LM
%other_opt([sist_informativi,sicurezza,economiaorgaz,metodiottimizzazione]). % gli esami tipici degli info, LM, anni B
%other_opt([ricercaoperativa,teorianumeri,sist_elaborazione,basidati]). % gli esami tipici degli auto, LM, anni A
%other_opt([elettronicatelecomunicazioni,propagazioneguidata,lab_sistemi,ricercaoperativa]). % gli esami obbligatori degli ele, LM
%other_opt([elettronicatelecomunicazioni,propagazioneguidata,strument_misure_elettr,lab_sistemi,ricercaoperativa]). % gli esami obbligatori degli tlc, LM

obj_group([info,1],4).
obj_group([ele,1],4).
obj_group([info,2],3).
obj_group([ele,2],3).
obj_group([ele,3],1).
obj_group([tlc,3],1).
obj_group([info,3],1).
obj_group([info_cento,3],1).
%obj_group([info_cento,4],1). % 2012/13: ottimizzo questi, perche' hanno gli esami tipici degli informatici
obj_group([info,5],1).
%obj_group([info,4],1). 2011/12: qui ci sono molti esami che nessuno sceglie. Metto esplicitamente in other_opt
obj_group([auto,3],2).
obj_group([auto,4],1).  % Negli anni B mi sembra sensato mettere questo, invece dell'other_opt.
obj_group([auto,5],1).
%obj_group([ele,4],1). % in questo trimestre hanno solo esami obbligatori
obj_group([ele,5],1).
obj_group([tlc,5],1).

% I laboratori del tipo "tipolab" non sono disponibili (preferibilmente) nell'orario
:- dynamic pref_no_times_lab/2.
pref_no_times_lab(info,lun(16.5)).

% Tipologie di studenti. Si fara` in modo che gli studenti di una tipologia
% non abbiano sovrapposizioni (cioe` se due corsi sono seguiti da una tipologia
% al 2 anno, allora non avranno sovrapposizioni).
types([info,info_cento,auto,auto_recupero,ele,tlc]).
subtype(info_cento,info).
subtype(auto_recupero,auto).

:- local struct(corso(nomecorso,docente,num_studenti,seguito_da,num_ore,lab,num_slot,slot_dur,type,mysql,full_name,link)).
%corso(nomecorso,docente,num_studenti,seguito_da,num_ore,Lab,num_slot,slot_min,slot_max).
% anni = lista degli anno di corso in cui un corso puo` essere nel piano di
%    studi di uno studente (ciascuno da 1 a 5)
% num_studenti = (ovvio)
% seguito_da = lista di liste di coloro che lo seguono
%   Il primo elemento della lista e` il "tipo" (diciamo [info,auto,tlc,ele])
%   il secondo elemento e` l'anno in cui quegli studenti hanno il corso.
%   Ad es, sistemi operativi e` al 2 anno per gli informatici ed al 4 per gli automatici
%   quindi [[info,2],[auto,4]]
% num_ore = numero di ore settimanali
% Nota che potrebbero esserci corsi tenuti piu` anni (quelli ad anni alterni sono
% per alcuni al 4 e per altri al 5)
% Lab: Se e` una variabile, vuol dire che il corso puo` essere tenuto in qualsiasi aula
%   se e` una costante, significa che deve essere tenuto nel laboratorio in questione
%
% Aggiungo un capo type, che dice il tipo di turni a cui e` soggetto
% year1 e` per il primo anno: qui non ci sono turni
% poi ci sara` un valore per dire che e` un corso con i turni (in cui vale il vincolo: o completamente sovrapposto o non sovrapposto)
%
% Aggiungo anche il campo mysql che contiene il codice mysql che mi ha dato Marco Schincaglia
%

% Se voglio dire che un corso di 7 ore ne svolge in realta` 3 in labinfo, scrivo
% corso(fondamenti1aula,gava,[1],150,[info,auto,tlc,ele],4,_,3,2,3).
% corso(fondamenti1lab,gava,[1],150,[info,auto,tlc,ele],3,labinfo,...).
% ovvero, definisco 2 corsi tenuti dallo stesso docente 
%
% Nel caso sia un laboratorio, si suppone che il vincolo di capacita` sia soddisfatto.
%
% num_slot = numero richiesto di slot. Se e` una variabile => any
% slot_min, slot_max = durata minima e massima di uno slot. Sono necessari!
%corso(fondamenti1,gava,,150,[info,auto,tlc,ele],7,_,3,2,3).
% MODIFICA 2009/10: invece di slot_min, slot_max, metto una lista con le durate slot_dur

corso(fisica2,vincenzi,150,[[info,1],[auto,1],[ele,1],[tlc,1]],7.5,_,3,[2.5,2.5,2.5],year1,7458,"Fisica II","http://www.unife.it/ing/informazione/fisica-ii").
%corso(fisica2meccanici,zavattini,1,[prenotazione],5,fisica2meccanici,2,[2.5,2.5],fixed,no_import,"Fisica II (meccanici)",_).

corso(reti_logiche_new,favalli,180,[[info,1],[auto,1],[ele,1],[tlc,1]],5,_,2,[2.5,2.5],year1,7455,"Analisi e sintesi dei circuiti digitali","http://www.unife.it/ing/informazione/analisi-sintesi-circuiti-digitali").

% 2014/15: Evelina mi ha chiesto di avere
% 1. il lab in parallelo a tutte le lezioni
% 2. una lezione di lab in piu` per il tutorato
corso(info2,lamma,180,[[info,1],[ele,1],[auto,1],[tlc,1]],5,_,2,[2.5,2.5],year1,7460,"Fondamenti di Informatica (Modulo B)","http://www.unife.it/ing/informazione/fondamenti-informatica").
corso(info2_lab_turno1,lamma,180,[[info,1],[auto,1],[ele,1],[tlc,1]],2.5,info,1,[2.5],noturni,7460,"Fondamenti di Informatica (Modulo B)","http://www.unife.it/ing/informazione/fondamenti-informatica").
%corso(info2_lab_turno2,lamma,180,[[ele,1],[tlc,1]],2.5,info,1,[2.5],noturni,7460,"Fondamenti di Informatica (Modulo B)","http://www.unife.it/ing/informazione/fondamenti-informatica").
corso(info2_lab_coinc,lamma_lab,180,[],5,info,2,[2.5,2.5],noturni,7460,"Fondamenti di Informatica (Modulo B)","http://www.unife.it/ing/informazione/fondamenti-informatica").

%2 lezioni in lab (orario qualunque, non e` necessario che coincida con una delle lezioni la mattina, il lab puo` anche essere la mattina alle 8
%per 2 turni.
%2 lezioni in aula, di cui una ha prenotato anche il lab, perche' Evelina alcune lezioni le fa direttamente in lab.


% 2 anno:
%Automazione, 20 studenti
%Informatica, 40 studenti
%Elettronica + Telecom, 60 studenti


%corso(retiditlc,mazzini,150,[[info,2],[auto,2],[tlc,2],[ele,2]],7.5,_,3,[2.5,2.5,2.5],year2,_,"Reti di telecomunicazioni","http://www.unife.it/ing/informazione/reti-di-telecomunicazioni").



corso(fond_automatica,bonfe,119,[[info,2],[auto,2],[tlc,2],[ele,2]],7.5,_,3,[2.5,2.5,2.5],year2,7358,"Fondamenti di Automatica","http://www.unife.it/ing/informazione/fond-automatica").
corso(elettronicadigitale,olivo,140,[[info,2],[auto,2],[ele,2],[tlc,2]],7.5,_,3,[2.5,2.5,2.5],year2,7357,"Elettronica Digitale","http://www.unife.it/ing/informazione/elettronica-digitale").
corso(elettronicadigitale_lab_turno1,olivo_lab1,160,[],2.5,info,1,[2.5],exceptional,7357,"Elettronica Digitale","http://www.unife.it/ing/informazione/elettronica-digitale").
%corso(elettronicadigitale_lab_turno2,olivo_lab,160,[[info,2],[auto,2],[ele,2],[tlc,2]],2,info,1,[2],exceptional,7357,"Elettronica Digitale","http://www.unife.it/ing/informazione/elettronica-digitale").


corso(segnalicomunicazioni,tralli,119,[[info,2],[auto,2],[tlc,2],[ele,2]],7.5,_,3,[2.5,2.5,2.5],year2,7366,"Segnali e Comunicazioni","http://www.unife.it/ing/informazione/segnali-comunicazioni").



corso(sistemioperativi,stefanelli,130,[[info,2],[auto,2],[ele,2],[tlc,2]],5,_,2,[2.5,2.5],year2,7368,"Sistemi Operativi","http://www.unife.it/ing/informazione/sistemi-operativi"). 
corso(sistemioperativi_lab,stefanelli_lab,60,[],2.5,info,1,[2.5],exceptional,7368,"Sistemi Operativi","http://www.unife.it/ing/informazione/sistemi-operativi").
%corso(sistemioperativi_bak,stefanelli_lezione,1,[prenotazione],5,fittizia_ste,2,[2.5,2.5],exceptional,7368,"Sistemi Operativi","http://www.unife.it/ing/informazione/sistemi-operativi").
%corso(sistemioperativi_bak,stefanelli_bak,60,[],2,_,1,2,3,"Sistemi Operativi","http://www.unife.it/ing/informazione/sistemi-operativi").


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ANNO 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


corso(sistemicontrollodigitale,simani,70,[[info,3],[info,5],[auto,3],[tlc,3],[ele,3],[auto_recupero,4]],5,_,2,[2.5,2.5],noturni,7367,"Sistemi di Controllo Digitale","http://www.unife.it/ing/informazione/scd").
corso(sistemicontrollodigitale_lab,simani,45,[[info,3],[info,5],[auto,3],[tlc,3],[ele,3],[auto_recupero,4]],2.5,info,1,[2.5],noturni,7367,"Sistemi di Controllo Digitale","http://www.unife.it/ing/informazione/scd").

corso(ingegneriaweb,zambrini,50,[[info_cento,3],[info_cento,4]],8,cento,2,[4,4],noturni,7359,"Ingegneria dei Sistemi Web","http://www.unife.it/ing/informazione/sistemi-web").

corso(ingsw,luglio,50,[[info_cento,3],[info_cento,4]],4,cento,1,[4],exceptional,7360,"Ingegneria del Software","http://www.unife.it/ing/informazione/Ingegneria-sw").
corso(metodimatematici,brasco,60,[[auto,3],[ele,3],[tlc,3],[auto_recupero,4],[ele,4],[tlc,4]],5,_,2,[2.5,2.5],turni,7426,"Metodi Matematici per l'Ingegneria","http://www.unife.it/ing/ls.tlcele/metodi-matematici").

corso(autom_industr,mainardi,19,[[auto,3],[auto_recupero,4]],5,_,2,[2.5,2.5],noturni,7435,"Automazione Industriale","http://www.unife.it/ing/informazione/Automazione_Industriale").
corso(autom_industr_lab,mainardi_lab,60,[],2.5,info,1,[2.5],exceptional,7435,"Automazione Industriale","http://www.unife.it/ing/informazione/Automazione_Industriale").

corso(strument_misure_elettr,bertozzi,75,[[ele,3],[ele,4],[tlc,4],[tlc,5]],5,_,2,[2.5,2.5],turni,7432,"Strumentazione e misure elettroniche","http://www.unife.it/ing/informazione/strumentazione-e-misure-elettroniche/").
corso(strument_misure_elettr_lab,bertozzi,75,[[ele,3],[ele,4],[tlc,4],[tlc,5]],2,ele,1,[2],noturni,7432,"Strumentazione e misure elettroniche","http://www.unife.it/ing/informazione/strumentazione-e-misure-elettroniche/").


%corso(commultimediali,chiarataddia,21,[[tlc,3],[tlc,4],[tlc,5]],5,_,2,[2.5,2.5],turni,31,"Comunicazioni Multimediali","http://www.unife.it/ing/informazione/comunicazioni-multimediali").
% Lo metto come 2 corsi, perche' altrimenti la nuova funzione obiettivo vede la lezione da 5 ore come una normalissima
% lezione e quindi riempie tutto il giorno per gli studenti (se mette questa piu` 2 lezioni, le pensa come 3 lezioni, ma sono comunque 10 ore ...)
corso(commultimediali,chiarataddia,21,[[tlc,3],[tlc,4]],2.5,_,1,[2.5],fixed,7419,"Comunicazioni Multimediali","http://www.unife.it/ing/informazione/comunicazioni-multimediali"). %
corso(commultimediali_part2,chiarataddia,21,[[tlc,3],[tlc,4]],2.5,_,1,[2.5],fixed,7419,"Comunicazioni Multimediali","http://www.unife.it/ing/informazione/comunicazioni-multimediali").

corso(basidati,ferraretti,100,[[info_cento,3],[info,3],[info,4],[auto,4],[auto_recupero,4]],5,_,2,[2.5,2.5],noturni,7437,"Basi di Dati","http://www.unife.it/ing/informazione/Basi_dati").
corso(basidati_lab,ferraretti_lab,30,[],2.5,info,1,[2.5],noturni,7437,"Basi di Dati","http://www.unife.it/ing/informazione/Basi_dati").


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LM INFORMATICA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 2012/13: secondo semestre
% 2012/13: Gli auto,5 non hanno RO in quanto per loro era obbligatorio al 1 anno (V seconda parte del manifesto)
% ANNI A
corso(ricercaoperativa,nonato,100,[[info,4],[info_cento,4],[info,5],[auto,4],[auto_recupero,4],[ele,4],[ele,5],[tlc,4],[tlc,5]],5,_,2,[2.5,2.5],noturni,7443,"Ricerca Operativa","http://www.unife.it/ing/ls.tlcele/ricerca-operativa"). 
corso(ricercaoperativa_lab,nonato_lab,50,[],2.5,info,1,[2.5],exceptional,7443,"Ricerca Operativa","http://www.unife.it/ing/ls.tlcele/ricerca-operativa"). 

% Anni B
%corso(metodiottimizzazione,nonato,20,[[info,4],[info,5]],5,_,2,[2.5,2.5],turni,_,"Metodi di Ottimizzazione","http://www.unife.it/ing/lm.tlcele/metodi-ottimizzazione").
%corso(metodiottimizzazione_lab,nonato_lab,2,[],2.5,info,1,[2.5],noturni,_,"Metodi di Ottimizzazione","http://www.unife.it/ing/lm.tlcele/metodi-ottimizzazione").


%% Anni alterni A:

corso(datamining,riguzzi,34,[[info,4],[info,5]],5,_,2,[2.5,2.5],noturni,11,"Data Mining and Analytics",_).
corso(datamining_lab,riguzzi_lab,1,[],5,info,2,[2.5,2.5],noturni,11,"Data Mining and Analytics",_).



% 2015/16: spostato al 1 periodo
% Anni B
% Tolgo i turni perche' non e` nei consigliati ele, tlc, auto
%corso(sist_informativi,riguzzi,36,[[info,4],[info,5]],5,_,2,[2.5,2.5],noturni,7445,"Sistemi Informativi","http://www.unife.it/ing/ls.infoauto/sistemi-informativi").
%corso(sist_informativi_lab,riguzzi_lab,10,[],5,info,2,[2.5,2.5],noturni,7445,"Sistemi Informativi","http://www.unife.it/ing/ls.infoauto/sistemi-informativi").

% Anni B
%corso(linguaggitraduttori,gavanelli,36,[[info,4],[info,5]],5,_,2,[2.5,2.5],noturni,7445,"Linguaggi e Traduttori",_).
%corso(linguaggitraduttori_lab,gavanelli_lab,10,[],2.5,info,2,[2.5],noturni,7445,"Linguaggi e Traduttori",_).
% Anni A
corso(constraintprogramming,gavanelli,36,[[info,4],[info,5]],5,_,2,[2.5,2.5],noturni,_,"Constraint Programming",_).
corso(constraintprogramming_lab,gavanelli_lab,10,[],5,info,2,[2.5,2.5],noturni,_,"Constraint Programming",_).

% Anni B
%corso(progautsistdigit,favalli,10,[[info,4],[info,5]],2.5,_,1,[2.5],turni,7441,"Progetto automatico dei sistemi digitali","http://www.unife.it/ing/ls.infoauto/progettazione-sistemi-digitali").
%corso(progautsistdigit_lab,favalli_lab,10,[],2.5,info,1,[2.5],noturni,7441,"Progetto automatico dei sistemi digitali","http://www.unife.it/ing/ls.infoauto/progettazione-sistemi-digitali").

% 2006/07
% tolgo ele,5, cosi` si puo` sovrapporre a scambio termico (tanto calcolo e` annuale)
% 2010/11: tolgo ele,5 e tlc,5 perche' e` del 1 anno di LS, che e` disattivato
%corso(calcolonumerico,ruggiero,50,[[info,4],[info,5],[ele,4],[ele,5],[tlc,4],[tlc,5]],5,_,2,[2.5,2.5],turni,7417,"Calcolo Numerico","http://www.unife.it/ing/ls.tlcele/calcolo-numerico/").
%corso(calcolonumerico_lab,ruggiero_lab,50,[],2.5,info,1,[2.5],exceptional,7417,"Calcolo Numerico","http://www.unife.it/ing/ls.tlcele/calcolo-numerico/").
%corso(calcolonumerico_lezione,ruggiero_lezione,50,[],5,fittizia_bon,2,[2.5,2.5],exceptional,52,"Calcolo Numerico","http://www.unife.it/ing/ls.tlcele/calcolo-numerico/").

% Anni B
% Sarebbe Mazzini (liv rete) e Simoncini (liv appli)
% lsimoncini@ing.unife.it
% 
%corso(tecnologiesicurezza,mazzini,30,[[info,4],[info,5],[tlc,4],[tlc,5]],7.5,_,3,[2.5,2.5,2.5],turni,_,"Tecnologie di Sicurezza in Internet","http://www.unife.it/ing/ls.tlcele/sicurezza-internet/").

% Anni B
% 2015/16: non e` piu` simoncini, ma carnevali
%corso(sicurezza,carnevali,30,[[info,4],[info,5]],5,_,2,[2.5,2.5],turni,7444,"Sicurezza dei sistemi informatici in Internet","http://www.unife.it/ing/lm.infoauto/sicurezza-si"). %"http://www.unife.it/ing/ls.tlcele/sicurezza-internet/"
%corso(sicurezza_lab,carnevali_lab,1,[],5,info,2,[2.5,2.5],turni,7444,"Sicurezza dei sistemi informatici in Internet","http://www.unife.it/ing/lm.infoauto/sicurezza-si"). %"http://www.unife.it/ing/ls.tlcele/sicurezza-internet/"



% anni A
corso(teorianumeri,codeca,60,[[info,4],[info_cento,4],[info,5],[auto,4],[auto,5],[tlc,5]],5,_,2,[2.5,2.5],turni,_,"Teoria dei Numeri e Fondamenti di Crittografia","http://www.unife.it/ing/ls.infoauto/Teoria-numeri-crittografia"). 

%corso(analisi_meccanici,codeca,1,[prenotazione],5,fittizio_codeca,2,[2.5,2.5],fixed,_,"Analisi meccanici (fittizio)",_).

% Anni A: 
% Lo metto anche come ele,5, perche' e` ad anni alterni, anche se forse potrebbe essere rimosso.
% 2012/13: tolgo tlc,5 perche' hanno troppi insegnamenti
% 2014/15: tolgo [info_cento,4] perche' altrimenti non riesco a fare un orario. Comunque Sist_elaborazione e` nella stessa tabella degli esami a scelta di Cento,
% per cui uno puo` averli entrambi solo se ne mette alcuni come crediti D
corso(sist_elaborazione,ruggeri,50,[[info,4],[info,5],[auto,4],[auto,5],[auto_recupero,4]],5,_,2,[2.5,2.5],noturni,169,"Sistemi di Elaborazione","http://www.unife.it/ing/ls.infoauto/sistemi-elaborazione").

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LM AUTOMAZIONE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Anni B
%corso(tecnologiesistemicontrollo,bonfe,21,[[auto,4],[auto_recupero,4],[auto,5],[auto_seconda,5]],5,_,2,[2.5,2.5],noturni,7447,"Tecnologie dei Sistemi di Controllo","http://www.unife.it/ing/lm.infoauto/tecnologie-tecniche").
%corso(tecnologiesistemicontrollo_lab,bonfe_lab,21,[],5,ele,2,[2.5,2.5],noturni,7447,"Tecnologie dei Sistemi di Controllo","http://www.unife.it/ing/lm.infoauto/tecnologie-tecniche").


corso(meccanica_applicata,digregorio,19,[[auto,4]],2.5,aulameccanici,1,[2.5],fixed,121,"Meccanica Applicata alle Macchine",_).
corso(meccanica_applicata2,digregorio,19,[[auto,4]],5,aulameccanici,2,[2.5,2.5],fixed,121,"Meccanica Applicata alle Macchine",_).

corso(meccanica_applicata_aulamia,digregorio,90,[[auto,4]],2.5,aulameccanici,1,[2.5],fixed,121,"Meccanica Applicata alle Macchine",_).

corso(meccanicarobot,digregorio2,10,[[auto,5]],7.5,_,3,[2.5,2.5,2.5],fixed,7349,"Meccanica dei Robot","http://www.unife.it/ing/ls.infoauto/meccanica-robot").
corso(meccanicarobot2,digregorio2,10,[[auto,5]],2.5,_,1,[2.5],fixed,7349,"Meccanica dei Robot","http://www.unife.it/ing/ls.infoauto/meccanica-robot").


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% LM ELETTRONICA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%GIORGIO: Direi che per noi sarebbe bene che non si sovrapponessero se possibile:
%
%OBBLIGATORI:
%1. Metodi matematici
%2. Calcolo numerico
%3. Strumentazione e misure elettroniche
%


%A SCELTA:
%4. Architettura dei sistemi digitali
%6. Antenne
%7. Elettronica industriale
%8. Progettazione di sistemi elettronici
%9. Dispositivi ottici
%12. Economia ed organizzazione aziendale
% Chimica applicata Ë solo per requisiti credo. Si puÚ non considerare. Credo sia dei meccanici.

%VELIO:
%1. Metodi matematici
%2. Calcolo numerico
%3. Strumentazione e misure elettroniche
%
%A scelta
%
%4. Architettura dei sistemi digitali
%5. Reti peer to peer
%6. Antenne
%7. Dispositivi ottici
%8. Comunicazioni multimediali II
%9. Comunicazioni multimediali



%%AA 2006/07: pare che sia tornato. Nella specialistica e` indicato anni A
%%AA 2005/06: pare non esista piu` corso(elettr_industr,vannini,30,[[ele,3],[ele,4],[auto,3],[tlc,3]],7,_,3,2,3,"Elettronica industriale","http://www.unife.it/ing/informazione/elettronica-industriale").
% Nel curriculum di automazione viene verbalmente consigliato di mettere come crediti D
% Elettronica Industriale al 3 anno.
% 2008/09: e` tornato
% Anni B
%corso(elettr_industr,vannini,30,[[ele,4],[ele,5],[auto,4],[auto,5]],5,_,2,[2.5,2.5],turni,7425,"Elettronica industriale","http://www.unife.it/ing/informazione/elettronica-industriale").

% Anni B
%% Nell'AA 2005/06 siamo stati costretti a cambiargli aula, perche' non ci stavano in aula 9
% 2013/14: dal manifesto sembra che sia in alternativa a reti wireless, per cui lo tolgo dai tlc.

%%%%ATTENZIONE! METTO NOTURNI PERCHE' MI HA CHIESTO UNA MODIFICA A LUGLIO ED
%%%%AVREBBE IMPATTATO SU ALTRI CORSI. L'ANNO PROSSIMO RIMETTERLO "TURNI"
%corso(architetturasistdigitali,bertozzi,36,[[ele,4],[ele,5]],5,_,2,[2.5,2.5],turni,7416,"Architettura dei sistemi digitali","http://www.unife.it/ing/ls.tlcele/architettura-sistemi-digitali").

% Reti peer to peer penso sia il vecchio reti di tlc II (da manifesto sono incompatibili)
% RetiTlc2 non e` nella tabella VI degli elettronici, per cui si potrebbe mettere noturni
% Anni B
%corso(peer2peer,mazzini,20,[[tlc,4],[tlc,5]],5,info,2,[2.5,2.5],turni,7430,"Reti peer-to-peer","http://www.unife.it/ing/lm.tlcele/peer-to-peer").

% Anni B
% 2013/14 mi pare non ci sia piu`
%corso(antenne,bellanca,10,[[ele,4],[ele,5],[tlc,4],[tlc,5]],5,_,2,[2.5,2.5],turni,7415,"Antenne","http://www.unife.it/ing/ls.tlcele/antenne/").
%corso(antenne_lab,bellanca_lab,1,[],2.5,info,3,[2.5],noturni,7415,"Antenne","http://www.unife.it/ing/ls.tlcele/antenne/").

% Anni A
%corso(ottici_microonde,bellanca,10,[[ele,5],[tlc,5]],5,_,2,[2.5,2.5],turni,_,"Progetto di componenti ottici e a microonde","http://www.unife.it/ing/lm.tlcele/ottici-microonde").
%corso(ottici_microonde_lab,bellanca_lab,10,[],2.5,info,1,[2.5],noturni,_,"Progetto di componenti ottici e a microonde","http://www.unife.it/ing/lm.tlcele/ottici-microonde").

% Anni B
%corso(reti_wireless,mazzini,10,[[tlc,4],[tlc,5]],5,_,2,[2.5,2.5],turni,_,"Reti Wireless","http://www.unife.it/ing/lm.tlcele/reti-wireless").

% Anni A
corso(affidabilita,zambelli,19,[[ele,5]],5,_,2,[2.5,2.5],turni,_,"Affidabilit&agrave; dei sistemi elettronici",_).

% Anni B
%corso(lab_sist_elettr,zambelli,19,[[ele,4],[ele,5]],5,_,2,[2.5,2.5],turni,_,"Laboratorio di sistemi elettronici integrati",_).


% apieracci@deis.unibo.it
% Anni B
%corso(progsistele,pieracci,40,[[ele,4],[ele,5]],5,_,2,[2.5,2.5],turni,7428,"Progettazione dei Sistemi Elettronici",_).

%%% Anni alterni: si` 2006/07
% 06/07: L'ho messo anche ele,4 perche' per gli studenti che hanno fatto 
% il piano di studi l'anno scorso era obbligatorio.
% 07/08: non lo metto piu` ele,4
% Anni B
%corso(dispositiviottici,trillo,30,[[ele,4],[ele,5],[tlc,4],[tlc,5]],5,_,2,[2.5,2.5],turni,7421,"Dispositivi Ottici","http://www.unife.it/ing/ls.tlcele/dispositivi-ottici").

% 04/05: propagazioneguidata: Olivo non ha chiesto espressamente che sia ele,4
% Visto che e` un corso di tlc cerco di soddisfare le sue specifiche (su 3 giorni)
% lo metto come eccezionale
% Anni A
corso(propagazioneguidata,trillo,50,[[ele,4],[ele,5],[tlc,4],[tlc,5]],5,_,2,[2.5,2.5],turni,154,"Propagazione Guidata","http://www.unife.it/ing/ls.tlcele/propagazione-guidata").

% Anni B
%corso(com_multimed_2,mazzini,30,[[tlc,4],[tlc,5]],5,_,2,[2.5,2.5],turni,7420,"Comunicazioni multimediali II","http://www.unife.it/ing/ls.tlcele/comunicazioni-multimediali-ii").




% 2010/11: lo fa Conti
% Anni A
corso(lab_sistemi,conti,50,[[ele,4],[tlc,4],[ele,5],[tlc,5]],5,_,2,[2.5,2.5],turni,106,"Laboratorio di segnali e sistemi","http://www.unife.it/ing/lm.tlcele/lab-segsis/").
%corso(lab_sistemi,rugin,10,[[ele,3],[tlc,3],[tlc,4],[tlc,5]],2,_,1,2,2,"Laboratorio di segnali e sistemi di telecomunicazioni","/elettronica/LabSegnSistemi/").

% Mi sembra eccessivo metterlo info,5
% Anni A
corso(sicurezza,mazzini,10,[[tlc,4],[tlc,5]],5,_,2,[2.5,2.5],turni,167,"Sicurezza, Progettazione e Laboratorio Internet","http://www.unife.it/ing/lm.tlcele/sicurezza-prog-internet/programma-del-corso").

%corso(automatica2,beghelli,19,[[auto,3]],2,_,1,2,2,"Automatica II (laboratorio)","/automatica/AutomaticaII/").

% Eve, 2009/10: Ho saputo da Dalpiaz che metterebbe informatica industriale al III trimestre il che porterebbe ad avere ing. del sw II al II trim (meta' lo farebbe giacomo gamebroni se ci danno il contratto)
%corso(ingsw2,alberti,18,[[info,5]],7,_,3,2,3,"Ingegneria del Software II","http://www.unife.it/ing/ls.infoauto/ing-sw-ii/").





corso(inglese,inlingua,1,[[tlc,1]],10,aula_inglese,2,[5,5],fixed,_,"Inglese","http://www.unife.it/ing/informazione/inglese").
%corso(inglese_turno2,inlingua,10,[[tlc,1],[ele,1]],  4,_,2,1,2,"Inglese","http://www.unife.it/ing/informazione/inglese").



%% Anni alterni A. 
% 2012/13: teme che nella 9 non ci stiano. Boh, vedremo. Intanto lo metto 34 (era 30)
%corso(dispositivielettronici,raffo,38,[[ele,5]],5,_,2,[2.5,2.5],turni,48,"Dispositivi Elettronici","http://www.unife.it/ing/ls.tlcele/dispositivi-elettronici/"). %solo anni A

% V Tralli
%Trasmissione numerica 2 non dovrebbe, se possibile, sovrapporsi a Reti di
%telecomunicazioni poiche' una parte di trasmissione numerica 2 coinvolge
%il docente di reti.

%% Anni alterni A 
%corso(trasmissionenumerica2,mazzini,10,[[tlc,4],[tlc,5]],7,_,3,2,3,"Trasmissione Numerica 2","http://www.unife.it/ing/ls.tlcele/TxNum2").


% Anni B

%corso(elabnumericasegnali,rugin,20,[[tlc,4],[tlc,5]],7.5,_,3,[2.5,2.5,2.5],noturni,69,"Elaborazione Numerica dei Segnali e laboratorio","/elettronica/ElabNumSegnali/").
%corso(elabnumericasegnali_lab,rugin_lab,20,[],2.5,ele,1,[2.5],noturni,69,"Elaborazione Numerica dei Segnali e laboratorio","/elettronica/ElabNumSegnali/").

% Anni A
%Vannini, 2007/08: ho la sensazione che l'aula 12 sia un po piccola per il corso di elettronica delle tlc.
%Gi‡ lo scorso anno era strapiena e mi immagino, guardando anche la situazione di industriale, pi˘ studenti. 
% 2012/13: L'aula 19 non va bene, perche' vuole il videoproiettore.
% Inoltre, teme che non ci stiano. Allora metto che ha 40 studenti, cosi` lo mette nella 7
corso(elettronicatelecomunicazioni,vannini,70,[[ele,4],[ele,5],[tlc,4],[tlc,5]],5,_,2,[2.5,2.5],turni,57,"Elettronica delle telecomunicazioni","http://www.unife.it/ing/ls.tlcele/elettronica-tlc").

% Anni B
% corso(termodinamica,frontera,10,[[ele,5]],7.5,_,3,[2.5,2.5,2.5],turni,232,"Termodinamica","/elettronica/Termodinamica/").


% Anni A
% 2016/17: e` al primo semestre
%corso(scambiotermico,piva,10,[[ele,5]],7.5,_,3,[2.5,2.5,2.5],turni,165,"Scambio Termico nei Sistemi Elettronici","http://www.unife.it/ing/ls.tlcele/scambio-termico/").


%corso(automatica,simani,19,[[auto,3]],7.5,_,3,[2.5,2.5,2.5],noturni,14,"Automatica (laboratorio)","http://www.unife.it/ing/informazione/automatica").
%corso(automatica_lab,simani_lab,19,[],5,info,2,[2.5,2.5],noturni,14,"Automatica (laboratorio)","http://www.unife.it/ing/informazione/automatica").



% Ma questo c'e` nel 2010/11?
%corso(geometria_mec,mazzanti_lab,65,[prenotazione],2.5,info,1,[2.5],fixed,_,"Geometria (civile)",_).

%corso(meccanicaapplicatamacchine,digregorio,19,[prenotazione('07/03/2011','08/06/2011')],5,_,2,[2.5,2.5],fixed,116,"Meccanica Applicata alle Macchince (meccanici)",_).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CORSI DEGLI INF/01 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Servono per evitare sovrapposizioni con i nostri corsi di automazione
%corso(ingsw_inf01,gianoli,1,[prenotazione],6,scienzemmffnn,3,[2,2,2],fixed,no_import,"Ing. Sw (scienze)",_).
%corso(grafica_inf01,didomenico,1,[prenotazione],6,scienzemmffnn,2,[3,3],fixed,no_import,"grafica comp. (scienze)",_).
%corso(elettrotecnica,elettrotecnica,1,[prenotazione],5,aula16,2,[2.5,2.5],fixed,no_import,"Elettrotecnica (meccanici)",_).


% 2011/12, Pinelli:
%io ti chiederei un giorno intero, mattina e pomeriggio. Quest'anno Ë stato
%mercoledÏ, ma puÚ andare bene anche giovedÏ.


% 2013/14, Pinelli:
% Io avrei bisogno, al secondo ciclo, del laboratorio piccolo, dal primo
% lunedi` di maggio fino a fine corsi, dalle 11.30 alle 18.15.
% Potrebbe andare bene, stesse ore stessi giorni, il mercoledi`, ma
% tienimi lunedi` come priorit‡
%corso(prog_fluido_lab,pinelli,1,[prenotazione],8,info,1,[8],fixed,7452,"Progettazione Fluidodinamica delle Macchine",_).





%%%%% CORSI FITTIZI PER RAPPRESENTARE L'OCCUPAZIONE DELLE AULE %%%%%
% Rita dice che non ci devono essere lezioni nei lab info il venerdi` dopo le 16.30
% Inoltre, il ven 14-16.30 ci puo` essere un solo lab utilizzato
% Quindi ho 2 prenotazioni (una per ogni lab) + un corso che puo` andare in uno dei 2 lab
corso(un_lab_indisponibile,un_lab_indisponibile,1,[prenotazione],2.5,info,1,[2.5],noturni,no_import,"Lab non disponibile",_).

%corso(infrastrutture_idrauliche,alvisi,60,[prenotazione],2.5,info,1,[2.5],noturni,7403,"Infrastrutture Idrauliche",_).

%corso(calcolo_numerico_civili,bonettini,60,[prenotazione],2.5,info,1,[2.5],noturni,_,"calcolo numerico (civile - industriale)",_).


%corso(scuola_acustica,pompoli_scuola_acustica,150,[],7,_,2,3,4,"Scuola di Acustica","http://acustica.ing.unife.it/scuola_acustica/").

%2012/13
%corso(modellistica_idraulica,caleffi,80,[],2.5,info,2,[2.5],fixed,_,"Modellistica idraulica","http://www.ing.unife.it/civilespec/2-ingciv-modellistica-idraulica/").



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CORSI DEI MECCANICI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2014/15
%corso(controlli_automatici_mec,bonfe_mec,119,[],5,fittizio_bonfe,2,[2.5,2.5],fixed,7358,"Controlli Automatici (mec)","http://www.unife.it/ing/informazione/fond-automatica").

% Prenotazioni lab info
% 2014/15
%corso(progetti_di_strutture,minghini,1,[],5,info,2,[2.5,2.5],fixed,7358,"Progetti di strutture",_).

% 2014/15
%corso(prog_fluido_lab,pinelli,10,[prenotazione],5.5,info,1,[5.5],lunch,147,"Progettazione Fluidodinamica delle Macchine",_).

% 2015/16
%corso(progetti_di_strutture,minghini,50,[],5,info,2,[2.5,2.5],fixed,7358,"Progetti di strutture",_).


% Il codice mysql di una prenotazione in generale non esiste
corso(Nomecorso,Docente,1,[prenotazione(StartDate,EndDate)],Num_ore,Lab,NumSlot,LDur,prenotazione,MySQL,FullName,Link):-
    prenotazione(Nomecorso,Docente,Lab,LStart,LDur,_,MySQL,FullName,Link,StartDate,EndDate),
    length(LStart,NumSlot),
    %minlist(LDur,Slot_min),
    %maxlist(LDur,Slot_max),
    Num_ore is sum(LDur).

:- local struct(prenotazione(nomecorso,docente,lab,lstart,ldurate,laule,mysql,full_name,link,startdate,enddate)).

%prenotazione(NomeCorso,Docente,Lab,ListaStartTimePrenotati,ListaDurate,ListaAule,FullName,Link).
% Le tre liste devono avere la stessa lunghezza.
% NOTA: Il docente non deve comparire altrove!!

%prenotazione(scienze_costr2,atralli,_,[lun(8.5)],[2.5],[5],"Scienza delle Costruzioni II",_).
%prenotazione(realizzazione_imp_ing_sanitaria,senise,_,[ven(8.5)],[5],[9],"Realizzazione di impianti di ingegneria sanitaria","http://www.ing.unife.it/civileambientale/1-c-amb-realiz-imp-ing-san-amb/").


%corso(scuola_acustica,pompoli_scuola_acustica,200,[prenotazione],7,_,2,3,4,"Scuola di Acustica","http://acustica.ing.unife.it/scuola_acustica/").
%prenotazione(scuola_acustica,pompoli_scuola_acustica,_,[50,55],[4,3],[1,1],"Scuola di Acustica","http://acustica.ing.unife.it/scuola_acustica/").
%prenotazione(termofisica_edifici,fausti,_,[19],[4],[7],"Termofisica degli edifici","http://www.ing.unife.it/civileambientale/1-c-civ-termofisica-degli-edifici").
%prenotazione(ingsw2ese,alberti_ese,_,[4],[2],[5],"Ingegneria del Software II","http://www.ing.unife.it/informatica/IngSw2/").
%prenotazione(idraulicafluviale,schippa,_,[7],[4],[12],"Idraulica Fluviale",_).
%prenotazione(orgcantiere2,biolcati,_,[1],[3],[7],"Organizzazione del cantiere II","http://www.ing.unife.it/civilespec/2-ingciv-organiz-del-cantiere-2/").
%prenotazione(pianificazione_territoriale,fedozzi,_,[mar(8)],[3],[7],"Pianificazione territoriale",_).


%prenotazione(deon_servizi_tecnici,stricchi,_,[gio(15)],[4],[5],"Gestione, organizzazione e deontologia dei servizi tecnici","http://www.ing.unife.it/civileambientale/1-d-gestione-organizzaz-deontologia-st").

%prenotazione(prenotazione_fittizia,prenotazione_fittizia,_,[59],[1],[19],"Fittizia",_).

% 2010/11
%prenotazione(susmel,susmel,info,[lun(8.5),mar(14)],[5,2.5],[lab_info_picc,lab_info_picc],203,"Verifiche strutturali",_,'04/04/2011','08/06/2011').
%prenotazione(infrastrutture_idrauliche,franchini,info,[gio(14)],[2.5],[lab_info],151,"Infrastrutture Idrauliche",_,'04/04/2011','08/06/2011').
%prenotazione(prova_prenotazione,prova,_,[ven(18)],[1],[12],_,"prova",_,'27/09/2011','23/11/2011').

%prenotazione(modellistica_idraulica,caleffi,_,[mer(14)],[2],[19],"Modellistica idraulica","http://www.ing.unife.it/civilespec/2-ingciv-modellistica-idraulica/").


% 2011/12
%prenotazione(meccanica_applicata,dalpiaz_digregorio,_,[lun(8.5),mar(14),mer(11)],[2.5,2.5,2.5],[5,5,5],no_import,"Meccanica Applicata alle Macchine",_,'27/02/2012','06/06/2012').
%prenotazione(meccanica_applicata2,dalpiaz_digregorio2,_,[lun(14)],[2.5],[5],no_import,"Meccanica Applicata alle Macchine",_,'27/02/2012','06/06/2012').

%prenotazione(fisica_tecnica_a_b,piva_meccanici,_,[mar(8.5),gio(8.5)],[2.5,2.5],[5,5],_,"Fisica tecnica A B",no_import,'27/02/2012','06/06/2012').

%prenotazione(scienza_costruzioni,antoniotralli,_,[lun(8.5)],[2.5],[1],_,"Scienza delle Costruzioni",no_import,'27/02/2012','06/06/2012').



prenotazione(lab_indisponibile1,lab_indisponibile1,info,[ven(16.5)],[2.5],[100],no_import,"Lab non disponibile",_,Inizio,Fine):-
	dates(skolem,Inizio,Fine).
prenotazione(lab_indisponibile2,lab_indisponibile2,info,[ven(16.5)],[2.5],[101],no_import,"Lab non disponibile",_,Inizio,Fine):-
	dates(skolem,Inizio,Fine).

% 2013/14
%prenotazione(chimica_appli_tecnologia_materiali,frignani,_,[ven(11)],[2.5],[1],_,"Chimica applicata e tecnologia dei materiali",_,_,_).

%prenotazione(macchine,venturini,_,[lun(11)],[2.5],[5],_,"Macchine",_,_,_).
%prenotazione(termodinamica,pompoli,_,[mar(8.5)],[2.5],[5],_,"Termodinamica, trasmissione del calore e termofisica degli edifici",_,_,_).
%prenotazione(fisica_tecnica,piva,_,[mer(8.5),ven(8.5)],[2.5,2.5],[5,5],_,"Fisica tecnica",_,_,_).
%prenotazione(acustica_appli_illuminotecnica,prodi,_,[gio(11)],[2.5],[5],_,"Acustica applicata e illuminotecnica",_,_,_).

%prenotazione(sistemi_produzione_energia_rinnovabili,morini,_,[lun(11)],[2.5],[7],_,"Sistemi di produzione dell'energia da fonti rinnovabili",_,_,_).
%prenotazione(modellistica_idraulica,caleffi,_,[mar(8.5),mer(8.5)],[2.5,2.5],[9,9],_,"Modellistica idraulica",_,_,_).
%prenotazione(gestione_ottimale_sistemi_idrici,creaco,_,[mar(14)],[2.5],[9],_,"Gestione ottimale dei sistemi idrici",_,_,_).
%prenotazione(impianti_tecnici_civili,fausti,_,[gio(8.5)],[2.5],[9],_,"Impianti tecnici civili",_,_,_).
%prenotazione(progetti_recupero_edilizio,bucci,_,[mer(11),gio(14)],[2.5,2.5],[12,9],_,"Progetti per il recupero edilizio",_,_,_).
%prenotazione(tecnologia_lavorazione_materiali_polimerici,scoponi,_,[lun(11),mar(14),gio(14)],[2.5,2.5,2.5],[12,12,12],_,"Tecnologie di lavorazione dei materiali polimerici",_,_,_).
%prenotazione(scienza_tecnologia_materiali,monticelli,_,[mar(8.5),gio(8.5),ven(8.5)],[2.5,2.5,2.5],[12,12,12],_,"Scienza e tecnologia dei materiali",_,_,_).

% 2014/15
%prenotazione(informatica_industriale,gamberoni,info,[mer(16.5),gio(16.5)],[2.5,2.5],[lab_info,lab_info],_,"Informatica Industriale (mec)","http://www.unife.it/ing/meccanica/studiare/insegnamenti/informatica-industriale",_,_).
%prenotazione(informatica_industriale2,gamberoni_ubiquo1,info,[mar(16.5)],[2.5],[lab_info],_,"Informatica Industriale <small>(mec) solo settimane dispari</small>","http://www.unife.it/ing/meccanica/studiare/insegnamenti/informatica-industriale",_,_).
%prenotazione(informatica_industriale3,gamberoni_ubiquo2,info,[mar(16.5)],[2.5],[lab_info_picc],_,"Informatica Industriale <small>(mec) solo settimane dispari</small>","http://www.unife.it/ing/meccanica/studiare/insegnamenti/informatica-industriale",_,_).

% Prenotazioni aule 2014/15
%prenotazione(costruzioni_idrauliche,franchini,_,[mar(11)],[2.5],[7],_,"Costruzioni idrauliche (civ)",_,_,_).
%prenotazione(topografia,russo,_,[mer(8.5)],[2.5],[5],_,"Topografia (civ)",_,_,_).
%prenotazione(idraulica,valiani,_,[gio(8.5)],[2.5],[7],_,"Idraulica (civ)",_,_,_).
%prenotazione(acustica_illuminotecnica,prodi,_,[gio(11)],[2.5],[7],_,"Acustica applicata e illuminotecnica (civ)",_,_,_).
%prenotazione(prog_flui,pinelli_aula9,_,[mer(11)],[2.5],[9],_,"Progettazione fluidodinamica della macchine",_,_,_).
%prenotazione(polim,scoponi_aula9,_,[mer(16.5)],[2.5],[9],_,"Tecnologie di lavorazione dei materiali polimerici",_,_,_).

% Prenotazioni aule 2015/16
%prenotazione(costruzioni_idrauliche,franchini,info,[mer(16.5)],[2.5],[100],_,"Costruzioni idrauliche (civ)",_,_,_).
%prenotazione(progettazione_elementi_costruttivi,biolcati,info,[lun(11)],[2.5],[100],_,"Progettazione degli elementi costruttivi (civ)",_,_,_).

%prenotazione(informatica_industriale,gamberoni,info,[mar(16.5),gio(16.5)],[2.5,2.5],[100,100],_,"Informatica Industriale (mec)","http://www.unife.it/ing/meccanica/studiare/insegnamenti/informatica-industriale",_,_).

% FINE Prenotazioni aule 2014/15

:- local struct(alias(nomecorso,seguito_da,secondname,secondweb)).
% Il corso 'nomecorso', quando e` seguito dagli studenti 'seguito da' si chiama in realta`
% 'secondname' ed ha come pagina 'secondweb'.
alias(internetumts,[tlc,4],"Internet e Sistemi Wireless","http://www.unife.it/ing/ls.tlcele/sistemi-wireless-i/").
%alias(tecniche_ctl,[auto,5],"Automazione (laboratorio)","http://www.unife.it/ing/ls.infoauto/automazione-lab/").

% L'orario del primo deve essere un sottoinsieme di quello del secondo.
% (intendendo che ogni slot del primo deve coincidere con uno slot del secondo)
% Nota: e` diverso dal fatto che un corso abbia due nomi, in quanto
% con il must coincide vengono date due aule.
%must_coincide([dinamicamodellistica_lab,dinamicamodellistica]).
must_coincide([controlli_automatici_mec,fond_automatica]).
must_coincide([linguaggihardware_lab,linguaggihardware]).
must_coincide([automatica1_lab,automatica1]).
must_coincide([automatica_lab,automatica]).
must_coincide([calcolonumerico_lab,calcolonumerico]).
%must_coincide([calcolonumerico_lezione,calcolonumerico]).
must_coincide([disegnoprogettoorganimacchine_lab,disegnoprogettoorganimacchine]).
must_coincide([sist_informativi_lab,sist_informativi]).
must_coincide([elabnumericasegnali_lab,elabnumericasegnali]).
must_coincide([autom_industr_lab,autom_industr]).
must_coincide([antenne_lab,antenne]).

must_coincide([sistemioperativi_lab,sistemioperativi]).
must_coincide([sistemioperativi_bak,sistemioperativi]).
must_coincide([elettronicadigitale_lab_turno1,elettronicadigitale]).
must_coincide([info2_lab_coinc,info2]).
must_coincide([tecnologiesistemicontrollo_lab,tecnologiesistemicontrollo]).
must_coincide([progautsistdigit_lab,progautsistdigit]).

must_coincide([ricercaoperativa_lab,ricercaoperativa]).
must_coincide([metodiottimizzazione_lab,metodiottimizzazione]).
must_coincide([appliia_lab,appliia]).
must_coincide([datamining_lab,datamining]).
must_coincide([basidati_lab,basidati]).
must_coincide([ottici_microonde_lab,ottici_microonde]).
must_coincide([sicurezza_lab,sicurezza]).
must_coincide([linguaggitraduttori_lab,linguaggitraduttori]).
must_coincide([constraintprogramming_lab,constraintprogramming]).
%must_coincide([metodimatematici,teorianumeri]).	% 2014/15: QUESTO SAREBBE BELLO, MA QUEST'ANNO NON CI RIUSCIAMO, PERCHE' CODECA` HA GIA` UNA LEZIONE COI MECCANICI

% La same_turn nella versione 2009/10 penso non abbia senso. Se serve, va riscritta
%same_turn([sistemioperativi_lab,sistemioperativi])
same_turn([fake1,fake2]).

symmetric([fake1,fake2]).
%symmetric([inglese_turno1,inglese_turno2]).

% 2012/13: questo e` un vincolo dei meccanici: il corso di di Gregorio non si deve sovrapporre a Economia, perche' per loro sono entrambi obbligatori
%no_overlap_corsi([meccanica_applicata,economiaorgaz]).
%no_overlap_corsi([meccanicarobot,economiaorgaz]).

no_overlap_corsi([sistemioperativi_bak,sistemioperativi_lab]).

% 2011/12: corsi degli INF/01 con quelli che devono mettere a scelta per poter entrare alla nostra LM
%no_overlap_corsi([elettrotecnica,fond_automatica,sistemicontrollodigitale]).
%no_overlap_corsi([ingsw_inf01,grafica_inf01,fond_automatica,sistemicontrollodigitale]).

%no_overlap_corsi([ricercaoperativa,sistemicontrollodigitale_lab,sistemicontrollodigitale,fond_automatica]). % 2012/13: non si devono sovrapporre per permettere agli INF/01 di passare alla nostra LM
no_overlap_corsi([sistemicontrollodigitale_lab,sistemicontrollodigitale,fond_automatica]). %2012/13: il corso di Marcello e quello di Silvio non si devono sovrapporre


%no_overlap_corsi([calcolonumerico_lezione,calcolonumerico_lab]).





% V Tralli
%Trasmissione numerica 2 non dovrebbe, se possibile, sovrapporsi a Reti di
%telecomunicazioni poiche' una parte di trasmissione numerica 2 coinvolge
%il docente di reti.
%no_overlap_corsi([trasmissionenumerica2,retiditlc]).

%diff_day_corsi([dummy1,dummy2]).
diff_day_corsi([ingsw,basidati]).
diff_day_corsi([ingegneriaweb,basidati]).
diff_day_corsi([sistemicontrollodigitale_lab,sistemicontrollodigitale]).
%%% QUESTI SONO PER LA LM:
%%% Nel 2012/13 ci siamo messi d'accordo con Elisa (Visto il piano degli studi di 3 studenti)
%%% questi 4 corsi: RO, appliia, sist_elaborazione, teorianumeri
%%% Probabilmente per il prossimo AA andra` cambiato
%diff_day_corsi([ingegneriaweb,sist_elaborazione]).
%diff_day_corsi([ingegneriaweb,appliia]).
%diff_day_corsi([ingegneriaweb,ricercaoperativa]).
%diff_day_corsi([ingegneriaweb,teorianumeri]).

diff_day_corsi([meccanicaazionamenti,meccanicaazionamenti_aulameccanici]).

% Nota: e` importante che le aule equivalenti vengano messe nell'ordine inverso
% all'euristica di selezione del valore.
aule_equivalenti([]).

% aula(Numero,Capacita)
% l'aula ha la capacita` descritta
:- local struct(aula(nomeaula,capacita,lab,tipolab,video,aircond,url,fullname)).
aula(1,250,n,_,s,s,"http://endif.unife.it/it/didattica/aule-dei-corsi-di-laurea-di-ingegneria",_).
aula(5,157,n,_,s,n,"http://endif.unife.it/it/didattica/aule-dei-corsi-di-laurea-di-ingegneria",_).    
aula(7,120,n,_,s,n,"http://endif.unife.it/it/didattica/aule-dei-corsi-di-laurea-di-ingegneria",_).
aula(9,35, n,_,s,n,"http://endif.unife.it/it/didattica/aule-dei-corsi-di-laurea-di-ingegneria",_).
aula(12,20,n,_,n,n,"http://endif.unife.it/it/didattica/aule-dei-corsi-di-laurea-di-ingegneria",_).
%aula(94,50,n,_,s,s,"http://endif.unife.it/it/didattica/aule-dei-corsi-di-laurea-di-ingegneria","G4").



% aule del vecchio dipartimento
%%% Non le abbiamo piu`!!
% 2008/09: Abbiamo scambiato con Fisica l'aula G4 con la 19.
% Io ho contato 38 sedie, anche se qui diceva 36
%aula(19,40,n,_,s,s,"http://www.unife.it/facolta/ing/servizi-agli-studenti/aule/aula-19",_). La 19 l'ha usata D'angelo (2013/14), forse posso usarla nei momenti in cui non la usa lui
aula(19,100,s,aula19,s,s,_,_). %QUESTA VA USATA IN ALTERNATIVA, SE IO DEVIDO DI NON USARLA
aula(666,10,n,_,n,n,_,"Sala riunioni 3 piano dipartimento di ingegneria").

aula(100,64, s,info,s,s,"http://endif.unife.it/it/didattica/laboratori-didattici/informatica/laboratorio-informatica-grande","Laboratorio di Informatica Grande").
aula(101,43,s,info,s,s,"http://endif.unife.it/it/didattica/laboratori-didattici/informatica/laboratorio-informatica-piccolo","Laboratorio di Informatica Piccolo").

%aula(lab_info,64, s,info,n,s,"http://www.ing.unife.it/sidi/cs_lab/cs_lab.htm","Laboratorio di Informatica Grande").
%aula(lab_dumec,15,s,info,n,n,_,"Laboratorio di Informatica (ex DU meccanica)").
%aula(lab_info_picc,12,s,info,n,s,"http://www.ing.unife.it/lab_didattica/informatica_piccolo/","Laboratorio di Informatica Piccolo").

% Il LIVA e` per gli informatici, quindi gli do un "tipolab" diverso!
aula(200,14,s,lab_liva,n,s,"http://www.unife.it/ing/servizi-agli-studenti/pagine-laboratori/laboratorio-ingegneria-informatica","Laboratorio di Ingegneria Informatica").

% Inizialmente l'avevo messo a 3000 posti
aula(300,27,s,ele,n,s,"http://www.unife.it/ing/servizi-agli-studenti/pagine-laboratori/laboratorio-di-elettronica/","Laboratorio di Elettronica"). % http://www.ing.unife.it/lab_didattica/elettronica/
%aula(scienze,300,s). In questo trimestre, niente corsi mutuati da scienze

aula(400,3000,s,cento,n,n,"http://www.unife.it/tecnopolo/cento","Cento").

% Aule fittizie per rappresentare i corsi tenuti da docenti in altri CdL
aula(1000,3000,s,scienzemmffnn,n,n,_,"Facolt&agrave; di Scienze MM FF NN").
aula(1001,3000,s,scienzemmffnn2,n,n,_,"Facolt&agrave; di Scienze MM FF NN").
aula(1002,250,s,aula2,n,n,_,"Aula 2").
aula(1003,40,s,aula3,n,n,_,"Aula 3").
aula(1004,120,s,aula4,n,n,_,"Aula 4").
aula(1006,175,s,aula6,n,n,_,"Aula 6").
aula(1008,120,s,aula8,n,n,_,"Aula 8").
aula(1010,20,s,aula10,n,n,_,"Aula 10").
aula(1011,20,s,aula11,n,n,_,"Aula 11").
aula(1013,78,s,aula13,n,n,_,"Aula 13").
aula(1014,78,s,aula14,n,n,_,"Aula 14").
aula(1020,38,s,aula20,n,s,_,"Aula 20").
% Nota come la 'g' assomiglia a '9'
aula(96,40,s,aulag6,n,n,_,"Aula G6").% Non sono sicuro della capacita`: non l'ho controllata
aula(910,40,s,aulag10,n,n,_,"Aula G10"). % Non sono sicuro della capacita`: non l'ho controllata

%aula(aula_meccanici,3000,s,aula_meccanici,n,n,_,"(ing meccanica)").
aula(2000,3000,s,fittizio_codeca,n,n,_,"").
aula(2001,3000,s,aula_inglese,n,n,_,"aula da definire").
aula(2002,3000,s,fittizio_prog,n,n,_,"").
aula(2003,3000,s,mecraz,n,n,_,"").
aula(2004,3000,s,aulameccanici,n,n,_,"aula fornita da Ing. Meccanica").







%docente_constr(NomeDocente,LSlots)
% E` un predicato che viene invocato con il nome del docente e con tutti i suoi slot.
% Deve implementare i vincoli del docente

:- dynamic docente_constr/2,docente_constr/3.
:- dynamic excluded_time/2, excluded_day/2, excluded_day_time/2, unpreferred_time/2, unpreferred_day/2, unpreferred_day_time/2.



% ORARI DEI MECCANICI 2014/15
fixed_course(controlli_automatici_mec,Start,_,_):- Start::[lun(16.5),gio(16.5)].

fixed_course(meccanica_applicata,Start,_,_):-    Start :: [lun(8.5)].
fixed_course(meccanica_applicata2,Start,_,_):-    Start :: [lun(14),mar(11)].
fixed_course(meccanica_applicata_aulamia,Start,_,_):-    Start :: [mer(11)].

% prenotazione lab 2014/15:
% L'alternativa puÚ essere il venerdÏ 9.00-16.00, ma se non Ë possibile il
% lunedÏ pomeriggio parliamone prima.

% 2015/16:
fixed_course(prog_fluido_lab,Start,_,_):-    Start :: [mer(8.5),ven(8.5)].

% 2015/16
fixed_course(meccanicarobot2,Start,_,_):- Start :: [mar(8.5)].
fixed_course(meccanicarobot,Start,_,_):- Start :: [lun(8.5),mar(11),mer(11)].

% 2014/15: identico all'anno scorso, ma tutte le lezioni sono in aula 5
fixed_course(meccanicaazionamenti,Start,_,_):- 
	Start :: [lun(14), mar(14), gio(14), ven(11)].
	
%2015/16
fixed_course(sistemicontrollodigitale,Start,_,_):-
	Start :: [lun(11), mar(11), mer(11)].
fixed_course(sistemicontrollodigitale_lab,Start,_,_):-
	Start :: [lun(11), mar(11), mer(11)].

fixed_course(autom_industr,Start,_,_):-    Start :: [mer(14),gio(16.5)].

fixed_course(analisi_meccanici,Start,_,_):-
%    Start :: [mer(8.5),gio(11)]. % Codeca fa un corso anche per noi
%    Start :: [mer(14),gio(11)].	% orario meccanici 2.4
    Start :: [mar(14),gio(11)].	% orario meccanici 2.5

fixed_course(inglese,Start,_,_):-    Start :: [lun(14),ven(14)].

% 2014/15, corsi fissi miei:
fixed_course(commultimediali,Start,_,_):-    Start :: [ven(14)].
fixed_course(commultimediali_part2,Start,_,_):-    Start :: [ven(16.5)].


% 2014/15: Prenotazioni lab
% Questo e` rimasto uguale nel 2015/16
fixed_course(progetti_di_strutture,Start,_,_):-    Start :: [lun(11),mar(8.5),mer(8.5)].

%%%%%%%%%%%%%%%%%% EXPECTIONAL COURSES %%%%%%%%%%%%%%%%%%%%%%%
% Sono i corsi che non possono stare nei turni.
% Viene invocato per ogni slot.
% Puo` staqbilire il dominio delle variabili StartTime, oppure
% dichiarare che non ha settato il dominio; in tal caso gli
% verra` dato un dominio a default (non quello dei turni, ovviamente).
%
% exceptional_course(+NomeCorso,?StartTime,+Durata,-SetDomain)

exceptional_course(Corso,Start,Dur,true):-
    call(prenotazione with [nomecorso:Corso,lstart:LStart,ldurate:LDur]),
    (foreach(ST,LStart),foreach(DU,LDur),foreach([ST,DU],OUT) do true),
%    member([Start,Dur],OUT) infers fd.
	table([Start,Dur],OUT).



% Cerchiamo di non usare le aule del vecchio dipartimento
%% Cambio idea: se faccio cosi` non usa mai le aule vecchio dip.
%% e diventa difficile fare l'orario
indomain_aula(X):-
   % X ## 19, X ## 20,
    frandom(Rand),
    (Rand>0.3 ->    indomain_random(X)
        ;   indomain_aula_piccola(X)).
%indomain_aula(X):-
%    X=20 ; X =19.


%%%%%%%%%%%%%%%%%% TITOLI DELLE TABELLE STUDENTI %%%%%%%%%%%%

title_html_stud(_,1,Title):- !,
    Title = "Ing dell'informazione, Anno 1".

title_html_stud(_,2,Title):- !,
    Title = "Ing dell'informazione, Anno 2".
title_html_stud(info,3,Title):- !,
    Title = "Ing dell'informazione, Curriculum Informatica FE, LT, Anno 3".
title_html_stud(info,4,Title):- !,
    Title = "Informatica, LM per chi NON ha fatto gli esami consigliati alla LT".
title_html_stud(info,5,Title):- !,
    Title = "Informatica, LM per chi ha fatto gli esami consigliati alla LT".
title_html_stud(info,1,Title):- !,
    Title = "Ing dell'informazione, Anno 1".
title_html_stud(info,2,Title):- !,
    Title = "Ing dell'informazione, Anno 2".
title_html_stud(ele,2,Title):- !,
    Title = "Ing dell'informazione, Anno 2".
title_html_stud(auto,2,Title):- !,
    Title = "Ing dell'informazione, Anno 2".
title_html_stud(tlc,2,Title):- !,
    Title = "Ing dell'informazione, Anno 2".

title_html_stud(info,N,Title):-
    concat_string(["Ing Informatica e dell'Automazione, Curriculum Informatica, LT, Anno ",N],Title).
title_html_stud(info_cento,N,Title):-
    (N>3 -> A is N-3, concat_string(["Ing dell'Informazione, Curriculum Informatica, LM, Anno ",A," corsi di Cento"],Title)
        ;   concat_string(["Ing dell'Informazione, Curriculum Informatica, LT, Anno ",N," corsi di Cento"],Title)
    ).
title_html_stud(auto,1,Title):- !,
    Title = "Ing dell'informazione, Curricula Automazione e Informatica, LT, Anno 1".
title_html_stud(auto,3,Title):- !,
    Title = "Ing dell'informazione, Curriculum Automazione, LT, Anno 3".
title_html_stud(auto,4,Title):- !,
    Title = "Ing Informatica e dell'Automazione, Curriculum Automazione, LM, anno 1".
title_html_stud(auto,5,Title):- !,
    Title = "Ing Informatica e dell'Automazione, Curriculum Automazione, LM, anno 2".
title_html_stud(auto,N,Title):-
    (N>3 -> A is N-3, concat_string(["Ing Informatica e dell'Automazione, Curriculum Automazione, LM, Anno ",A],Title)
        ;   concat_string(["Ing Informatica e dell'Automazione, Curriculum Automazione, LT, Anno ",N],Title)
    ).
title_html_stud(auto_seconda,5,Title):- !,
    Title = "Ing Informatica e dell'Automazione, Curriculum Automazione, LM, anno 2, seconde 6 settimane (dopo l'8 aprile 2012)".
title_html_stud(auto_recupero,_,Title):- !,
    Title = "LM Informatica e dell'Automazione, Curriculum Automazione, studenti che NON hanno dato alla LT gli esami consigliati".

title_html_stud(ele,4,Title):- !,
    Title = "Ingegneria Elettronica e delle Telecomunicazioni, Curriculum Elettronica, LM, Studenti che NON hanno dato alla LT gli esami consigliati".
title_html_stud(ele,5,Title):- !,
    Title = "Ingegneria Elettronica e delle Telecomunicazioni, Curriculum Elettronica, LM, Studenti che HANNO dato alla LT gli esami consigliati".
title_html_stud(ele,1,Title):- !,
    Title = "Ing dell'informazione, Anno 1".
title_html_stud(ele,3,Title):- !,
    Title = "Ing dell'informazione, Curriculum Elettronica, LT, Anno 3".
title_html_stud(ele,N,Title):-
    concat_string(["Ing Elettronica e delle Telecomunicazioni, LT, Anno ",N],Title).
title_html_stud(tlc,3,Title):- !,
    Title = "Ing dell'informazione, Curriculum Telecomunicazioni, LT, Anno 3".
title_html_stud(tlc,4,Title):- !,
    Title = "Ingegneria Elettronica e delle Telecomunicazioni, Curriculum Telecomunicazioni, LM, Studenti che NON hanno dato alla LT gli esami consigliati".
title_html_stud(tlc,5,Title):- !,
    Title = "Ingegneria Elettronica e delle Telecomunicazioni, Curriculum Telecomunicazioni, LM, Studenti che HANNO dato alla LT gli esami consigliati".
title_html_stud(tlc,1,Title):- !,
    Title = "Ing dell'informazione, Anno 1".
title_html_stud(tlc,N,Title):-
    concat_string(["Ing Elettronica e delle Telecomunicazioni, LT, Anno ",N],Title).
title_html_stud(mec,N,Title):-
    (N>3 -> A is N-3, concat_string(["(meccanica), LM, Anno ",A],Title)
        ;   concat_string(["(meccanica), LT, Anno ",N],Title)
    ).


turni_swap(X,X). % Non c'e` nessuno swap in questo trimestre

%%%%%%%%%%%%%%% Da Fare!
%check_spec_integrity:-
%   findall(C,(corso with
%       [nomecorso:NomeCorso,docente:Docente,num_studenti:NumStud,
%        seguito_da:SeguitoDa,num_ore:NumOre,lab:Lab,num_slot:NumSlot,slot_min:SlotMin,slot_max:SlotMax],

%       L), ,
%   check_corso_integrity(L).
%check_corso_integrity([]).
%check_corso_integrity([H|T]):-
%   H=
%   check_corso_integrity(T).

check_spec_integrity:-
    findall(N,current_predicate(corso/N),L),

    (L = [_] -> true
     ;  writeln("*** Errore di definizione del predicato corso ***"),
        write("corso presente con arita` "), writeln(L)
    ),
    not(

    (   call(prenotazione with [nomecorso:Nome,lstart:LStart,ldurate:Ldurate,laule:Laule]),
        not((length(LStart,NS),length(Ldurate,NS),length(Laule,NS))),
        writeln("*** Errore predicato prenotazione ***"),
        write("corso "), writeln(Nome)
    )),
    not(doppio_doc_constr),
    not(wrong_must_coincide),
	not(wrong_aula_type_prenotazione).

doppio_doc_constr:-
    (clause(docente_constr(Doc,_),_) ; clause(docente_constr(Doc,_,_),_)),
    (
        findall(docente_constr(Doc,_),clause(docente_constr(Doc,_),_),L), length(L,Len),
        findall(docente_constr(Doc,_,_),clause(docente_constr(Doc,_,_),_),L2), length(L2,Len2),
        Len+Len2 > 1
    ;   call(prenotazione with docente:Doc)
    ),
    write("*** Doppio vincolo per "), writeln(Doc).

wrong_must_coincide:-
    must_coincide([A,B]),
    call(corso with [nomecorso:A, docente:DA, seguito_da:SDA]),
    call(corso with [nomecorso:B, docente:DB, seguito_da:SDB]),
    (DB=DA ; member(G,SDA), member(G,SDB)),
    write("*** Wrong must_coincide "), writeln([A,B]).

wrong_aula_type_prenotazione:-
	call(prenotazione with [lab:Lab,laule:Laule,nomecorso:Nome]),
	member(Aula,Laule),
	call(aula with [tipolab:TipoLab,nomeaula:Aula]),
	(	var(TipoLab), nonvar(Lab)
	;	nonvar(TipoLab), var(Lab)
	;	nonvar(TipoLab), nonvar(Lab),
		TipoLab \= Lab
	), 
	write("*** Wrong aula type "), writeln(Nome).

:- check_spec_integrity.

:- [ttturni].
