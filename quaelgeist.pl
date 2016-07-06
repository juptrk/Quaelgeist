:- include('framework.pl').
:- encoding(utf8).
:- include('scheresteinpapier.pl').
:- include('mastermind.pl').


:- dynamic situation/1.

situation(normal).

change_situation(NewSituation) :-
	situation(OldSituation),
	retract(situation(OldSituation)),
	assertz(situation(NewSituation)).

%dynamisches Praedikat: 
:- retractall(verdaechtigungszahl(_)).
:- dynamic verdaechtigungszahl/1.
verdaechtigungszahl(0).

%dynamisches Praedikat: 
:- retractall(mastermindspiele(_)).
:- dynamic mastermindspiele/1.
mastermindspiele(0).

:- retractall(scheresteinpapierspiele(_)).
:- dynamic scheresteinpapierspiele/1.
scheresteinpapierspiele(0).

:- dynamic alter_antwort/1.
alter_antwort(["8"]).

:- dynamic name_antwort/1.
name_antwort(["Ich", "heiße", "Alex"]).


%Wissensbasis
location(eingangsbereich).
location(schlafzimmer).
location(kueche).
location(garten).
location(wohnzimmer).
location(arbeitszimmer).
person('Alex').
person('Alex').
person('Du').

alle_orte(Orte) :- setof(O, location(O), Orte).

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
place('Alex', kueche).
place('Du', garten).


qusubj(location(_)) --> [wo].
v(locationquery, third) --> [ist].
v(locationquery, first) --> [bist].
locprep --> [im].
locprep --> ['in der'].

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
														((location(Ortverdacht), verdaechtigungComplete(Moerderverdacht,Tatwaffeverdacht, Ortverdacht));
														(writeln("Ich bin so gespannt, deswegen nenne den Tatort als erstes in deinem Satz."),
														writeln("Du kannst nur Orte nennen, die in der Liste der moeglichen Tatorte stehen:"),
														alle_orte(Orte), writeln(Orte),verdaechtigung3(Moerderverdacht,Tatwaffeverdacht))).

verdaechtigungComplete(Moerderverdacht,Tatwaffeverdacht, Ortverdacht) :- (moerder(Moerderverdacht), tatwaffe(Tatwaffeverdacht), tatort(Ortverdacht), 
																			writeln("Du hast den Fall geloest, herzlichen Glueckwunsch!"),
																			writeln("Beende das Programm mit 'Bye'"));
																		(writeln("Dieser Verdacht ist leider falsch, versuche es spaeter nochmal!"),
																				write("Du hast noch "), verdaechtigungszahl(AlteAnzahl), 
																				Uebrigeversuche is 2-AlteAnzahl, write(Uebrigeversuche), 
																				writeln(" Verdächtigungsversuche übrig.")).


random_answer(normal, Head) :- 
	random_permutation([["Ich", denke, nicht, dass, wir, jetzt, darueber, reden, "sollten."],
						["Bitte", denke, nocheinmal, ueber, deinen, naechsten, "Schritt", "nach."],
						["Willst", du, das, "Spiel", etwa, "beenden?", "Dann", musst, du, bye, "eingeben."]],
					   [Head|_]).

random_answer(kind, Head) :- 
	random_permutation([["Hey,", du, willst, etwas, von, "mir,", stell, eine, sinnvolle, "Frage!"],
						["Darauf", will, ich, dir, gerade, nicht, "antworten."],
						["Willst", du, etwa, schon, "aufgeben?", "Dann", sag, mir, "Gespraech", "beenden."]],
					   [Head|_]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% grammar - doesn't work yet

n(location(eingangsbereich), p) --> [eingangsbereich].
n(location(schlafzimmer), n) --> [schlafzimmer].
n(location(kueche), f) --> [kueche].
n(location(garten), p) --> [garten].
n(location(wohnzimmer), n) --> [wohnzimmer].
n(location(arbeitszimmer), n) --> [arbeitszimmer].
n(person('Alex'), third) --> [kind].
n(person('Alex'), third) --> [alex].
n(person('Du'), first) --> [ich].


s((V,S,O)) --> np(S), vp((V,O)).

question((V,S,O)) --> qusubj(O), vp((V,S)).

np(S) --> n(S).

vp((V,O)) --> v(V), np(O).
vp((V,O)) --> v(V), pp(O).

pp(location(O)) --> locprep, np(O).


sem((locationquery, person(X, _), location(Y, _))) :- place(X,Y).


ask(Q,A) :- question(Sem,Q,[]), sem(Sem), s(Sem,A,[]).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Situation: normal
match([kind, ansprechen], ["Du", gehst, zu, dem, "Kind", und, beginnst, ein, "Gespraech."]) :-
	situation(normal), 
	change_situation(kind).

match([wer, ist, das, opfer],["Die", "Putzfrau", der, "Familie."]) :-
	situation(normal).

match([wie, ist, die, putzfrau, gestorben],[ ]) :- 
	situation(normal),
	mord.

match([bitte, lageplan, ausgeben], [ ]) :- 
	situation(normal),
	lageplan.

match([welche, moeglichen, tatorte, gibt, es], [ ]) :- 
	situation(normal),
	writeln("Alle Raeume im Haus kommen als Tatort in Frage:"), 
	lageplan.



% Situation: kind
match([gespraech, beenden], ["Du", beendest, das, "Gespraech."]) :-
	situation(kind),
	change_situation(normal).

match([gibst, du, mir, einen, hinweis],[ ]) :- 
	situation(kind),
	(scheresteinpapierspiele(X), 
	X=0,
	scheresteinpapier,
	retract(scheresteinpapierspiele(AlteAnzahl)), NeueAnzahl is AlteAnzahl+1, 
	assert(scheresteinpapierspiele(NeueAnzahl)));
	writeln("Einen weiteren Hinweis musst du dir erst erarbeiten").

match([ein, tipp], [ohne, bitte, geht, hier, "garnichts," , deine, eltern, haben, bei, der, erziehung, ja, mal, voll, versagt]) :-
	situation(kind).

match([ein, tipp, bitte], [ ]) :-
	situation(kind), 
	(mastermindspiele(X), 
	X=0, 
	mastermind, 
	retract(mastermindspiele(AlteAnzahl)), NeueAnzahl is AlteAnzahl+1, 
	assert(mastermindspiele(NeueAnzahl)));
	situation(kind),
	writeln("Ich gebe dir jetzt keinen weiteren Tipp").
	%wenn noch nie gespielt, dann kann man es spielen, sonder nicht

match([danke],["bitte,", ich, geh, dann, mal]) :-
	situation(kind),
	change_situation(normal).

match([ok], [stell, ruhig, munter, weiter, "Fragen,", ich, schaue, "dann,", ob, ich, sie, dir, beantworten, will]) :-
	situation(kind).

match([wie, alt, bist, du], Antwort) :-
	situation(kind),
	alter_antwort(Antwort),
	retract(alter_antwort(Antwort)),
	assertz(alter_antwort(["Ich", werde, mich, nicht, wiederholen])).

match([wie, heisst, du], Antwort) :-
	situation(kind),
	name_antwort(Antwort),
	retract(name_antwort(Antwort)),
	assertz(name_antwort(["Kannst", du, dir, nichtmal, meinen, "Namen", "merken?"])).

match([wie, hast, du, den, mord, gesehen],[ich, bin, ein, meister, im, verstecken]) :-
	situation(kind).

match([war, es, _, _], [so, einfach, mache, ich, es, dir, nicht]) :-
	situation(kind).






% in jeder Situation:

match([ich, moechte, eine, verdaechtigung, abgeben],[ ]) :- 
	verdaechtigungszahl(Anzahl), 
	Anzahl<3, 
	verdaechtigung,
	retract(verdaechtigungszahl(AlteAnzahl)), NeueAnzahl is AlteAnzahl+1, 
	assert(verdaechtigungszahl(NeueAnzahl)),
	((NeueAnzahl < 3,
	writeln("Du solltest besser ueber deine Antworten nachdenken, unendlich viele Versuche hast du nicht mehr!"));
	(NeueAnzahl>=3,
	writeln("Du hast zu viele falsche Verdächtigungen gemacht, du darfst keine mehr äußern."),
	writeln("Leider hast du den Fall nicht gelöst und wirst gefeuert."),
	writeln("Das Spiel ist nun beendet - schließe es mit 'bye' und starte es neu für einen weiteren Versuch."))).

match([test1], ["ö"]).
match(["ö"], [test2]).

% muss immer als letzte match-Abfrage stehen
match(_, Answer) :- 
	situation(Situation),
	random_answer(Situation, Answer).