
trimestre(1).

:- [macro].
:- lib(gfd).
%:- lib(propia).
%:- lib(edge_finder3).
%:- lib(gfd_global).
%:- import alldifferent/1 from fd_global.

:- local struct(slot(idslot,nomecorso,start,duration,aula,day,chann,start_in_day,end_in_day)).
% Questo dovrebbe essere logicamente in timetabling.ecl, ma viene usato in parte anche qui


%dates([_,1],'17/09/2014','18/12/2014'):-!.
%dates([_,2],'26/09/2011','17/12/2011'):-!.
%dates([_,3],'26/09/2011','17/12/2011'):-!.
%dates(prenotazione,'26/09/2011','17/12/2011'):-!.
dates(prenotazione(Start,End),Start,End):-!.
dates(_,'21/09/2015','15/12/2015'):-!. 
% E` indispensabile che ci sia un default, perche' ogni tanto qualche corso non e` seguito da nessuno: []


:- dynamic other_opt/1.
% Gli obbligatori e ad anni alterni della specialistica info,4, escludendo i corsi gia` dati dagli info alla LT: basi dati e reti calcolatori
%other_opt([analisi3,progettoweb,ingsw2]).


obj_group([info,1],4).
obj_group([ele,1],1).	% gli ele,1 sono le prime 3 settimane, in cui non c'e` fisica 1; do quindi un peso basso
obj_group([info,2],3).
obj_group([ele,2],3).
obj_group([ele,3],1).
obj_group([ele,4],1).
obj_group([ele,5],1).
obj_group([tlc,3],1).
obj_group([tlc,4],1).
obj_group([tlc,5],1).
obj_group([info,3],1).
obj_group([info_cento,3],1).
obj_group([info,4],1).
obj_group([info,5],1).
obj_group([auto,3],2).
obj_group([auto,4],1).
obj_group([auto,5],1).

% I laboratori del tipo "tipolab" non sono disponibili (preferibilmente) nell'orario
:- dynamic pref_no_times_lab/2.
pref_no_times_lab(info,lun(16.5)).


% Tipologie di studenti. Si fara` in modo che gli studenti di una tipologia
% non abbiano sovrapposizioni (cioe` se due corsi sono seguiti da una tipologia
% al 2 anno, allora non avranno sovrapposizioni).
types([info,auto,ele,tlc,info_cento,info_recupero,auto_recupero,ele_recupero,tlc_recupero]). %,mec
subtype(info_cento,info).
subtype(info_recupero,info). % Esiste solo all'anno 4, perche' non ci sono esami da recuperare al 2 anno di LM
subtype(auto_recupero,auto). % Esiste solo all'anno 4, perche' non ci sono esami da recuperare al 2 anno di LM
subtype(ele_recupero,ele).   % Esiste solo all'anno 4, perche' non ci sono esami da recuperare al 2 anno di LM
subtype(tlc_recupero,tlc).   % Esiste solo all'anno 4, perche' non ci sono esami da recuperare al 2 anno di LM

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
% Aggiungo un campo type, che dice il tipo di turni a cui e` soggetto
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




%2011/12: OCCHIO CHE C'E` LA SCUOLA DI ACUSTICA, PER CUI SE NON LASCIO USARE L'AULA 5, MI IMPEDISCE DI USARE IL VENERDI`
% Per gli esami del 1 anno metto numero studenti 150
corso(analisi1,lorenzetti,150,[[info,1],[ele,1],[auto,1],[tlc,1]],7.5,_,3,[2.5,2.5,2.5],year1,7456,"Analisi Matematica I","http://www.unife.it/ing/informazione/270-analisi-matem-i").


corso(geometria,mazzanti,150,[[info,1],[ele,1],[auto,1],[tlc,1]],7.5,_,3,[2.5,2.5,2.5],year1,7377,"Geometria e Algebra","http://www.unife.it/ing/informazione/geometria-e-algebra").
%% 2015/16: tolgo l'orario fissato dai meccanici gli anni scorsi, perche' altrimenti non riesco ad evitare per me il lunedi` e il venerdi`
%% L'importante e` che Mazzanti per i meccanici non faccia sia il lunedi` sia il venerdi`
corso(geometria_meccanici,mazzanti,100,[prenotazione],7.5,aula6,3,[2.5,2.5,2.5],year1,no_import,"Geometria (ing Meccanica)",_).
%corso(geometria_meccanici_aulamia,mazzanti,121,[prenotazione],2.5,_,1,[2.5],fixed,_,"Geometria (ing Meccanica)",_).


corso(fisica1,ricci,118,[[info,1],[auto,1]],10,_,4,[2.5,2.5,2.5,2.5],year1,7457,"Fisica I","http://www.unife.it/ing/informazione/fisica-i").
%corso(fisica1,ricci,150,[[info,1],[auto,1]],7.5,_,3,[2.5,2.5,2.5],year1,7457,"Fisica I","http://www.unife.it/ing/informazione/fisica-i").

corso(info1,gavanelli,150,[[info,1],[ele,1],[auto,1],[tlc,1]],4,_,2,[2,2],year1,7459,"Fondamenti di Informatica (Modulo A)","http://www.unife.it/ing/informazione/fondamenti-informatica").
% Tolgo il lab da info ed ele, che sono i due su cui si ottimizza, altrimenti lui mette sempre fisica la mattina dei giorni in cui ho il lab,
% perche' li considera giornate molto impegnative (invece non lo sono, visto che hanno solo informatica e sono 2 turni di lab)
corso(info1_lab1,gavanelli,150,[[auto,1],[tlc,1]],3,info,1,[3],lunch,7459,"Fondamenti di Informatica (Modulo A)","http://www.unife.it/ing/informazione/fondamenti-informatica").
corso(info1_lab2,gavanelli,150,[[auto,1],[tlc,1]],3,info,1,[3],lunch,7459,"Fondamenti di Informatica (Modulo A)","http://www.unife.it/ing/informazione/fondamenti-informatica").

%corso(recupero_test,recupero,100,[[ele,1],[tlc,1]],8,_,2,[4,4],fixed,_,"Recupero test matematica",_).


corso(analisi2,foschi,119,[[info,2],[auto,2],[ele,2],[tlc,2]],7.5,_,3,[2.5,2.5,2.5],year2,7353,"Analisi Matematica II","http://www.unife.it/ing/informazione/analisi-matematica-ii").

corso(metodistatistici,dimarco,119,[[info,2],[auto,2],[ele,2],[tlc,2]],5,_,2,[2.5,2.5],year2,7364,"Metodi Statistici per l'Ingegneria","http://www.unife.it/ing/informazione/Calcolo-Statistica").
%corso(metodistatistici_lab,nonato_lab,50,[],2.5,info,1,[2.5],noturni,7364,"Metodi Statistici per l'Ingegneria","http://www.unife.it/ing/informazione/Calcolo-Statistica").

%corso(dimarco_economia,dimarco,1,[prenotazione],9,economia,3,[3,3,3],fixed,7364,"corso di Di Marco ad Economia",_).


corso(teoriadeicircuiti,setti,119,[[info,2],[auto,2],[ele,2],[tlc,2]],7.5,_,3,[2.5,2.5,2.5],year2,7369,"Teoria dei Circuiti","http://www.unife.it/ing/informazione/teoria-circuiti").


corso(calcolatorielettronici,ruggeri,119,[[info,2],[auto,2],[ele,2],[tlc,2]],5,_,2,[2.5,2.5],year2,7354,"Calcolatori Elettronici","http://www.unife.it/ing/informazione/calcolatori-elettronici/").


corso(matematicadiscreta,bisi,68,[[info,3],[info_cento,3],[auto,3],[ele,3],[tlc,3]],5,_,2,[2.5,2.5],noturni,7363,"Matematica Discreta","http://www.unife.it/ing/informazione/mat-dis"). %[info_cento,3]
%corso(matematicadiscreta_g6,bisi,68,[[info,3],[info_cento,3],[auto,3],[ele,3],[tlc,3]],2.5,aulag6,1,[2.5],fixed,7363,"Matematica Discreta",_). %[info_cento,3]



corso(elettronicaanalogica,vannini,68,[[info,3],[info_cento,3],[auto,3],[tlc,3],[ele,3]],7.5,_,3,[2.5,2.5,2.5],noturni,7356,"Elettronica Analogica","http://www.unife.it/ing/informazione/elettronica-analogica"). %[info_cento,3],

corso(retiditlc_am,mazzini,68,[[info,3],[info_cento,3],[auto,3],[tlc,3],[ele,3]],2.5,_,1,[2.5],noturni,7365,"Reti di telecomunicazioni e Internet","http://www.unife.it/ing/informazione/reti-di-telecomunicazioni"). %[info_cento,3],
corso(retiditlc_pm1,mazzini,68,[[info,3],[info_cento,3],[auto,3],[tlc,3],[ele,3]],2.5,_,1,[2.5],noturni,7365,"Reti di telecomunicazioni e Internet","http://www.unife.it/ing/informazione/reti-di-telecomunicazioni"). %[info_cento,3],
corso(retiditlc_pm2,mazzini,68,[[info,3],[info_cento,3],[auto,3],[tlc,3],[ele,3]],2.5,_,1,[2.5],noturni,7365,"Reti di telecomunicazioni e Internet","http://www.unife.it/ing/informazione/reti-di-telecomunicazioni"). %[info_cento,3],



corso(linguaggihardware,favalli,28,[[info,3],[info,4]],5,_,2,[2.5,2.5],turni,7362,"Linguaggi di Descrizione dell'Hardware","http://www.unife.it/ing/informazione/Linguaggi-hw").
corso(linguaggihardware_lab,favalli_lab,40,[],2.5,info,1,[2.5],exceptional,7362,"Linguaggi di Descrizione dell'Hardware","http://www.unife.it/ing/informazione/Linguaggi-hw").

corso(reticalcolatori,tortonesi,36,[[info,3],[info_cento,3],[info_recupero,4],[auto,4],[auto_recupero,4]],2.5,_,1,[2.5],turni,7429,"Reti di Calcolatori","http://www.unife.it/ing/informazione/reti-calcolatori"). %[info_cento,3],
corso(reticalcolatori_lab,tortonesi,36,[[info,3],[info_cento,3],[info_recupero,4],[auto,4],[auto_recupero,4]],2.5,info,1,[2.5],noturni,7429,"Reti di Calcolatori","http://www.unife.it/ing/informazione/reti-calcolatori"). 


corso(azionamentielettrici,mattioli,39,[[auto,3],[auto_recupero,4]],5,_,2,[2.5,2.5],noturni,7436,"Azionamenti Elettrici","http://www.unife.it/ing/informazione/Azionamenti-elettrici"). 


corso(sisttlc,conti,40,[[ele,3],[ele_recupero,4],[tlc,3],[tlc_recupero,4]],7.5,_,3,[2.5,2.5,2.5],turni,7431,"Sistemi Wireless","http://www.unife.it/ing/informazione/sistemi-di-telecomunicazioni").


corso(economiaorgaz,rubini,100,[[info,5],[auto,5],[ele,5],[tlc,5]],5,_,2,[2.5,2.5],fixed,7422,"Economia e Organizzazione Aziendale","http://www.unife.it/ing/informazione/economia-organizzazione-aziendale").


corso(sistemidistribuiti,stefanelli,34,[[info,4],[info,5],[info_recupero,4],[auto,4],[auto,5],[auto_recupero,4]],5,_,2,[2.5,2.5],noturni,171,"Sistemi Distribuiti e Mobili","http://www.unife.it/ing/ls.infoauto/sistemi-distribuiti").

corso(sistemidistribuiti_lab,stefanelli_lab,5,[],2.5,info,1,[2.5],noturni,171,"Sistemi Distribuiti e Mobili","http://www.unife.it/ing/ls.infoauto/sistemi-distribuiti").



corso(fondmectec,digregorio,19,[[auto,4]],5,_,2,[2.5,2.5],noturni,75,"Fondamenti di Meccanica Tecnica","http://www.unife.it/ing/informazione/Fond-mecc-tecnica/").
corso(fondmectec2,digregorio,19,[[auto,4]],2.5,_,1,[2.5],noturni,75,"Fondamenti di Meccanica Tecnica","http://www.unife.it/ing/informazione/Fond-mecc-tecnica/").


corso(meccanicaazionamenti,dalpiaz,100,[[auto,5]],10,_,4,[2.5,2.5],noturni,no_import,"Meccanica degli Azionamenti","http://www.unife.it/ing/ls.infoauto/meccanica-azionamenti").


corso(scambiotermico,piva,21,[[ele,4],[ele,5]],5,_,2,[2.5,2.5],noturni,_,"Scambio termico nei sistemi elettronici","http://www.unife.it/ing/lm.tlcele/scambio-termico").
corso(propagazione,bellanca,40,[[tlc,4],[tlc_recupero,4],[ele,4],[ele_recupero,4]],5,_,2,[2.5,2.5],turni,153,"Propagazione","http://www.unife.it/ing/informazione/propagazione").

corso(compatibilitaelettrom,giovannelli,30,[[ele,4],[ele,5],[tlc,4],[tlc,5]],5,_,2,[2.5,2.5],turni,_,"Compatibilità Elettromagnetica",_). 





corso(fondia,lamma,51,[[info,4],[info,5],[info_recupero,4],[auto,4],[auto,5],[auto_recupero,4]],5,_,2,[2.5,2.5],noturni,74,"Fondamenti di Intelligenza Artificiale","http://www.unife.it/ing/ls.infoauto/Fond_IA").

corso(fondia_lab,lamma_lab,38,[],2.5,info,1,[2.5],noturni,74,"Fondamenti di Intelligenza Artificiale","http://www.unife.it/ing/ls.infoauto/Fond_IA").


corso(circuitianalogici,setti,50,[[ele,4],[ele_recupero,4],[ele,5],[tlc,4],[tlc_recupero,4],[tlc,5]],5,_,2,[2.5,2.5],fixed,_,"Circuiti Analogici per l'Elaborazione dei Segnali","http://www.unife.it/ing/ls.tlcele/circuiti-analogici").


corso(dispositivielettronici,raffo,38,[[ele,4],[ele_recupero,4],[ele,5]],5,_,2,[2.5,2.5],fixed,48,"Dispositivi Elettronici","http://www.unife.it/ing/ls.tlcele/dispositivi-elettronici/"). 


corso(trasmissionenumerica1,tralli,19,[[tlc,4],[tlc_recupero,4],[tlc,5]],5,_,2,[2.5,2.5],turni,194,"Comunicazioni Digitali","http://www.unife.it/ing/ls.tlcele/tx-num-1").


corso(un_lab_indisponibile,un_lab_indisponibile,1,[prenotazione],2.5,info,1,[2.5],noturni,no_import,"Lab non disponibile",_).



corso(Nomecorso,Docente,1,[prenotazione(StartDate,EndDate)],Num_ore,Lab,NumSlot,LDur,prenotazione,MySQL,FullName,Link):-
    prenotazione(Nomecorso,Docente,Lab,LStart,LDur,_,MySQL,FullName,Link,StartDate,EndDate),
    length(LStart,NumSlot),
    %minlist(LDur,Slot_min),
    %maxlist(LDur,Slot_max),
    Num_ore is sum(LDur).

:- local struct(prenotazione(nomecorso,docente,lab,lstart,ldurate,laule,mysql,full_name,link,startdate,enddate)).


prenotazione(lab_indisponibile1,lab_indisponibile1,info,[ven(16.5)],[2.5],[100],no_import,"Lab non disponibile",_,'26/09/2011','17/12/2011').

% 2015/16: LA SCUOLA DI ACUSTICA USA IL LAB PICCOLO IL VENERDI` FINO ALLE 17, PER CUI NE IMPEDISCO L'USO SOLO DALLE 17 IN POI
%prenotazione(lab_indisponibile2,lab_indisponibile2,info,[ven(16.5)],[2.5],[101],no_import,"Lab non disponibile",_,'26/09/2011','17/12/2011').
prenotazione(lab_indisponibile2,lab_indisponibile2,info,[ven(17)],[2],[101],no_import,"Lab non disponibile",_,'26/09/2011','17/12/2011').

%prenotazione(meccanica_vibrazioni_am,mucchi,info,[lun(8.5)],[2.5],[lab_info_picc],7352,"Meccanica delle vibrazioni",_,'26/09/2011','17/12/2011').
%prenotazione(meccanica_vibrazioni_pm,dalpiaz,info,[lun(14)],[2.5],[lab_info_picc],7352,"Meccanica delle vibrazioni",_,'26/09/2011','17/12/2011').

%Casano, 2011/12
%Il corso Ë Termofluidodinamica Numerica ed Ë collocato nel primo semestre
% se non Ë possibile il martedÏ dalle 16:30 alle 19:00 c'Ë solo un altra
% possibilt‡ il mercoledÏ dalle 11:00 alle 13:30.
%In seguito: va bene il laboratorio da 43 posti, perÚ fai in modo che sia il
%martedÏ dalle 16:30 alle 19:00.
%prenotazione(termofluidodinamica_numerica,casano,info,[mar(16.5)],[2.5],[lab_info_picc],_,"Termofluidodinamica Numerica",_,'26/09/2011','17/12/2011').
%prenotazione(geologia,ciavola,info,[mer(14)],[2.5],[lab_info_picc],7314,"Elementi di Geologia e Geomorfologia",_,'26/09/2011','17/12/2011').

% 2010/11:
%prenotazione(progmec2,livieri_pren,info,[mar(14),mer(14),gio(14)],[2.5,2.5,2.5],[lab_info_picc,lab_info_picc,lab_info_picc],149,"Progettazione Meccanica II",_,'27/09/2010','23/11/2010').
% 2012/13
%prenotazione(progmec2,livieri_pren,info,[lun(16.5),mar(11)],[2.5,2.5],[lab_info_picc,lab_info_picc],149,"Progettazione Meccanica II",_,'27/09/2010','23/11/2010').
% 2013/14
%prenotazione(progmec2,livieri_pren,info,[mar(11),mer(11)],[2.5,2.5],[lab_info_picc,lab_info_picc],149,"Progettazione Meccanica II",_,'27/09/2010','23/11/2010').
% 2014/15
%prenotazione(progmec2,livieri_pren,info,[lun(11),mar(11)],[2.5,2.5],[lab_info_picc,lab_info_picc],149,"Progettazione Meccanica II",_,'27/09/2010','23/11/2010').


% Semestre

% 2013/14. Nel 14/15 e` al secondo semestre
%prenotazione(informaticaindustriale,gamberoni_lab,info,[mer(8.5),gio(8.5)],[2.5,2.5],[lab_info,lab_info],7378,"Informatica Industriale",_,_,_).

% 2012/13
%prenotazione(analisi1_civili,corli,info,[lun(11),mer(11)],[2.5,2.5],[lab_info,lab_info],6,"Analisi 1 (civile)","http://studiare.unife.it/AttivitaDidatticaContestualizzata.do?cds_id=770&pds_id=9999&aa_ord_id=2003&aa_off_id=2008&ad_id=15",_,_).
% 2013/14
%prenotazione(analisi1_civili,corli,info,[lun(11),mer(11)],[2.5,2.5],[lab_info,lab_info],6,"Analisi 1 (civile)","http://studiare.unife.it/AttivitaDidatticaContestualizzata.do?cds_id=770&pds_id=9999&aa_ord_id=2003&aa_off_id=2008&ad_id=15",_,_).
%prenotazione(sismica,aprile,info,[mar(16.5)],[2.5],[lab_info_picc],_,"Progettazione in zona sismica",_,_,_).
%prenotazione(estimo,zanni,_,[lun(11)],[2.5],[5],_,"Elementi di economia ed estimo",_,_,_).
%prenotazione(geotecnica,fioravante,_,[mer(11)],[2.5],[5],_,"Geotecnica",_,_,_).
%prenotazione(sistemienergetici,spina,_,[mer(11)],[2.5],[7],_,"Sistemi energetici",_,_,_).

% Alvisi
%ti chiederei di prenotare il laboratorio di informatica da 64 posti per il
%primo semestre del prossimo anno accademico per il corso di Modellistica
%idrologica il venerdÏ dalle 11 alle 13.30.
%In seconda battuta potrebbe andare bene anche il lunedÏ dalle 8.30 alle 11 o
%il martedÏ, sempre dalle 8.30 alle 11.
%prenotazione(modellisticaidrologica,alvisi_pren,info,[ven(11)],[2.5],[lab_info],_,"Modellistica Idrologica",_,_,_).


%prenotazione(analisi2_civili,miranda,info,[mer(8.5)],[5],[lab_info],8,"Analisi 2 (civile)",_,'27/09/2010','22/12/2010').

% Eventualmente, a Caleffi potrebbero andare bene anche 8.30 alle 11.00 del martedÏ e del mercoledÏ,
% ma preferisce il lun 16.5
%prenotazione(modellistica_idraulica,caleffi,info,[lun(16.5)],[2.5],[lab_info_picc],91,"Modellistica Idraulica",_,'27/09/2010','23/11/2010').

%prenotazione(meccanica_vibrazioni,dalpiaz_pren,_,[lun(11),gio(8.5)],[2.5,2.5],[7,5],124,"Meccanica delle vibrazioni",_,'27/09/2010','23/11/2010').

% 1 trimestre
%prenotazione(calcolo_analisi_numerica,docente_calcolo_mec,info,[mar(16.5)],[2.5],[lab_info],19,"Calcolo Numerico (mec)/ Analisi Numerica (civ)",_,'27/09/2010','23/11/2010').

% 1 semestre
%prenotazione(complementi_analisi,docente_complementi_analisi,_,[mer(11)],[2.5],[5],_,"Complementi di analisi matematica (mec)",_,'27/09/2010','22/12/2010').

% 2012-13
%prenotazione(meccanica_continuo,padula,_,[lun(8.5),mer(8.5)],[2.5,2.5],[12,12],_,"Meccanica del continuo",_,_,_).
%prenotazione(metodologie_metallurg,merlin,_,[mer(8.5),gio(14)],[2.5,2.5],[9,9],_,"metodologie metallurg.",_,_,_).
%prenotazione(dinamica_ab,venturini_torella,_,[lun(14),gio(8.5),ven(11)],[2.5,2.5,2.5],[5,5,5],_,"Dinamica A-B",_,_,_). %Ci manca un'ora del gio
%prenotazione(dinamica_ab1,torella_venturini,_,[gio(14)],[2.5],[5],_,"Dinamica A-B",_,_,_).
%prenotazione(sistemi_oleodinamici,zarotti,_,[ven(14)],[2.5],[12],_,"Modelli di Sistemi Oleodinamici",_,_,_).

%prenotazione(elem_ing_fluviale,schippa,_,[mar(14)],[2.5],[12],_,"Elementi di ing. fluviale",_,_,_).
%prenotazione(elem_geol_geom,ciavola,_,[mer(14)],[2.5],[9],_,"Elementi di geol e geom",_,_,_).
%prenotazione(progettazione_edilizia,tagliaventi,_,[mar(14)],[5],[9],_,"progettazione edilizia",_,_,_).
%prenotazione(prog_recupero_edil,bucci,_,[gio(14)],[5],[19],_,"prog recupero edil",_,_,_).
%prenotazione(geologia_terremoti,caputo,_,[lun(11),gio(16.5)],[2.5,2.5],[19,9],_,"Geologia dei terremoti",_,_,_).
%prenotazione(telerilevam,pellegrinelli,_,[lun(8.5),mer(11)],[2.5,2.5],[9,12],_,"Telerilevam",_,_,_).
%prenotazione(monitoraggio,russo,_,[gio(11)],[2.5],[19],_,"Monitoraggio",_,_,_).
%prenotazione(acustica_edilizia,fausti,_,[lun(16.5)],[2.5],[9],_,"Acustica edilizia",_,_,_).
%prenotazione(chimicaappli,chimicaappli,_,[lun(8.5)],[2.5],[5],_,"Chimica applicata e tecnologia dei materiali",_,_,_).
%prenotazione(prenotazione_aula7,prenotazione_aula7,_,[mar(8.5)],[2.5],[7],_,"Meccanica vibrazioni",_,_,_).
%prenotazione(termofluidodinamica_numerica_aula5,casano_aula5,_,[mar(8.5)],[2.5],[5],_,"Termofluidodinamica numerica",_,_,_).

%prenotazione(scienze_della_terra_am,scienze_della_terra_am,_,[lun(8.5),mar(8.5),mer(8.5),ven(8.5)],[2.5,2.5,2.5,5],[7,7,7,7],_,"Scienze della Terra",_,_,_).
%prenotazione(scienze_della_terra_pm,scienze_della_terra_pm,_,[mar(16.5),mer(14),gio(16.5),ven(14)],[2.5,5,2.5,2.5],[7,7,7,7],_,"Scienze della Terra",_,_,_).

% Prenotazioni aule dai civili, 2014/15
%prenotazione(meccanica_razionale_aula5,coscia_aula5,_,[lun(11)],[2.5],[5],_,"Meccanica Razionale (civili)",_,_,_).

%prenotazione(scienza_delle_costruzioni,atralli,_,[mar(11),mer(8.5)],[2.5,2.5],[5,5],_,"Scienza delle Costruzioni",_,_,_).

% FINE Prenotazioni aule dai civili, 2014/15

%%% PRENOTAZIONI 2015/16 %%%
%prenotazione(scuola_acustica_lab1,scuola_acustica_lab1,info,[ven(9)],[4],[101],no_import,"Scuola di Acustica",_,'18/09/2015','26/02/2016').
%prenotazione(scuola_acustica_lab2,scuola_acustica_lab2,info,[ven(14)],[3],[101],no_import,"Scuola di Acustica",_,'18/09/2015','26/02/2016').


:- local struct(alias(nomecorso,seguito_da,secondname,secondweb)).
% Il corso 'nomecorso', quando e` seguito dagli studenti 'seguito da' si chiama in realta`
% 'secondname' ed ha come pagina 'secondweb'.
%alias(internetumts,[tlc,4],"Sistemi Wireless 1","http://www.unife.it/ing/ls.tlcele/sistemi-wireless-i/").
alias(tecniche_ctl,[auto,5],"Automazione (laboratorio)","http://www.unife.it/ing/ls.infoauto/automazione-lab/").

% Giacomo fa qualche lezione per Evelina
%no_overlap_corsi([informatica_industriale_aula6,ingsw2]).
%no_overlap_corsi([informatica_industriale_aula8,ingsw2]).

no_overlap_corsi([teoinfocodici,elettrsistdigit]).

% I corsi tenuti a Cento devono essere in giorni diversi da quelli
% tenuti a Ferrara
% deve avere esattamente 2 argomenti. Se non lo definisci, metti valori dummy
%diff_day_corsi([dummy1,dummy2]).
%diff_day_corsi([linguaggihardware,linguaggihardware_lab]).
%diff_day_corsi([ingsw,basidati]).
%diff_day_corsi([ingsw,reticalcolatori]).
%diff_day_corsi([ingsw,reticalcolatori_bak]). 
diff_day_corsi([reticalcolatori_lab,reticalcolatori]).
%diff_day_corsi([ingsw,matematicadiscreta]).
%diff_day_corsi([ingsw,elettronicaanalogica]).
%diff_day_corsi([ingsw,retiditlc]).
diff_day_corsi([retiditlc_am,retiditlc_pm1]).
diff_day_corsi([matematicadiscreta_g6,matematicadiscreta]).	%2014/15: Togliere gli anni prossimi


% L'orario del primo deve essere un sottoinsieme di quello del secondo.
% (intendendo che ogni slot del primo deve coincidere con uno slot del secondo)

must_coincide([elettronicadigitale_lab_turno1,elettronicadigitale]).
must_coincide([linguaggihardware_lab,linguaggihardware]).
%must_coincide([info1_lab1,info1]).
%must_coincide([reticalcolatori_lab,reticalcolatori]).
must_coincide([basidati_lab,basidati]).
must_coincide([dinamicamodellistica_lab,dinamicamodellistica]).
must_coincide([meccanicavibrazioni_lab,dinamicamodellistica]).
must_coincide([progautsistdigit_lab,progautsistdigit]).
must_coincide([sist_informativi_lab,sist_informativi]).
must_coincide([elettrsistdigit_fake,elettrsistdigit]).
must_coincide([elemcostrmacchine_lab,elemcostrmacchine]).
must_coincide([metodistatistici_lab,metodistatistici]).
must_coincide([ricercaoperativa_lab,ricercaoperativa]).
must_coincide([tecnichecontrollo_lab,tecnichecontrollo]).
must_coincide([ingsw2_lab,ingsw2]).
must_coincide([sistemidistribuiti_lab,sistemidistribuiti]).
must_coincide([programmazioneconcorrente_seminari,programmazioneconcorrente]).
must_coincide([fittizio_concorrente_web2,programmazioneconcorrente_seminari]).
must_coincide([fittizio_concorrente_web,progettoweb]).
must_coincide([fondia_lab,fondia]).

% AA 2006/07: RETI DI CALCOLATORI DIVENTA ECCEZIONALE, infatti e` nello stesso
% anno di ingsw, che e` a Cento 
%same_turn([reticalcolatori_lab,reticalcolatori]). 

same_turn([fake1,fake2]).
symmetric([inglese_turno1,inglese_turno2]).
%symmetric([miranda_tutorato_analisi2_1,miranda_tutorato_analisi2_2]).


% Nota: e` importante che le aule equivalenti vengano messe nell'ordine inverso
% all'euristica di selezione del valore.
aule_equivalenti([]).

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
aula(2000,3000,s,fittizio_esd,n,n,_,"").
aula(2001,3000,s,fittizio_liv,n,n,_,"").
aula(2002,3000,s,fittizio_prog,n,n,_,"").
aula(2003,3000,s,mecraz,n,n,_,"").
aula(2004,3000,s,economia,n,n,_,"").
aula(2005,3000,s,fittizio_concorrente_web,n,n,_,"").
%aula(codeca,3000,s,codeca,n,n,_,"").



%docente_constr(NomeDocente,LSlots)
% E` un predicato che viene invocato con il nome del docente e con tutti i suoi slot.
% Deve implementare i vincoli del docente

:- dynamic docente_constr/2,docente_constr/3.
:- dynamic excluded_time/2, excluded_day/2, excluded_day_time/2, unpreferred_time/2, unpreferred_day/2, unpreferred_day_time/2.



docente_constr(inlingua,LSlots):-!.
    %(foreach(S,LSlots) do
        %no_day(S,4) % In questo trimestre non hanno lezioni al venerdi`, per cui mi hanno chiesto di non mettere inglese da sola
        %no_time(S,11)   % Tolgo l'ultima ora, tanto darebbe solo soluzioni schifose
    %).



docente_constr(un_lab_indisponibile,LSlots):-!,  
    (foreach(S,LSlots) do
        S = slot with start:Start,
        Start #= ven(14)
    ).



% 2015/16
fixed_course(idrologia,Start,_,_):-
    Start :: [lun(14),mar(14),mer(8.5)].
fixed_course(idraulica_ambientale,Start,_,_):-
    Start :: [lun(8.5),mar(8.5)].
fixed_course(dimarco_economia,Start,_,_):-
	% lun 11.00-13.00, mar 9.00-11.00, gio 11.00-13.00 Economia, ma si deve spostare, per cui ci vuole almeno un'ora
		% quindi aggiungo mezz'ora prima e mezz'ora dopo
	Start :: [lun(10.5),mar(9),gio(10.5)].

fixed_course(corli_analisi1_civ,Start,_,_):- Start :: [lun(11),mer(11),ven(11)].

fixed_course(telerilevamento,Start,_,_):- Start :: [mar(11),mer(16.5)].

fixed_course(meccanica_materiali,Start,_,_):- Start :: [lun(16.5),mar(14)].

% Elisa mi ha detto che per i meccanici va bene se hanno il mecoledi` alle 8.30,
% piu` un pomeriggio qualunque
fixed_course(economiaorgaz2,Start,_,_):-
	Start :: [mer(8.5)].
fixed_course(economiaorgaz,Start,_,_):-
	Start :: [lun(14),lun(16.5),mar(14),mar(16.5),gio(14),gio(16.5),ven(14),ven(16.5)].

fixed_course(tecnichecontrollo,Start,_,_):-
	Start:: [mar(14),mer(11)].

% ORARI DEI MECCANICI 2014/15:

fixed_course(geometria_meccanici,Start,_,_):-
    Start :: [lun(8.5),mer(11),ven(8.5)].

%fixed_course(economiaorgaz,Start,_,_):-	Start :: [mer(8.5)].
%fixed_course(economiaorgaz2,Start,_,_):-	Start :: [gio(8.5)].

fixed_course(impianti_termotecnici,Start,_,_):-
%    Start :: [gio(11),ven(11)].
%	Start :: [lun(8.5),mar(8.5)]. % Orario meccanici v2
%	Start :: [mar(8.5),ven(11)]. % Orario meccanici v2.4
	Start :: [lun(8.5),mar(8.5)]. % Orario meccanici v2.4

% FINE ORARI MECCANICI 2014/15

% PRENOTAZIONI LAB INFO 2014/15

%fixed_course(corli_analisi1_civ,Start,_,_):- Start :: [mer(11)].
%fixed_course(corli_analisi1_civ2,Start,_,_):- Start :: [lun(11),mar(11),ven(11)].


% FINE PRENOTAZIONI LAB INFO 2014/15

% 2014/15: Questo lo fisso perche' mi hanno detto di spostarlo in g6, mentre io gli avevo dato l'aula 5.
% Va rimossa i prossimi anni
fixed_course(matematicadiscreta_g6,Start,_,_):-
	Start:: [mar(11)].

fixed_course(recupero_test,Start,_,_):-
    Start :: [gio(14.5),ven(14.5)].



fixed_course(termofluidodinamica_numerica,Start,_,_):-
%    Start :: [mar(8.5),mer(8.5),gio(16.5)]. 2012/13
%	Start :: [lun(8.5),mer(8.5)]. % 2014/15
	Start:: [lun(8.5),mar(11),mer(8.5)].



%fixed_course(meccanicarazionale,Start,_,_):-
%    Start :: [lun(14),mar(16.5),mer(11),gio(14)].


%fixed_course(analisi1_meccanici,Start,_,_):-    Start :: [mar(8.5),mer(16.5)].

%fixed_course(modtermotecnica,Start,_,_):-
%    Start :: [lun(8.5),gio(8.5),ven(8.5)].

fixed_course(sistoleodinamici,Start,_,_):-
    Start :: [gio(11)].
fixed_course(sistoleodinamici2,Start,_,_):-
    Start :: [ven(14)].

fixed_course(dinamicamodellistica,Start,_,_):-
%    Start :: [lun(11),mar(8.5),ven(11)]. 2009/10
    Start :: [lun(11),mer(8.5),gio(8.5)]. % 2010/11, Santina

fixed_course(elemcostrmacchine,Start,_,_):-
    Start :: [lun(11),mer(11),gio(11)].


%2014/15: Setti e Raffo si sono scambiati una lezione, per cui li metto fixed.
% dall'anno prossimo, togliere il "fixed"

fixed_course(circuitianalogici,Start,_,_):-
    Start :: [mer(11),ven(11)].

fixed_course(dispositivielettronici,Start,_,_):-
    Start :: [lun(11),gio(11)].


%%%%%%%%%%%%%%%%%% EXCEPTIONAL COURSES %%%%%%%%%%%%%%%%%%%%%%%
% Sono i corsi che non possono stare nei turni.
% Viene invocato per ogni slot.
% Puo` staqbilire il dominio delle variabili StartTime, oppure
% dichiarare che non ha settato il dominio; in tal caso gli
% verra` dato un dominio a default (non quello dei turni, ovviamente).
%
% exceptional_course(+NomeCorso,?StartTime,+Durata,-SetDomain)
:- mode exceptional_course(++,?,?,?).

exceptional_course(Corso,Start,Dur,true):-
    call(prenotazione with [nomecorso:Corso,lstart:LStart,ldurate:LDur]),
    (foreach(ST,LStart),foreach(DU,LDur),foreach([ST,DU],OUT) do true),
%    member([Start,Dur],OUT) infers fd.
	table([Start,Dur],OUT).


% AA 2006/07: l'ho fatto a mano, per rispettare le richieste di Cesare.
% Forse si potrebbe rilassare: lui vuole che siano sovrapposti
% e che siano al lunedi`, solo che uno e` di 3 ore, laltro di 2.
%exceptional_course(reticalcolatori_bak,Start,2,true):-    Start =9.
%exceptional_course(reticalcolatori_lab,Start,3,true):-    Start =9.
exceptional_course(reticalcolatori_bak,_,2,false).


exceptional_course(reticalcolatori,_Start,_,false).

%exceptional_course(elettronicadigitale_part1,Start,2,true):-
%    Start :: [19,46,55].
%exceptional_course(elettronicadigitale_part2,Start,1,true):-
%    Start = 53.
exceptional_course(elettronicadigitale_lab_turno1,_,2,false).
exceptional_course(elettronicadigitale_lab_turno2,_,2,false).


%2005/06
%exceptional_course(fisicatecnica,Start,2,true):-    Start :: [13,25].
%exceptional_course(fisicatecnica,Start,3,true):-    Start = 37.



% questo e` l'orario che Chiara ha dato a Beghelli nel 2006/07
exceptional_course(controlliautomatici_meccanici,Start,2,true):-
    Start :: [21,37].
exceptional_course(controlliautomatici_meccanici,Start,3,true):-
    Start = 7.



exceptional_course(info1_lab,Start,3,true):-
    Start=31.
exceptional_course(info1_lab1,Start,2,true):-
    Start=28.



indomain_aula(X):- nonvar(X),!.
indomain_aula(X):-
    frandom(Rand),
    (Rand>0.3 ->    indomain_random(X)
        ;   indomain_aula_piccola(X)).


%%%%%%%%%%%%%%%%%% TITOLI DELLE TABELLE STUDENTI %%%%%%%%%%%%


title_html_stud(info,4,Title):- !,
    Title = "Informatica, LM anno 1".
title_html_stud(info,5,Title):- !,
    Title = "Informatica, LM anno 2".
title_html_stud(info,1,Title):- !,
    Title = "Ing Elettronica e informatica, Anno 1, ultime 9 settimane".
title_html_stud(info,2,Title):- !,
    Title = "Ing dell'informazione, Anno 2".
title_html_stud(info,3,Title):- !,
    Title = "Informatica, LT, Anno 3, curriculum Ferrara".
title_html_stud(info,N,Title):-
    concat_string(["Ing Informatica e dell'Automazione, Curriculum Informatica, LT, Anno ",N],Title).
title_html_stud(info_cento,N,Title):-
    (N>3 -> A is N-3, concat_string(["Ing dell'Informazione, Curriculum Informatica, LM, Anno ",A," corsi di Cento"],Title)
        ;   concat_string(["Ing dell'Informazione, Curriculum Informatica, LT, Anno ",N," corsi di Cento"],Title)
    ).
title_html_stud(info_recupero,N,Title):- !,
    (N>3 -> A is N-3, concat_string(["Informatica, LM, Anno ",A," per chi NON HA dato alla LT gli esami consigliati"],Title)
        ;   errore("gruppo info_recupero per numero anno =< 3")
    ).

title_html_stud(auto,1,Title):- !,
    Title = "Ing Elettronica e informatica, Anno 1, ultime 9 settimane".
title_html_stud(auto,2,Title):- !,
    Title = "Ing dell'informazione, Anno 2".
title_html_stud(auto,3,Title):- !,
    Title = "Automazione, LT, Anno 3".
title_html_stud(auto,4,Title):- !,
%    Title = "Automazione, LM, per chi NON HA dato alla LT gli esami consigliati".
    Title = "Automazione, LM anno 1".
title_html_stud(auto_recupero,4,Title):- !,
%    Title = "Automazione, LM, per chi NON HA dato alla LT gli esami consigliati".
    Title = "Automazione, LM anno 1, per chi NON HA dato alla LT gli esami consigliati".
title_html_stud(auto,5,Title):- !,
%    Title = "Automazione, LM, per chi HA dato alla LT gli esami consigliati".
    Title = "Automazione, LM anno 2".
title_html_stud(auto_recupero,N,Title):- !,
    (N>3 -> A is N-3, concat_string(["Automazione, LM, Anno ",A,"per chi NON HA dato alla LT gli esami consigliati"],Title)
        ;   errore("gruppo auto_recupero per numero anno =< 3")
    ).
title_html_stud(auto,N,Title):-
    (N>3 -> A is N-3, concat_string(["Ing Informatica e dell'Automazione, Curriculum Automazione, LM, Anno ",A],Title)
        ;   concat_string(["Ing Informatica e dell'Automazione, Curriculum Automazione, LT, Anno ",N],Title)
    ).
title_html_stud(ele,4,Title):- !,
    Title = "Ing Elettronica e delle Telecomunicazioni, LM, curriculum Elettronica, anno 1".
title_html_stud(ele_recupero,4,Title):- !,
    Title = "Elettronica LM, anno 1, per chi NON HA dato alla LT gli esami consigliati".
title_html_stud(ele,5,Title):- !,
    Title = "Elettronica, LM, anno 2".
title_html_stud(ele,2,Title):- !,
    Title = "Ing dell'informazione, Anno 2".
title_html_stud(ele,1,Title):- !,
    Title = "Ing Elettronica e informatica, Anno 1, prime 3 settimane".
title_html_stud(ele,3,Title):- !,
    Title = "Elettronica, LT, Anno 3".
title_html_stud(tlc,4,Title):- !,
    Title = "Telecomunicazioni, LM anno 1".
title_html_stud(tlc_recupero,4,Title):- !,
    Title = "Telecomunicazioni, LM, anno 1, per chi NON HA dato alla LT gli esami consigliati".
title_html_stud(tlc,5,Title):- !,
    Title = "Telecomunicazioni, LM, anno 2".
title_html_stud(tlc,2,Title):- !,
    Title = "Ing dell'informazione, Anno 2".
title_html_stud(tlc,5,Title):- !,
    Title = "Telecomunicazioni, LM, Anno 2".
title_html_stud(tlc,1,Title):- !,
    Title = "Ing Elettronica e informatica, Anno 1, prime 3 settimane".
title_html_stud(tlc,3,Title):- !,
    Title = "Telecomunicazioni, LT, Anno 3".
title_html_stud(tlc,N,Title):-
    concat_string(["Ing Elettronica e delle Telecomunicazioni, LT, Anno ",N],Title).
title_html_stud(mec,N,Title):-
    (N>3 -> A is N-3, concat_string(["(meccanica), LM, Anno ",A],Title)
        ;   concat_string(["(meccanica), LT, Anno ",N],Title)
    ).

turni_swap(X,X). % Non c'e` nessuno swap in questo trimestre

check_spec_integrity:-
    findall(N,current_predicate(corso/N),L),
    (L = [_] -> true
     ;  writeln("*** Errore di definizione del predicato corso ***"),
        write("corso presente con arita` "), writeln(L)
    ),
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
