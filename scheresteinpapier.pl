%Aufgabe 2 scheresteinpapier-Echse-Spock

% (statische) Wissensbasis


%diese Begiffe koennen gewaehlt werden
figure(stein).
figure(papier).
figure(schere).


%welcher Begriff schlaegt welchen
beats(stein, schere).
beats(papier, stein).
beats(schere, papier).




%wahlt Zufaelligen Begriff aus und schreibt ihn in die Konsole
computer_choice(Figure) :- 	random_permutation([stein, papier, schere],[Figure|_Rest]),
							write('Ich nehme: '), writeln(Figure).
							


%erhaelt 2 Begriffe und schreibt in Konsole, ob Spieler(erster Parameter) gewonnen hat
result(Spieler,Computer) :- beats(Spieler,Computer), writeln('Na gut, du hast gewonnen!'), write("Meine Eltern waren es beide nicht."),
							writeln(" Eigentlich klar, sonst würde ich hier ja nicht mit dir Spielchen spielen."), !;
							beats(Computer, Spieler), writeln('Haha, ich habe gewonnen, wir spielen gleich nochmal!'), scheresteinpapier, !;
							writeln("Unentschieden, gleich nochmal!"), scheresteinpapier. %Spieler = Computer


%wenn die Eingabe des Spielers einer der zulaessigen Begriffe ist, dann wird eine Computerwahl generiert und das Resultat des Spiels ausgegeben
%ohne Cut wird die Anfrage nciht direkt mit Punkt beendet.
evaluate(Spieler) :- 	figure(Spieler), computer_choice(Computer), result(Spieler,Computer), !;
%Eingabe ist kein zulaessigeer Begriff
						writeln("Das kannst du nicht auswählen."), scheresteinpapier.


%neuer Versuch wird gestartet
scheresteinpapier :- writeln("Einen Hinweis bekommst du nur, wenn du beim Schere-Stein-Papier gewinnst."),
		writeln("Such eins aus: Stein, Papier oder Schere."),
		read_sentence([Spieler|_Tail]), 
		evaluate(Spieler).
