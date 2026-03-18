# Dokumentation Modul 122

## SSH: 
ssh spimur@127.0.0.1 -p 2222

## Grundlagen:
### Teil 1: Linux-Basics & Befehle
### Die Shell-Umgebung
•	Prompt: Standardformat Nutzer@Host:Verzeichnis $ (Änderbar via $PS1).<br>
•	~ (Tilde): Kürzel für das Home-Verzeichnis (/home/nutzer oder /root).<br>
•	; (Semikolon): Befehle nacheinander ausführen (Sequenz).<br>
•	| (Pipe): Ausgabe von Befehl A als Eingabe für Befehl B nutzen.<br>
•	# (Hashtag): Leitet einen Kommentar ein.<br>
•	\ (Backslash): Zeilenumbruch im Befehl oder Maskierung von Sonderzeichen.<br>
•	& (Ampersand): Befehl im Hintergrund ausführen.
### Hilfe & Navigation
•	history: Liste der zuletzt verwendeten Befehle.<br>
•	TAB: Autovervollständigung (2x TAB zeigt alle Möglichkeiten). <br>
•	man / info: Handbuch/Hilfeseite öffnen. Syntax: man <befehl>.<br>
•	whatis: Kurzbeschreibung eines Befehls.<br>
•	apropos: Sucht in Hilfeseiten nach Stichworten.<br>
•	which: Zeigt den Pfad einer Programmdatei an.<br>
### System & Verzeichnisse
•	reboot / halt: System neu starten / ausschalten.<br>
•	pwd: Aktuelles Verzeichnis anzeigen.<br>
•	cd: Verzeichnis wechseln (cd .. = eins hoch, cd ~ = Home).<br>
•	ls: Inhalt auflisten (-a für versteckte, -l für Details).<br>
•	mkdir / rmdir: Verzeichnis erstellen / löschen (nur leere).<br>
•	find: Dateien suchen. Syntax: find [Pfad] -name "[Name]".<br>
### Dateimanagement
•	cp: Kopieren. Syntax: cp <quelle> <ziel> (Option -R für Ordner).<br>
•	rm: Löschen. Syntax: rm <datei> (Option -r für Ordner). Vorsicht!<br>
•	mv: Verschieben oder Umbenennen. Syntax: mv <alt> <neu>.<br>
•	touch: Leere Datei erstellen oder Zeitstempel aktualisieren.<br>
•	cat: Dateiinhalt im Terminal ausgeben.<br>
•	wc: Wörter/Zeilen zählen (-l für Zeilen).<br>
•	echo: Text auf der Konsole ausgeben.<br>
### Aliase & Wildcards
•	alias: Kurzbefehl erstellen. Syntax: alias name="befehl -optionen".<br>
•	* : Beliebige Zeichenfolge (Platzhalter).<br>
•	? : Genau ein beliebiges Zeichen.<br>
•	{a,b} : Brace Extension (erzeugt Kombinationen, z.B. file{1,2}.txt).<br>
________________________________________
## Teil 2: Shellprogrammierung (Bash-Scripting)
### Script-Grundlagen
1.	Datei erstellen: touch script.sh.
2.	Shebang: Erste Zeile im Script: #!/bin/bash.
3.	Rechte vergeben: chmod +x script.sh.
4.	Ausführen: ./script.sh.
### Variablen
•	Zuweisung: NAME="Wert" (Keine Leerzeichen am =). <br>
•	Abruf: $NAME
•	Konstante: readonly VAR="Wert".
•	Befehlssubstitution: DATUM=$(date) (Ergebnis eines Befehls in Variable speichern).
### Wichtige Standardvariablen
### Variable	Bedeutung
$0	Name des Scripts
$1 - $9	Übergabeparameter (Argumente)
$#	Anzahl der Parameter
$?	Statuswert des letzten Befehls (0 = Erfolg)
$USER / $HOME	Aktueller Nutzer / Home-Verzeichnis
In Google Sheets exportieren
### Arithmetik (Ganzzahlen)
•	Syntax: VAR=$(( 5 + 2 )) oder VAR=$[ 5 + 2 ].
•	Operatoren: +, -, *, /, % (Modulo), ** (Potenz).
### Textverarbeitungstools
•	tr: Zeichen ersetzen oder löschen.
•	cut: Teile aus Zeilen herausschneiden (z.B. Spalten).
•	sed: Stream Editor zum Suchen und Ersetzen in Dateien.
•	awk: Mächtiges Tool zur mustergesteuerten Datenverarbeitung.
### Arrays (Feldvariablen)
Arrays speichern mehrere Werte in einer einzigen Variable. Man unterscheidet zwischen indizierten (Nummern) und assoziativen (Schlüsselwörter) Arrays.
### Indizierte Arrays (Standard)
•	Erstellen: namen=("Jan" "Luca" "Tim")
•	Einzelner Zugriff: ${namen[0]} (Index beginnt immer bei 0).
•	Alle Elemente: ${namen[@]} (gibt die ganze Liste aus).
•	Anzahl Elemente: ${#namen[@]} (das # steht für die Länge).
•	Element hinzufügen: namen+=("Sara")
•	Element löschen: unset namen[1] (löscht das zweite Element).
### Assoziative Arrays (Key-Value)
Wichtig: Müssen explizit deklariert werden (ab Bash 4).
•	Deklaration: declare -A auto
•	Zuweisung: auto[marke]="VW" oder auto[ps]=150
•	Zugriff: ${auto[marke]}
### Praktische Anwendung (Schleifen)
Um über alle Elemente eines Arrays zu iterieren:
•	Syntax: ```bash for i in "${namen[@]}"; do echo "Name: $i" done


### Funktionen
•	Syntax: function funktionsName{....}
•	Parameter: $1,$2,$3.. erste,zweite und dritter übergebener Parameter.   $@	Alle an die Funktion übergebenen Parameter.

### Parameterübergabe (Argumente)

Beim Aufruf eines Scripts können Werte direkt übergeben werden. Diese stehen innerhalb des Scripts als spezielle Variablen zur Verfügung:

    $0: Name des Scripts.

    $1, $2, ... $n: Das erste, zweite bis n-te Argument.

    $#: Anzahl der übergebenen Argumente.

    $@ oder $*: Alle übergebenen Argumente als Liste.

    $$: Prozess-ID (PID) des laufenden Scripts.

### Entscheidungen (If & Case)

In der Shell werden Bedingungen traditionell nicht direkt von der Shell, sondern von dem Programm test (oder seinem Synonym [ ]) ausgewertet.
Funktionsweise von if

Ein if-Statement prüft den Exit-Status eines Befehls. Ein Status von 0 bedeutet "Erfolg" (wahr), alles andere ist ein Fehler (falsch).
Bash

#!/bin/bash
echo -n "Zahl eingeben: "
read VAR

#### Wichtig: Leerzeichen innerhalb der Klammern sind zwingend!
if [ $VAR -gt 10 ]; then
    echo "Grösser als 10"
elif [ $VAR -eq 10 ]; then
    echo "Gleich 10"
else
    echo "Kleiner als 10"
fi

    Tipp: Heutzutage wird oft [[ ... ]] verwendet. Dies ist ein internes Bash-Feature, das mächtiger und weniger fehleranfällig ist als das alte [ ].

Logische Verknüpfung von Befehlen

Operatoren können genutzt werden, um Befehle abhängig vom Erfolg des Vorgängers auszuführen:

    && (UND): Führe den zweiten Befehl nur aus, wenn der erste erfolgreich war.

    || (ODER): Führe den zweiten Befehl nur aus, wenn der erste fehlschlug.

Beispiel: rm file.txt || echo "Löschen fehlgeschlagen"
### Schleifen (Loops)
For-Schleife

Besonders stark in Kombination mit Argumentlisten ($@), Datei-Platzhaltern (*.txt) oder Arrays.

    Über Argumente iterieren:
    Bash

    for datei in "$@"
    do
       [ -f "$datei" ] && echo "$datei ist eine Datei"
    done

    Über Arrays iterieren:
    Bash

    array=(1 2 3 4 5)
    for value in ${array[*]}; do
       echo "Wert: $value"
    done

While / Until

    while: Läuft, solange eine Bedingung wahr ist.

    until: Läuft, solange eine Bedingung falsch ist (bis sie wahr wird).

### Informationskanäle & Umleitungen

Linux nutzt drei Standard-Datenströme, die über Dateideskriptoren (Zahlen) angesprochen werden:
Kanal	Name	Deskriptor	Beschreibung
stdin	Standard Input	0	Eingabe (meist Tastatur)
stdout	Standard Output	1	Normale Programmausgabe
stderr	Standard Error	2	Fehlermeldungen
Umleitungs-Operatoren

    > : Überschreibt Ziel mit stdout.

    >> : Hängt stdout an Ziel an.

    2> : Leitet nur Fehlermeldungen um.

    &> : Leitet stdout UND stderr um.

    /dev/null : Das "schwarze Loch"; Daten, die hierhin geleitet werden, werden gelöscht.

Kanäle zusammenlegen:
./script.sh > output.txt 2>&1 (Leitet Fehler dorthin um, wo stdout bereits hingeht).
### Die Pipeline |

Das Pipe-Symbol verbindet den stdout des linken Befehls mit dem stdin des rechten Befehls. Dies erlaubt das "Filtern" von Datenströmen.

Beispiel (Benutzernamen extrahieren außer 'irc'):
Bash

cat /etc/passwd | grep -v irc | cut -d ':' -f 1

### Debugging & Remote Work
Debugging

Um Fehler zu finden, kann ein Script mit dem Parameter -x gestartet werden. Dies zeigt jeden Befehl vor der Ausführung an:
Bash

bash -x meinscript.sh

Remote-Workflow (SCP)

Häufig schreibt man Code lokal (z. B. in VS Code) und kopiert ihn per scp auf einen Server:

    Datei kopieren:
    scp ./script.sh user@server-ip:~/

    Auf Server einloggen & Rechte vergeben:
    ssh user@server-ip
    chmod +x script.sh

    Ausführen:
    ./script.sh          



## 03-Bash-uebungen:

### Übung 2:
Verzechnid docs: <br>
Mkdir Docs <br>
Mit touch file1-10: <br>
Touch file{1..10} <br>
Alle files mit 1 im namen löschen: <br>
rm *1* <br>
File 2,4 und 7 löschen <br>
rm file[2,4,7] <br>
Alle restlichen löschen: <br>
rm * <br>
Verzeichnis ordner erstellen: <br>
Mkdir Ordner <br>

 Obelix finden: grep --color=auto "obelix" uebung.txt <br>
 Zahl 2 finden: grep --color=auto "2" uebung.txt <br>
 Buchstabe e finden: grep --color=auto "e" uebung.txt <br>
 NICHT gamma enthalten: grep -v "gamma" uebung.txt <br>
1, 2 oder 3 enthalten (Regex): grep -E "1|2|3" uebung.txt <br>


cut (Spalten trennen) <br>
Vor dem ersten :: cut -d: -f1 uebung.txt <br>
Zwischen den :: cut -d: -f2 uebung.txt <br>
Rechts des letzten :: cut -d: -f3 uebung.txt <br>


### Übung 5:
dmesg | egrep '[0-9]{4}:[0-9]{2}:[0-9a-f]{2}.[0-9]' <br>

ifconfig | grep -oE '((1?[0-9]


### übung6
cat << END > abcde.txt <br>
a <br>
b <br>
c <br>
d <br>
e <br>
END

ls -z 2> /root/errorsLs.log <br>
 cat datei.txt > neu.txt (Überschreibt den Inhalt).


cat datei.txt >> neu.txt (Hängt den Inhalt unten an) <br>
d) whoami: whoami > info.txt <br>
e) id anhängen: id >> info.txt <br>
f) wc mit stdin: wc -w < info.txt

