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
result(Spieler,Computer, A) :- beats(Spieler,Computer), writeln('Na gut, du hast gewonnen!'), output(A), !;
							beats(Computer, Spieler), writeln('Haha, ich habe gewonnen, wir spielen gleich nochmal!'), scheresteinpapier(A), !;
							writeln("Unentschieden, gleich nochmal!"), scheresteinpapier(A). %Spieler = Computer


%wenn die Eingabe des Spielers einer der zulaessigen Begriffe ist, dann wird eine Computerwahl generiert und das Resultat des Spiels ausgegeben
%ohne Cut wird die Anfrage nciht direkt mit Punkt beendet.
evaluate(Spieler, A) :- 	figure(Spieler), computer_choice(Computer), result(Spieler,Computer, A), !;
%Eingabe ist kein zulaessigeer Begriff
						writeln("Das kannst du nicht auswählen."), scheresteinpapier(A).


%neuer Versuch wird gestartet
scheresteinpapier(A) :- writeln("Einen Hinweis bekommst du nur, wenn du beim Schere-Stein-Papier gewinnst."),
		writeln("Such eins aus: Stein, Papier oder Schere."),
		read_sentence([Spieler|_Tail]), 
		evaluate(Spieler, A).


output(["Meine", "Eltern", waren, es, beide, "nicht -", "Eigentlich", "klar,", dann, "würde", ich, hier, ja, nicht, mit, dir, "Spielchen", "spielen."]).
