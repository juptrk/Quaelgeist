:- encoding(iso_latin_1).

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
result(Spieler,Computer, A, T) :- beats(Spieler,Computer), writeln('Na gut, du hast gewonnen!'), output_scheresteinpapier(T, A), !;
							beats(Computer, Spieler), writeln('Haha, ich habe gewonnen, wir spielen gleich nochmal!'), scheresteinpapier(A, T), !;
							writeln("Unentschieden, gleich nochmal!"), scheresteinpapier(A, T). %Spieler = Computer


%wenn die Eingabe des Spielers einer der zulaessigen Begriffe ist, dann wird eine Computerwahl generiert und das Resultat des Spiels ausgegeben
%ohne Cut wird die Anfrage nciht direkt mit Punkt beendet.
evaluate(Spieler, A, T) :- 	figure(Spieler), computer_choice(Computer), result(Spieler,Computer, A, T), !;
%Eingabe ist kein zulaessigeer Begriff
						writeln("Das kannst du nicht auswählen."), scheresteinpapier(A).


%neuer Versuch wird gestartet
scheresteinpapier(A, T) :- writeln("Einen Hinweis bekommst du nur, wenn du beim Schere-Stein-Papier gewinnst."),
		writeln("Such eins aus: Stein, Papier oder Schere."),
		read_sentence([Spieler|_Tail]), 
		((member(Spieler,[schere, stein, papier]),evaluate(Spieler, A, T));
			scheresteinpapier(A,T)).
		

output_scheresteinpapier(eltern, ["Ich hätte", nie, "gedacht,", dass, ich, mal, so, "persönlich", und, "familiär", in, einen, "Mord", verwickelt, sein, "würde."]).%einer der Eltern war es
output_scheresteinpapier(sonstige, ["Meine", "Eltern", waren, es, beide, "nicht -", "Eigentlich", "klar,", dann, "würde", ich, hier, ja, nicht, mit, dir, "Spielchen", "spielen."]).
