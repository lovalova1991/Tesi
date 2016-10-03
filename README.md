# PrologCompare

Questo progetto realizzato in Python consente all'utente di modificare le specifiche degli orari presso l'Università degli Studi di Ferrara.
Le specifiche degli orari si trovano all'interno dei file "spec1.pl" e "spec3.pl" in formato Prolog. Il programma legge i predicati "corso" e visualizza una tabella con i dati presi in input dal file Prolog caricato.
L'utente può modificare direttamente il file o confrontarlo con il file Excel che contiene le specifiche aggiornate per il prossimo anno accademico. Una volta che viene caricato il file Excel, viene effettuato un confronto tra le due strutture dati, dove viene colorato il contenuto differente. A tal proposito:

1- In azzurro vengono indicati i laboratori;
2- In verde vengono indicati i nuovi corsi;
3- In arancione vengono indicati i corsi dove non viene trovata una corrispondenza nel file Excel (tipicamente sono corsi che vengono divisi in più predicati)
4- In rosso sono indicate le differenze tra i due file.

Una volta completato il processo di aggiornamento, l'utente può salvare il file in formato Prolog.
