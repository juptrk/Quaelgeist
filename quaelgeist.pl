:- include('framework.pl').
:- include('scheresteinpapier.pl').
:- include('mastermind.pl').
:- encoding(iso_latin_1).


% definiert die aktuelle situation
% mögliche situationen sind kind, garten, arbeitszimmer, wohnzimmer, schlafzimmer, eingangsbereich, kueche, geheim
:- dynamic situation/1.

situation(eingangsbereich).

change_situation(NewSituation) :-
	NewSituation == kind,
	situation(OldSituation),
	retract(situation(OldSituation)),
	assertz(situation(NewSituation)).

change_situation(NewSituation) :-
	not(NewSituation == kind),
	change_person('Du', NewSituation),
	situation(OldSituation),
	retract(situation(OldSituation)),
	assertz(situation(NewSituation)).


% definiert die personen, mit denen man interagieren kann und sich selbst
:- dynamic person/2.

person('Du', eingangsbereich).
person('Alex', eingangsbereich).

change_person(Person,NewLocation) :-
	person(Person,OldLocation),
	retract(person(Person,OldLocation)),
	assertz(person(Person,NewLocation)).

%dynamisches Praedikat: 
:- retractall(verdaechtigungszahl(_)).
:- dynamic verdaechtigungszahl/1.
verdaechtigungszahl(0).

set_verdaechtigung :-
	retract(verdaechtigungszahl(AlteAnzahl)),
	NeueAnzahl is AlteAnzahl+1, 
	assert(verdaechtigungszahl(NeueAnzahl)),
	((NeueAnzahl < 3,
	writeln("Du solltest besser ueber deine Antworten nachdenken, unendlich viele Versuche hast du nicht mehr!"));
	(NeueAnzahl>=3,
	writeln("Du hast zu viele falsche Verdächtigungen gemacht, du darfst keine mehr äußern."),
	writeln("Leider hast du den Fall nicht gelöst und wirst gefeuert."),
	writeln("Das Spiel ist nun beendet - schließe es mit 'bye' und starte es neu für einen weiteren Versuch."))).


%dynamisches Praedikat: 
:- retractall(mastermindspiele(_)).
:- dynamic mastermindspiele/1.
mastermindspiele(0).

set_mastermind :-
	retract(mastermindspiele(AlteAnzahl)),
	NeueAnzahl is AlteAnzahl+1, 
	assertz(mastermindspiele(NeueAnzahl)).


:- retractall(scheresteinpapierspiele(_)).
:- dynamic scheresteinpapierspiele/1.
scheresteinpapierspiele(0).

set_scheresteinpapier :-
	retract(scheresteinpapierspiele(AlteAnzahl)),
	NeueAnzahl is AlteAnzahl+1, 
	assertz(scheresteinpapierspiele(NeueAnzahl)).

:- dynamic alter_antwort/1.
alter_antwort(["8"]).

:- dynamic name_antwort/1.
name_antwort(["Ich", "heiße", "Alex"]).


:- dynamic location_counter/1.

location_counter(0).

reset_counter :-
	location_counter(Old),
	retract(location_counter(Old)),
	assertz(location_counter(0)).

increase_counter :-
	location_counter(Old),
	New is Old+1,
	retract(location_counter(Old)),
	assertz(location_counter(New)).

%Wissensbasis
location(eingangsbereich, 'der Eingangsbereich').
location(schlafzimmer, 'das Schlafzimmer').
location(kueche, 'die Kueche').
location(garten, 'der Garten').
location(wohnzimmer, 'das Wohnzimmer').
location(arbeitszimmer, 'das Arbeitszimmer').

alle_orte(Orte) :- setof(O, location(O, _), Orte).

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

lageplan :- nl,
			writeln("                LAGEPLAN             "),
			writeln("_____________________________________"),
			writeln("|            |           |           | \\"),
			writeln("|            |           |           |   \\"),
			writeln("|            |           |           |     \\"),
			writeln("|  Eingangs- |  Schlaf-  |  Küche    |       \\"),
			writeln("|  bereich   |  zimmer   |           |         \\"),
			writeln("|            |           |           |          |"),
			writeln("|            |___________|___________|          |"),
			writeln("|                                    |          |"),
			writeln("|                                    |  Garten  |"),
			writeln("|____________________________________|          |"),
			writeln("|                 |                  |          |"),
			writeln("|                 |                  |          |"),
			writeln("|    Arbeits-     |                  |         /"),
			writeln("|    zimmer       |   Wohnnzimmer    |       /"),
			writeln("|                 |                  |     /"),
			writeln("|                 |                  |   /"),
			writeln("|_________________|__________________| /"),
			nl.


verdaechtigung(A) :- 	writeln("Ok, dann lass mal hoeren."), writeln("Wer ist deiner Meinung nach der Moerder?"),
					read_sentence([Moerderverdacht|_Tail]),((taeter(Moerderverdacht),verdaechtigung2(Moerderverdacht, A)) ; 
					(writeln("Ich bin so gespannt, deswegen nenne den Tatverdaechtigen als erstes in deinem Satz."), 
					writeln("Du kannst nur Personen verdaechtigen, die in der Liste der moeglichen Taeter auftauchen:"), alle_taeter(Taeterliste),
					writeln(Taeterliste),verdaechtigung1(A))).

verdaechtigung1(A) :- 	writeln("Wer ist deiner Meinung nach der Moerder?"),
					read_sentence([Moerderverdacht|_Tail]),((taeter(Moerderverdacht),verdaechtigung2(Moerderverdacht, A)) ; 
					(writeln("Ich bin so gespannt, deswegen nenne den Tatverdaechtigen als erstes in deinem Satz."),
					writeln("Du kannst nur Personen verdaechtigen, die in der Liste der moeglichen Taeter auftauchen."), alle_taeter(Taeterliste),
					writeln(Taeterliste),verdaechtigung1(A))).

verdaechtigung2(Moerderverdacht, A) :- writeln("Was war die Tatwaffe?"), read_sentence([Tatwaffeverdacht|_Tail]), 
									((waffe(Tatwaffeverdacht), verdaechtigung3(Moerderverdacht, Tatwaffeverdacht, A));
									(writeln("Ich bin so gespannt, deswegen nenne die Tatwaffe als erstes in deinem Satz."),
									writeln("Du kannst nur Gegenstände nennen, die in der Liste der moeglichen Tatwaffen auftauchen:"),
									alle_waffen(Waffen), writeln(Waffen),verdaechtigung2(Moerderverdacht, A))).


verdaechtigung3(Moerderverdacht, Tatwaffeverdacht, A) :- writeln("Wo wurde die Putzfrau ermordet?"), read_sentence([Ortverdacht|_Tail]), 
														((location(Ortverdacht, _), verdaechtigungComplete(Moerderverdacht,Tatwaffeverdacht, Ortverdacht, A));
														(writeln("Ich bin so gespannt, deswegen nenne den Tatort als erstes in deinem Satz."),
														writeln("Du kannst nur Orte nennen, die in der Liste der moeglichen Tatorte stehen:"),
														alle_orte(Orte), writeln(Orte),verdaechtigung3(Moerderverdacht,Tatwaffeverdacht, A))).

verdaechtigungComplete(Moerderverdacht,Tatwaffeverdacht, Ortverdacht, A) :- (moerder(Moerderverdacht), tatwaffe(Tatwaffeverdacht), tatort(Ortverdacht), 
																			 output(solved, A));
																			output(wrong_suspicion, A).


random_answer(Situation, Head) :- 
	normal(Situation),
	random_permutation([["Ich", denke, nicht, dass, wir, jetzt, darueber, reden, "sollten."],
						["Bitte", denke, nocheinmal, ueber, deinen, naechsten, "Schritt", "nach."],
						["Willst", du, das, "Spiel", etwa, "beenden?", "Dann", musst, du, bye, "eingeben."]],
					   [Head|_]).

random_answer(kind, Head) :- 
	random_permutation([["Hey,", du, willst, etwas, von, "mir,", stell, eine, sinnvolle, "Frage!"],
						["Darauf", will, ich, dir, gerade, nicht, "antworten."],
						["Willst", du, etwa, schon, "aufgeben?", "Dann", sag, mir, "Gespraech", "beenden."]],
					   [Head|_]).


% Situation: normal

normal(X) :- member(X, [eingangsbereich, garten, kueche, arbeitszimmer, wohnzimmer, schlafzimmer, geheim]).


match([ok], [stell, ruhig, munter, weiter, "Fragen,", ich, schaue, "dann,", ob, ich, sie, dir, beantworten, "will."]) :-
	situation(kind).

match([wie, hast, du, den, mord, gesehen],[ich, bin, ein, meister, im, verstecken]) :-
	situation(kind).

match([war, es, _, _], [so, einfach, mache, ich, es, dir, nicht]) :-
	situation(kind).

match(Input, Output) :-
	ask(Input, Output).

% muss immer als letzte match-Abfrage stehen
match(_, Answer) :- 
	situation(Situation),
	random_answer(Situation, Answer).


ask(Q,["Dort", bist, du, doch, "bereits!"]) :-
	not(situation(kind)),
	normal(Location),
	member(Location, Q),
	person('Du', Location).


ask(Q,A) :-
	not(situation(kind)),
	member(garten, Q),
	nl,
	writeln("Willst du wirklich in den Garten gehen?"),
	nl,
	read_sentence(Input),
	((member(ja, Input),
	output(garten, A),
	change_situation(garten));
	output(no, A)).

ask(Q,A) :-
	not(situation(kind)),
	member(arbeitszimmer, Q),
	nl,
	writeln("Willst du wirklich in das Arbeitszimmer gehen?"),
	nl,
	read_sentence(Input),
	((member(ja, Input),
	output(arbeitszimmer, A),
	change_situation(arbeitszimmer));
	output(no, A)).

ask(Q,A) :-
	not(situation(kind)),
	member(kueche, Q),
	nl,
	writeln("Willst du wirklich in die Kueche gehen?"),
	nl,
	read_sentence(Input),
	((member(ja, Input),
	output(kueche, A),
	change_situation(kueche));
	output(no, A)).

ask(Q,A) :-
	not(situation(kind)),
	member(schlafzimmer, Q),
	nl,
	writeln("Willst du wirklich in das Schlafzimmer gehen?"),
	nl,
	read_sentence(Input),
	((member(ja, Input),
	output(schlafzimmer, A),
	change_situation(schlafzimmer));
	output(no, A)).

ask(Q,A) :-
	not(situation(kind)),
	member(wohnzimmer, Q),
	nl,
	writeln("Willst du wirklich in das Wohnzimmer gehen?"),
	nl,
	read_sentence(Input),
	((member(ja, Input),
	output(wohnzimmer, A),
	change_situation(wohnzimmer));
	output(no, A)).

ask(Q,A) :-
	not(situation(kind)),
	member(eingangsbereich, Q),
	nl,
	writeln("Willst du wirklich in den Eingangsbereich gehen?"),
	nl,
	read_sentence(Input),
	((member(ja, Input),
	output(eingangsbereich, A),
	change_situation(eingangsbereich));
	output(no, A)).

% Gespräch beginnen
ask(Q, A) :-
	person('Alex', Location),
	situation(Location), 
	(member(kind, Q);
	 member(alex, Q)),
	nl,
	writeln("Willst du das Kind ansprechen?"),
	nl,
	read_sentence(Input),
	((member(ja, Input),
	output(kind, A),
	change_situation(kind));
	output(no, A)).

ask(Q,A) :-
	situation(kind),
	(member(beenden, Q);
	 member(tschuess, Q);
	 member(gehen, Q);
	 member(ende, Q)),
	nl,
	writeln("Willst du unser Gespräch etwa einfach so beenden?"),
	nl,
	read_sentence(Input),
	((member(ja, Input),
	 person('Du', Location),
	 change_situation(Location),
	 output(gespraech_ende, A));
	 output(no, A)).


ask(Q,A) :-
	situation(kind),
	member(hinweis, Q),
	nl,
	writeln("Willst du einen Hinweis von mir?"),
	nl,
	read_sentence(Input),
	((((member(ja, Input),
	   member(bitte, Input));
	   member(bitte, Input)),
	 ((scheresteinpapierspiele(X),
	  X = 0,
	  scheresteinpapier(A),
	  set_scheresteinpapier);
	  output(no_hinweis, A)));
    ((member(ja, Input)),
      not(member(bitte, Input)),
      output(no_bitte, A));
	output(no, A)).

ask(Q,A) :-
	situation(kind),
	member(tipp, Q),
	nl,
	writeln("Willst du einen Tipp von mir?"),
	nl,
	read_sentence(Input),
	((((member(ja, Input),
	   member(bitte, Input));
	   member(bitte, Input)),
	 ((mastermindspiele(X),
	  X = 0,
	  mastermind,
	  set_mastermind,
	  output(nothing, A));
	  output(no_hinweis, A)));
    ((member(ja, Input)),
      not(member(bitte, Input)),
      output(no_bitte, A));
	output(no, A)).


ask(Q,["Ich", "weiß", "selber,", dass, das, Word, "ist!"]) :-
	situation(kind),
	normal(Location),
	member(Location, Q),
	person('Du', Location),
	location(Location, Word).


ask(Q,["Nein,", das, hier, ist, nicht, Word, "-", das, sieht, man, "doch."]) :-
	situation(kind),
	normal(Location),
	member(Location, Q),
	not(person('Du', Location)),
	location(Location, Word).

ask(Q,["bitte,", ich, geh, dann, "mal."]) :-
	situation(kind),
	member(danke, Q),
	person('Du', Location),
	change_situation(Location).

ask(Q,A) :-
	situation(kind),
	(member(alt, Q);
	 member(alter, Q)),
	nl,
	writeln("Willst du etwa wissen wie alt ich bin?"),
	nl,
	read_sentence(Input),
	((member(ja, Input),
	 alter_antwort(A),
	 retract(alter_antwort(A)),
	 assertz(alter_antwort(["Das", habe, ich, dir, doch, bereits, "gesagt."])));
	 output(no, A)).


ask(Q,A) :-
	situation(kind),
	(member(name, Q);
	 member(heißt, Q);
	 member(heisst, Q)),
	nl,
	writeln("Willst du meinen Namen wissen?"),
	nl,
	read_sentence(Input),
	((member(ja, Input),
      name_antwort(A),
	  retract(name_antwort(A)),
	  assertz(name_antwort(["Kannst", du, dir, nichtmal, meinen, "Namen", "merken?"])));
	output(no, A)).


ask(Q,["Das", "Opfer", ist, die, "Putzfrau", der, "Familie."]) :-
	not(situation(kind)),
	member(opfer, Q).

ask(Q, A) :- 
	not(situation(kind)),
	member(lageplan, Q),
	lageplan,
	output(help, A).

ask(Q, A) :- 
	not(situation(kind)),
	member(tatorte, Q),
	nl,
	writeln("Alle Raeume im Haus kommen als Tatort in Frage:"),
	lageplan,
	output(help, A).


ask(Q, A) :-
	(member(verdächtigung, Q);
	 member(verdächtige, Q);
	 member(verdächtigter, Q);
	 member(verdächtig, Q);
	 member(täter, Q)),
	nl,
	writeln("Möchtest du eine Verdächtigung äußern?"),
	nl,
	read_sentence(Input),
	((member(ja, Input),
	 verdaechtigungszahl(Anzahl),
	 Anzahl < 3,
	 verdaechtigung(A),
	 set_verdaechtigung);
	 output(no, A)).




output(garten, ["Du", gehst, in, den, "Garten.", "Er", ist, wunderschoen, und, man, "sieht,", dass, diese, "Familie", einen, "Gaertner", haben, "muss."]).
output(arbeitszimmer, ["Du", betrittst, das, "Arbeitszimmer.", "Es", ist, offensichtlich, dass, dies, das, "Reich", des, "Vaters", "ist."]).
output(kueche, ["Du", betrittst, die, "Kueche.", "Sie", ist, ziemlich, "groß", und, scheint, sehr, gut, ausgeruestet, zu, "sein."]).
output(schlafzimmer, ["Du", betrittst, das, "Schlafzimmer.", "Es", ist, klar, dass, die, "Mutter", bei, dessen, "Einrichtung", die, "Finger", im, "Spiel", "hatte."]).
output(wohnzimmer, ["Du", betrittst, das, "Wohnzimmer.", "Es", ist, das, schoenste, "Zimmer", des, "Hauses", mit, "Blick", auf, den, "Garten", und, einer, "Sofaecke."]).
output(eingangsbereich, ["Du", betrittst, den, "Eingangsbereich.", "Die", "Anzahl", der, "Schuhe", wuerde, vermuten, lassen, dass, hier, 15, "Menschen", leben, wenn, man, es, nicht, besser, "wuesste."]).
output(gespraech_ende, ["Du", beendest, das, "Gespraech."]).
output(kind, ["Du", gehst, zu, dem, "Kind", und, beginnst, ein, "Gespraech."]).
output(no, ["Okay,", dann, eben, "nicht."]).
output(no_hinweis, ["Einen", weiteren, "Hinweis", musst, du, dir, erst, "erarbeiten."]).
output(no_tipp, ["Ich", gebe, dir, jetzt, keinen, weiteren, "Tipp."]).
output(no_bitte, ["Ohne", "Bitte", geht, hier, "garnichts -" , "Deine", "Eltern", haben, bei, der, "Erziehung", ja, mal, voll, "versagt."]).
output(help, ["Ich", hoffe, ich, konnte, dir, "helfen."]).
output(nothing, []).
output(solved, ["Du", hast, den, "Fall", "gelöst,", herzlichen, "Glückwunsch!","Beende", das, "Programm", mit, "'bye'."]).
output(wrong_suspicion, ["Dieser", "Verdacht", ist, leider, "falsch,", versuche, es, "später", "nochmal!", "Du", hast, noch, Anzahl, "Verdächtigungsversuche", "übrig."]) :-
	verdaechtigungszahl(AlteAnzahl),
	Anzahl is 2 - AlteAnzahl.

