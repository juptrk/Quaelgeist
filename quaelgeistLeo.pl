:- include('framework.pl').
:- encoding(utf8).
:- include('scheresteinpapier.pl').
:- include('mastermind.pl').

%Wissensbasis
ort(eingangsbereich).
ort(schlafzimmer).
ort(kueche).
ort(garten).
ort(wohnzimmer).
ort(arbeitszimmer).

alle_orte(Orte) :- setof(O, ort(O), Orte).


waffe(pistole).
waffe(messer).
waffe(seil).
waffe(spaten).
waffe(gift).
waffe(pokal).

alle_waffen(Waffen) :- setof(W, waffe(W), Waffen).

taeter(vater).
taeter(mutter).
taeter(gaertner).
taeter(koch).
taeter(nachbar).
taeter(besuch).

alle_taeter(Taeter) :- setof(T, taeter(T), Taeter).

%Mord 
tatort(wohnzimmer).
tatwaffe(seil).
moerder(nachbar).

%wenn wir es randomisieren wollen, allerdings scheint das sehr schwierig, weil man dasn die Hinweise anpassen müsste etc.
%tatort(Tatort) :- alle_orte(Orte), random_permutation(Orte,[Tatort|_Rest]).
%tatwaffe(Tatwaffe) :- alle_waffen(Waffen), random_permutation(Waffen, [Tatwaffe|_Rest]).
%moerder(Moeder) :- alle_taeter(Taeter), random_permutation(Taeter,[Moeder|_Rest]).


mord :- tatort(Ort), tatwaffe(Waffe), moerder(Moerder), 
		write('Der Taeter ist: '), writeln(Moerder), write('Der Tatort ist: '), writeln(Ort), write('Die Tatwaffe ist: '), writeln(Waffe).


lageplan :- writeln("         _____________          "),
writeln("        /             \\        "),
writeln("      /                 \\      "),
writeln("    /        Garten       \\    "),
writeln("  /                         \\  "),
writeln("/                             \\"),
writeln("_______________________________"),
writeln("|          |      |           |"),
writeln("|          |      |           |"),
writeln("|          |      |           |"),
writeln("|  Kueche  |      |   Wohn-   |"),
writeln("|          |      |   zimmer  |"),
writeln("|          |      |           |"),
writeln("|          |      |           |"),
writeln("|          |      |           |"),
writeln("|__________|      |           |"),
writeln("|          |      |           |"),
writeln("|  Schlaf- |      |           |"),
writeln("|  zimmer  |      |___________|"),
writeln("|          |      |           |"),
writeln("|          |      |           |"),
writeln("|          |      |  Arbeits- |"),
writeln("|__________|      |  zimmer   |"),
writeln("|                 |           |"),
writeln("|   Eingangs-     |           |"),
writeln("|   bereich       |           |"),
writeln("|                 |           |"),
writeln("|_________________|___________|").

%dynamisches Praedikat: 
:- retractall(verdaechtigungszahl(_)).
:- dynamic verdaechtigungszahl/1.
verdaechtigungszahl(0).

verdaechtigung :- 	writeln("Ok, dann lass mal hoeren."), writeln("Wer ist deiner Meinung nach der Moerder?"),
					read_sentence([Moerderverdacht|_Tail]),((taeter(Moerderverdacht),verdaechtigung2(Moerderverdacht)) ; 
					(writeln("Ich bin so gespannt, deswegen nenne den Tatverdaechtigen als erstes in deinem Satz."), 
					writeln("Du kannst nur Personen verdaechtigen, die in der Liste der moeglichen Taeter auftauchen:"), alle_taeter(Taeterliste),
					writeln(Taeterliste),verdaechtigung1)).

verdaechtigung1 :- 	writeln("Wer ist deiner Meinung nach der Moerder?"),
					read_sentence([Moerderverdacht|_Tail]),((taeter(Moerderverdacht),verdaechtigung2(Moerderverdacht)) ; 
					(writeln("Ich bin so gespannt, deswegen nenne den Tatverdaechtigen als erstes in deinem Satz."),
					writeln("Du kannst nur Personen verdaechtigen, die in der Liste der moeglichen Taeter auftauchen."), alle_taeter(Taeterliste),
					writeln(Taeterliste),verdaechtigung1)).

verdaechtigung2(Moerderverdacht) :- writeln("Was war die Tatwaffe?"), read_sentence([Tatwaffeverdacht|_Tail]), 
									((waffe(Tatwaffeverdacht), verdaechtigung3(Moerderverdacht, Tatwaffeverdacht));
									(writeln("Ich bin so gespannt, deswegen nenne die Tatwaffe als erstes in deinem Satz."),
									writeln("Du kannst nur Gegenstände nennen, die in der Liste der moeglichen Tatwaffen auftauchen:"),
									alle_waffen(Waffen), writeln(Waffen),verdaechtigung2(Moerderverdacht))).

verdaechtigung3(Moerderverdacht, Tatwaffeverdacht) :- writeln("Wo wurde die Putzfrau ermordet?"), read_sentence([Ortverdacht|_Tail]), 
														((ort(Ortverdacht), verdaechtigungComplete(Moerderverdacht,Tatwaffeverdacht, Ortverdacht));
														(writeln("Ich bin so gespannt, deswegen nenne den Tatort als erstes in deinem Satz."),
														writeln("Du kannst nur Orte nennen, die in der Liste der moeglichen Tatorte stehen:"),
														alle_orte(Orte), writeln(Orte),verdaechtigung3(Moerderverdacht,Tatwaffeverdacht))).

verdaechtigungComplete(Moerderverdacht,Tatwaffeverdacht, Ortverdacht) :- (moerder(Moerderverdacht), tatwaffe(Tatwaffeverdacht), tatort(Ortverdacht), 
																			writeln("Du hast den Fall geloest, herzlichen Glueckwunsch!"),
																			writeln("Beende das Programm mit 'Bye'"));
																		(writeln("Dieser Verdacht ist leider falsch, versuche es spaeter nochmal!"),
																				write("Du hast noch "), verdaechtigungszahl(AlteAnzahl), 
																				Uebrigeversuche is 2-AlteAnzahl, write(Uebrigeversuche), 
																				write(" Verdächtigungsversuche übrig.")).


%dynamisches Praedikat: 
:- retractall(mastermindspiele(_)).
:- dynamic mastermindspiele/1.
mastermindspiele(0).

:- retractall(scheresteinpapierspiele(_)).
:- dynamic scheresteinpapierspiele/1.
scheresteinpapierspiele(0).

match([wer, ist, das, opfer],["Die", "Putzfrau", der, "Familie."]).
match([wie, ist, die, putzfrau, gestorben],[ ]) :- mord.
match([bitte, lageplan, ausgeben], [ ]) :- lageplan.
match([welche, moeglichen, tatorte, gibt, es], [ ]) :- writeln("Alle Raeume im Haus kommen als Tatort in Frage:"), lageplan.

match([ich, moechte, eine, verdaechtigung, abgeben],[ ]) :- (verdaechtigungszahl(Anzahl), Anzahl<3, verdaechtigung,
															retract(verdaechtigungszahl(AlteAnzahl)), NeueAnzahl is AlteAnzahl+1, 
															assert(verdaechtigungszahl(NeueAnzahl)));
															(writeln("Du hast zu viele falsche Verdächtigungen gemacht, du darfst keine mehr äußern."),
																writeln("Leider hast du den Fall nicht gelöst und wirst gefeuert."),
																writeln("Beende das Programm mit 'Bye'")).

match([gibst, du, mir, einen, hinweis],[ ]) :- (scheresteinpapierspiele(X), X=0,scheresteinpapier,
							retract(scheresteinpapierspiele(AlteAnzahl)), NeueAnzahl is AlteAnzahl+1, assert(scheresteinpapierspiele(NeueAnzahl)));
							writeln("Einen weiteren Hinweis musst du dir erst erarbeiten").

match([ein, tipp], [ohne, bitte, geht, hier, "garnichts," , deine, eltern, haben, bei, der, erziehung, ja, mal, voll, versagt]).
match([ein, tipp, bitte], [ ]) :- (mastermindspiele(X), X=0, mastermind, 
							retract(mastermindspiele(AlteAnzahl)), NeueAnzahl is AlteAnzahl+1, assert(credit(NeueAnzahl)));
							writeln("Ich gebe dir jetzt keinen weiteren Tipp").
							%wenn noch nie gespielt, dann kann man es spielen, sonder nicht

match([danke],[bitte]).
match([ok], [stell, ruhig, munter, weiter, "Fragen,", ich, schaue, "dann,", ob, ich, sie, dir, beantworten, will]).
match([wie, alt, bist, du], ["8"]).
match([wie, heisst, du], ["Alex,", und, "du?"]).
match([wie, hast, du, den, mord, gesehen],[ich, bin, ein, meister, im, verstecken]).

match([war, es, _, _], [so, einfach, mache, ich, es, dir, nicht]).


match([test1], ["ö"]).
match(["ö"], [test2]).

match(_, ["To", close, the, program, write, "bye."]).