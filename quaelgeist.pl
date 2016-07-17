:- include('framework.pl').
:- include('scheresteinpapier.pl').
:- include('mastermindRandom.pl').
:- include('morsealphabet.pl').
:- encoding(iso_latin_1).


% definiert die aktuelle situation
% mögliche situationen sind kind, garten, arbeitszimmer, wohnzimmer, schlafzimmer, eingangsbereich, kueche, geheim
:- retractall(situation(_)).
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


:- retractall(was_there(_)).
:- dynamic was_there/1.

was_there(eingangsbereich).

add_location(NewLocation) :-
	ort(NewLocation),
	not(was_there(NewLocation)),
	assertz(was_there(NewLocation)).
	


% definiert die personen, mit denen man interagieren kann und sich selbst
:- retractall(person(_)).
:- dynamic person/2.

person('Du', eingangsbereich).
person('Alex', eingangsbereich).
person('Beamter', eingangsbereich).

change_person(Person,NewLocation) :-
	person(Person,OldLocation),
	retract(person(Person,OldLocation)),
	assertz(person(Person,NewLocation)).

%dynamisches Prädikat: 
:- retractall(verdaechtigungszahl(_)).
:- dynamic verdaechtigungszahl/1.
verdaechtigungszahl(0).

set_verdaechtigung :-
	retract(verdaechtigungszahl(AlteAnzahl)),
	NeueAnzahl is AlteAnzahl+1, 
	assert(verdaechtigungszahl(NeueAnzahl)),
	(
		(
			NeueAnzahl < 3,
			writeln("Du solltest besser ueber deine Antworten nachdenken, unendlich viele Versuche hast du nicht mehr!")
			);
		(
			NeueAnzahl>=3,
			writeln("Du hast zu viele falsche Verdächtigungen gemacht, du darfst keine mehr äußern."),
			writeln("Leider hast du den Fall nicht gelöst und wirst gefeuert."),
			writeln("Das Spiel ist nun beendet - schließe es mit 'bye' und starte es neu für einen weiteren Versuch.")
			)
		).


%dynamisches Praedikat: 
:- retractall(geheimgangGewesen(_)).
:- dynamic geheimgangGewesen/1.

geheimgangGewesen(0).

set_geheimgangGewesen :-
	retract(geheimgangGewesen(AlteAnzahl)),
	NeueAnzahl is AlteAnzahl+1, 
	assertz(geheimgangGewesen(NeueAnzahl)).


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


:- retractall(morsespiele(_)).
:- dynamic morsespiele/1.

morsespiele(0).

set_morsespiele :-
	retract(morsespiele(AlteAnzahl)),
	NeueAnzahl is AlteAnzahl+1, 
	assertz(morsespiele(NeueAnzahl)).

:- retractall(alter_antwort(_)).
:- dynamic alter_antwort/1.

alter_antwort(["8"]).

:- retractall(name_antwort(_)).
:- dynamic name_antwort/1.

name_antwort(["Ich", "heiße", "Alex"]).

:- retractall(location_counter(_)).
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

randomize_child :-
	(
		location_counter(3),
		reset_counter,
		alle_orte(Orte),
		random_permutation(Orte, [Location|_]),
		change_person('Alex', Location)
		);
	increase_counter.

%Wissensbasis

%location(eingangsbereich, 'der Eingangsbereich').
%location(schlafzimmer, 'das Schlafzimmer').
%location(küche, 'die Küche').
%location(garten, 'der Garten').
%location(wohnzimmer, 'das Wohnzimmer').
%location(arbeitszimmer, 'das Arbeitszimmer').
%location(geheimgang, 'der Geheimgang').

location(eingangsbereich, 'der Eingangsbereich', 'den Eingangsbereich').
location(eingangsbereich_beamter, 'der Eingangsbereich', 'den Eingangsbereich').
location(schlafzimmer, 'das Schlafzimmer', 'das Schlafzimmer').
location(küche, 'die Küche', 'die Küche').
location(garten, 'der Garten', 'den Garten').
location(wohnzimmer, 'das Wohnzimmer', 'das Wohnzimmer').
location(arbeitszimmer, 'das Arbeitszimmer', 'das Arbeitszimmer').
location(geheimgang, 'der Geheimgang', 'den Geheimgang').


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

eltern(vater).
eltern(mutter).

angestellte(gaertner).
angestellte(koch).

alle_taeter(Taeter) :- setof(T, taeter(T), Taeter).

%Mord 
tatort(arbeitszimmer).
tatwaffe(seil).
moerder(nachbar).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%wenn wir es randomisieren wollen, allerdings scheint das sehr schwierig, weil man dasn die Hinweise anpassen müsste etc.
%tatort(Tatort) :- alle_orte(Orte), random_permutation(Orte,[Tatort|_Rest]).
%tatwaffe(Tatwaffe) :- alle_waffen(Waffen), random_permutation(Waffen, [Tatwaffe|_Rest]).
%moerder(Moeder) :- alle_taeter(Taeter), random_permutation(Taeter,[Moeder|_Rest]).

%um Mord auszugeben
%mord :- tatort(Ort), tatwaffe(Waffe), moerder(Moerder), 
%		write('Der Taeter ist: '), writeln(Moerder), write('Der Tatort ist: '), writeln(Ort), write('Die Tatwaffe ist: '), writeln(Waffe).

lageplan :- nl,
			writeln("                LAGEPLAN             "),
			writeln("____/ _______________________________"),
			writeln("|            |           |           | \\"),
			writeln("|            |           |           |   \\"),
			writeln("|            |           |           |     \\"),
			writeln("|  Eingangs- |  Schlaf-  |  Küche    |       \\"),
			writeln("|  bereich   |  zimmer   |           |         \\"),
			writeln("|            |           |           |          |"),
			writeln("|            |____  _____|____  _____|          |"),
			writeln("|                                    |          |"),
			writeln("|                                       Garten  |"),
			writeln("|_______  ________________  _________|          |"),
			writeln("|                 |                  |          |"),
			writeln("|                 |                  |          |"),
			writeln("|    Arbeits-     |                  |         /"),
			writeln("|    zimmer       |   Wohnnzimmer    |       /"),
			writeln("|                 |                  |     /"),
			writeln("|                 |                  |   /"),
			writeln("|_________________|__________________| /"),
			nl.


verdaechtigung(A) :- 
	writeln("Ok, dann lass mal hören."),
	writeln("Wer ist deiner Meinung nach der Mörder?"),
	read_sentence([Moerderverdacht|_Tail]),
	(
		(
			taeter(Moerderverdacht),
			verdaechtigung2(Moerderverdacht, A)
			); 
		(
			writeln("Ich bin so gespannt, deswegen nenne den Tatverdächtigen als erstes in deinem Satz."),
			writeln("Du kannst nur Personen verdächtigen, die in der Liste der möglichen Täter auftauchen:"),
			alle_taeter(Taeterliste),
			writeln(Taeterliste),
			verdaechtigung1(A)
			)
		).

verdaechtigung1(A) :- 
	writeln("Wer ist deiner Meinung nach der Mörder?"),
	read_sentence([Moerderverdacht|_Tail]),
	(
		(
			taeter(Moerderverdacht),
			verdaechtigung2(Moerderverdacht, A)
			);
		(
			writeln("Ich bin so gespannt, deswegen nenne den Tatverdächtigen als erstes in deinem Satz."),
			writeln("Du kannst nur Personen verdächtigen, die in der Liste der möglichen Täter auftauchen."),
			alle_taeter(Taeterliste),
			writeln(Taeterliste),verdaechtigung1(A)
			)
		).

verdaechtigung2(Moerderverdacht, A) :- 
	writeln("Was war die Tatwaffe?"),
	read_sentence([Tatwaffeverdacht|_Tail]),
	(
		(
			waffe(Tatwaffeverdacht),
			verdaechtigung3(Moerderverdacht, Tatwaffeverdacht, A)
			);
		(
			writeln("Ich bin so gespannt, deswegen nenne die Tatwaffe als erstes in deinem Satz."),
			writeln("Du kannst nur Gegenstände nennen, die in der Liste der möglichen Tatwaffen auftauchen:"),
			alle_waffen(Waffen),
			writeln(Waffen),
			verdaechtigung2(Moerderverdacht, A)
			)
		).


verdaechtigung3(Moerderverdacht, Tatwaffeverdacht, A) :- 
	writeln("Wo wurde die Putzfrau ermordet?"),
	read_sentence([Ortverdacht|_Tail]), 
	(
		location(Ortverdacht, _, _),
		verdaechtigungComplete(Moerderverdacht,Tatwaffeverdacht, Ortverdacht, A)
		);
	(
		writeln("Ich bin so gespannt, deswegen nenne den Tatort als erstes in deinem Satz."),
		writeln("Du kannst nur Orte nennen, die in der Liste der möglichen Tatorte stehen:"),
		alle_orte(Orte),
		writeln(Orte),
		verdaechtigung3(Moerderverdacht,Tatwaffeverdacht, A)
		).

verdaechtigungComplete(Moerderverdacht,Tatwaffeverdacht, Ortverdacht, A) :- 
	(
		moerder(Moerderverdacht),
		tatwaffe(Tatwaffeverdacht),
		tatort(Ortverdacht),
		output(solved, A)
		);
	output(wrong_suspicion, A).


random_answer(Situation, Head) :- 
	normal(Situation),
	random_permutation([
		["Ich", denke, nicht, dass, wir, jetzt, darüber, reden, "sollten."],
		["Bitte", denke, nocheinmal, über, deinen, nächsten, "Schritt", "nach."],
		["Willst", du, das, "Spiel", etwa, "beenden?", "Dann", musst, du, "'bye'", "eingeben."]],
		[Head|_]).

random_answer(kind, Head) :- 
	random_permutation([
		["Hey,", du, willst, etwas, von, "mir,", stell, eine, sinnvolle, "Frage!"],
		["Darauf", will, ich, dir, gerade, nicht, "antworten."],
		["Willst", du, unser, "Gespräch", etwa, schon, "beenden?", "Dann", sag, das, doch, "einfach."]],
		[Head|_]).


gerichtsmediziner(Loc,A) :-
	(
		was_there(eingangsbereich),
		was_there(garten),
		was_there(kueche),
		was_there(arbeitszimmer),
		was_there(wohnzimmer),
		was_there(schlafzimmer),
		gerichtsmediziner_output(Loc, A)
		);
	output(Loc, A).

gerichtsmediziner_output(Loc, A) :-
	location(Loc, _, _),
	tatort(Tatort),
	tatort_tipp(Tatort, Tipp),
	nl,
	write("Als du loslaufen willst klingelt dein Handy."),
	nl,
	writeln("'Hallo?'"),
	writeln("'Guten Tag, Frank von der Gerichtsmedizin hier. "), 
	write(Tipp), writeln("'"),
	writeln("'Vielen Dank. Sonst noch etwas?'"),
	writeln("'Nein.'"),
	writeln("'Okay, vielen Dank nocheinmal - Einen schönen Tag Ihnen noch.'"),
	writeln("'Ebenso.'"),
	nl,
	writeln("Du legst auf und überlegst kurz, was dieser Hinweis bedeuten kann."),
	writeln("Dann setzt du deine Suche fort."),
	output(Loc, A).



tatort_tipp(wohnzimmer, "Ich wollte Ihnen nur mitteilen, dass wir in der Wunde Sofafusseln gefunden haben.").
tatort_tipp(garten, "Ich wollte Ihnen nur mitteilen, dass wir in der Wunde Grasreste gefunden haben.").
tatort_tipp(arbeitszimmer, "Ich wollte Ihnen nur mitteilen, dass wir in der Wunde Papierschnipsel - scheinbar aus einem Aktenvernichter - gefunden haben.").
tatort_tipp(eingangsbereich, "Ich wollte Ihnen nur mitteilen, dass wir in der Wunde Schlammreste gefunden haben.").
tatort_tipp(eingangsbereich_beamter, "Ich wollte Ihnen nur mitteilen, dass wir in der Wunde Schlammreste gefunden haben.").
tatort_tipp(kueche, "Ich wollte Ihnen nur mitteilen, dass wir in der Wunde Lebensmittelreste gefunden haben.").
tatort_tipp(schlafzimmer, "Ich wollte Ihnen nur mitteilen, dass wir in der Wunde Daunenfedern gefunden haben.").


% Situation: normal

normal(X) :- 
	member(X, [eingangsbereich, garten, küche, arbeitszimmer, wohnzimmer, schlafzimmer, geheimgang]).


match([wie, geht, es, dir],["Was für eine langweilige Frage von dir."]) :- 
	situation(kind).

match([ok], ["Stell", ruhig, munter, weiter, "Fragen,", ich, schaue, "dann,", ob, ich, sie, dir, beantworten, "will."]) :-
	situation(kind).

match([wie, hast, du, den, mord, gesehen], ["Ich", bin, ein, "Meister", im, "Verstecken."]) :-
	situation(kind).

match([war, es, _, _], ["So", einfach, mache, ich, es, dir, "nicht!"]) :-
	situation(kind).

match([hallo], ["Hallo."]) :-
	situation(kind).

match([wo, ist, alex], [Ort]) :-
	person('Alex', Ort).

match(Input, Output) :-
	ask(Input, Output).

% muss immer als letzte match-Abfrage stehen
match(_, Answer) :- 
	situation(Situation),
	random_answer(Situation, Answer).


ask(Q, ["Dort", bist, du, doch, "bereits!"]) :- 
	not(situation(kind)),
	not(situation(beamter)),
	normal(Location),
	member(Location, Q),
	person('Du', Location).


ask(Q, A) :-
	not(situation(kind)),
	not(situation(beamter)),
	member(garten, Q),
	nl,
	writeln("Willst du wirklich in den Garten gehen?"),
	nl,
	read_sentence(Input),
	(
		(
			member(ja, Input),
			change_situation(garten),
			add_location(garten),
			randomize_child,
			output(garten, A)
			);
		output(no, A)
		).

ask(Q, A) :-
	not(situation(kind)),
	not(situation(beamter)),
	member(arbeitszimmer, Q),
	nl,
	writeln("Willst du wirklich in das Arbeitszimmer gehen?"),
	nl,
	read_sentence(Input),
	(
		(
			member(ja, Input),
			change_situation(arbeitszimmer),
			add_location(arbeitszimmer),
			randomize_child,
			gerichtsmediziner(arbeitszimmer, A)
			);
		output(no, A)
		).

ask(Q, A) :-
	not(situation(kind)),
	not(situation(beamter)),
	member(küche, Q),
	nl,
	writeln("Willst du wirklich in die Küche gehen?"),
	nl,
	read_sentence(Input),
	(
		(
			member(ja, Input),
			change_situation(kueche),
			add_location(kueche),
			randomize_child,
			gerichtsmediziner(kueche, A)

			);
		output(no, A)
		).

ask(Q, A) :-
	not(situation(kind)),
	not(situation(beamter)),
	member(schlafzimmer, Q),
	nl,
	writeln("Willst du wirklich in das Schlafzimmer gehen?"),
	nl,
	read_sentence(Input),
	(
		(
			member(ja, Input),
			change_situation(schlafzimmer),
			add_location(schlafzimmer),
			randomize_child,
			gerichtsmediziner(schlafzimmer, A)
			);
		output(no, A)
		).

ask(Q, A) :-
	not(situation(kind)),
	not(situation(beamter)),
	member(wohnzimmer, Q),
	nl,
	writeln("Willst du wirklich in das Wohnzimmer gehen?"),
	nl,
	read_sentence(Input),
	(
		(
			member(ja, Input),
			change_situation(wohnzimmer),
			add_location(wohnzimmer),
			randomize_child,
			gerichtsmediziner(wohnzimmer, A)
			);
		output(no, A)
		).


ask(Q, A) :-
	not(situation(kind)),
	not(situation(beamter)),
	(member(eingangsbereich, Q);
		member(eingang, Q)),
	nl,
	writeln("Willst du wirklich in den Eingangsbereich gehen?"),
	nl,
	read_sentence(Input),
	(
		(
			member(ja, Input),
			(
				(
					person('Beamter', eingangsbereich),
					gerichtsmediziner(eingangsbereich_beamter, A)
					);
				gerichtsmediziner(eingangsbereich, A)
				),
			change_situation(eingangsbereich),
			randomize_child
			);
		output(no, A)
		).


ask(Q, A) :-
	not(situation(kind)),
	not(situation(beamter)),
	(member(geheimgang, Q);
		member(geheim, Q);
		member(gang, Q)
		),
	morsespiele(X),
	not(X=0),
	geheimgangGewesen(Y),
	((not(Y>0),
	nl,
	writeln("Willst du wirklich in den Geheimgang gehen?"),
	nl,
	read_sentence(Input),
	(
		(
			member(ja, Input),
			output(geheimgang, A),
			change_situation(geheimgang),
			set_geheimgangGewesen,
			randomize_child
			);
		output(no, A)
		));
	output(geheimgewesen, A)).


%%%%%%%%%%
% Umschauen in Räumen 
%%%%%%%%%%

%%%%%%%%%%%%Schlafzimmer
ask(Q,["Du", habst, die, "Bettdecke", an, und, darunter, liegt, eine, zusammengerollte, "Katze", und, "schläft."]) :-
	situation(schlafzimmer),
	(member(bett,Q);
		member(decke,Q);
		member(bettdecke, Q);
		member(wölbung, Q)
		).

ask(Q,["Du", kraulst, die, "Katze", und, sie, schnurrt, zufrieden, vor, sich, "hin."]) :-
	situation(schlafzimmer),
	member(katze,Q).

ask(Q,["Du", gehst, zum, "Nachtisch", und, betrachtest, die, "Uhr", genauer, und, stellst, "fest,", dass, sie, sehr, alt, "ist.", "\nVermutlich", ein, "Erbstück,", daher, passt, sie, nicht, zum, modernen, "Rest", des, "Zimmers.", "\nDa", bemerkst, "du,", dass, die, "Uhr", auf, einem, dicken, "Buch", "steht."]) :-
	situation(schlafzimmer),
	(member(nachttisch,Q);
		member(tisch,Q);
		member(uhr, Q)
		).

ask(Q,["Das Buch trägt den Titel: Das perfekte Verbrechen."]) :-
	situation(schlafzimmer),
	member(buch,Q).

ask(Q,["Du", öffnest, den, "Schrank", und, bist, von, der, "Fülle", an, "Klamotten", "beeindruckt -", "Hemden, Hosen, Kleider, Taschen, Schuhe, Krawatten-", in, allen, möglichen, "Farben und Mustern.", "\nWährend", du, noch, ganz, fasziniert, die, "Kleidung", "begutachtest,", fällt, die, plötzlich, "auf,", dass, sich, hinten, im, "Schrank", eine, versteckte, "Türe", "befindet."]) :-
	situation(schlafzimmer),
	(member(schrank,Q);
		member(kleiderschrank,Q);
		member(sschrenktür, Q)
		).

ask(Q,["Du versuchst die Türe zu öffnen, du rüttelst kräftig daran, doch leider beibst du dabei erfolglos."]) :-
	situation(schlafzimmer),
	(member(türe,Q);
		member(tür,Q);
		member(versuchen, Q) %falls jemand es nochmal versuchen will die Tuere zu oeffnen
		).

ask(Q, ["Ein Schlüssel für die Türe im Schrank ist weit und breit nicht zu sehen."]) :-
	situation(schlafzimmer),
	member(schlüssel, Q).

%%%%%%%%%%%%Wohnzimmer
ask(Q, ["Das bequeme weiße Sofa sieht wie frisch gereinigt aus, kein noch so kleiner Fleck ist zu sehen."]) :-
	situation(wohnzimmer),
	(member(sofa,Q);
		member(kissen,Q);
		member(sofaecke,Q)
		).

ask(Q, ["Von hier hat man den gesamten Garten gut im Überblick.", "\nDie Fensterscheiben sind so getönt, dass man gut raus schauen kann, aber niemand vom Garten reinschauen kann."]) :-
	situation(wohnzimmer),
	member(fenster, Q).

ask(Q, ["Du schaust dir die Bücher an - eine Brockhaus Enzyklopädie, ein Atlas, ein paar Romane, hier und dort ein Kinderbuch - nicht weiter interessant."]) :-
	situation(wohnzimmer),
	(member(bücherwand,Q);
		member(bücher,Q);
		member(buch,Q);
		member(bücherregal, Q)
		).

ask(Q, ["Ein Buch zu lesen ist jetzt keine gute Idee, du musst einen Fall lösen, sonst bist du deinen Job los."]) :-
	situation(wohnzimmer),
	member(lesen, Q).


ask(Q, A) :-
	situation(wohnzimmer),
	(member(gemälde, Q);
		member(bild, Q)
		),
	writeln("Auf dem Bild sind 2 Reiter auf Pferden zu sehen."),
	nl,
	morsespiele(X),
	(X=0, output(geheimunbekannt, A);
		output(geheimbekannt, A)).


%%%%%%%%%%%%%%Geheimgang

ask(Q,["Du gehst näher heran, bückst dich und hebst einen blutverschmierten Gegenstand auf.", "\nEs ist:", Waffe]):-
	situation(geheimgang),
	(member(boden, Q);
		member(gegenstand, Q);
		member(liegen, Q);
		member(liegt, Q)
		),
	tatwaffe(Waffe).


ask(Q, A) :-
	situation(geheimgang),
	member(raus, Q),
	change_situation(schlafzimmer),
	nl,
	writeln("Du gehst den Gang weiter entlang und am Ende ist eine Tür. Diese lässt sich von dieser Seite problemlos ohne Schlüssel öffnen."),
	output(schlafzimmer, A).
%%%%%%%%%%%%%%%

ask(Q, A) :-
	person('Beamter', eingangsbereich),
	situation(eingangsbereich),
	(
		member(beamter, Q);
		member(beamten, Q);
		member(polizisten, Q);
		member(polizist, Q)
		),
	nl,
	writeln("Willst du den Beamten ansprechen?"),
	nl,
	read_sentence(Input),
	(
		(
			member(ja, Input),
			output(beamter, A),
			retract(person('Beamter', _)
				),
			change_situation(beamter)
			);
		output(no, A)
		).

ask(Q, A) :-
	situation(beamter),
	(
		(
			member(täter, Q);
			member(mörder, Q);
			member(info, Q);
			member(infos, Q);
			member(information, Q);
			member(informationen, Q)
			),
		nl,
		writeln("Ich kann Ihnen nicht sagen wer den Mord tatsächlich begangen hat, aber ich kann Ihnen folgendes sagen:"),
		output(taeter_info, A)
	 );
	(
		(
			member(tatverdächtigen, Q);
			member(tatverdächtige, Q);
			member(tatverdächtiger, Q)
			),
		output(taeter_info, A)
		).

ask(Q, A) :-
	situation(beamter),
	(member(beenden, Q);
		member(tschuess, Q);
	 	member(gehen, Q);
	 	member(ende, Q);
	 	member(wiedersehen, Q);
	 	member(danke, Q)
	 	),
	nl,
	writeln("Kann ich Ihnen sonst noch behilflich sein?"),
	nl,
	read_sentence(Input),
	(
		(
			(
				member(nein, Input);
				member(danke, Input)),
			person('Du', Location),
			change_situation(Location),
			output(gespraech_ende, A));
		output(beamter_stay, A)
		).



% Gespräch beginnen
ask(Q, A) :-
	person('Alex', Location),
	situation(Location), 
	(
		member(kind, Q);
		member(alex, Q)
		),
	nl,
	writeln("Willst du das Kind ansprechen?"),
	nl,
	read_sentence(Input),
	(
		(
			member(ja, Input),
			output(kind, A),
			change_situation(kind)
			);
		output(no, A)
		).
%wenn ales nicht in dem Zimmer ist, du aber versuchst ihn anzusprechen
ask(Q, ["Das Kind ist nicht in diesem Raum, such es erstmal, bevor du es ansprichst."]) :-
	person('Alex', Location),
	not(situation(Location)), 
	(
		member(kind, Q);
		member(alex, Q)
		).

ask(Q, A) :-
	situation(kind),
	member(hinweis, Q),
	nl,
	writeln("Willst du einen Hinweis von mir?"),
	nl,
	read_sentence(Input),
	(
		(
			(
				(
					member(ja, Input),
					member(bitte, Input)
					);
				member(bitte, Input)
				),
			(
				(
					scheresteinpapierspiele(X),
					X = 0,
					(
						(
							moerder(T),
							eltern(T),
							scheresteinpapier(A,eltern)
							);
						scheresteinpapier(A,sonstige)
						),
					set_scheresteinpapier
					);
				output(no_hinweis, A)
				)
			);
		(
			(
				member(ja, Input)
				),
			not(member(bitte, Input)),
			output(no_bitte, A)
			);
		output(no, A)
		).


ask(Q, A) :-
	situation(kind),
	member(tipp, Q),
	nl,
	writeln("Willst du einen Tipp von mir?"),
	nl,
	read_sentence(Input),
	(
		(
			(
				(
					member(ja, Input),
					member(bitte, Input)
					);
				member(bitte, Input)
				),
			(
				(
					mastermindspiele(X),
					X = 0,
					(
						(
							moerder(T),
							angestellte(T),
							mastermind(A, angestellter)
							);
						mastermind(A, sonstige)
						),
					set_mastermind
					);
				output(no_tipp, A)
				)
			);
		(
			(
				member(ja, Input)
				),
			not(member(bitte, Input)
				),
			output(no_bitte, A)
			);
		output(no, A)
		).



ask(Q, A) :-
	situation(kind),
	(
		member(hilfe, Q);
		member(helfen, Q);
		member(hilfestellung, Q)
		),
	nl,
	writeln("Brauchst du meine Hilfe?"),
	nl,
	read_sentence(Input),
	(
		(
			(
				(
					member(ja, Input),
					member(bitte, Input)
					);
				member(bitte, Input)
				),
			(
				(
					morsespiele(X),
					X = 0,
					morsen(A),
					set_morsespiele
					);
				output(no_hilfe, A)
				)
			);
		(
			(
				member(ja, Input)
				),
			not(member(bitte, Input)
				),
			output(no_bitte, A)
			);
		output(no, A)
		).

ask(Q, A) :-
	situation(kind),
	(member(rat, Q);
		member(ratschlag, Q)
		),
	(moerder(gaertner), output(falscher_rat1, A);
		output(falscher_rat2,A)).

ask(Q,A):-
	situation(kind),
	morsespiele(X),
	not(X=0),
	geheimgangGewesen(Y),
	not(Y>0),
	(member(folge, Q);
		member(folgen, Q);
		member(mitkommen, Q)
		),
	change_situation(wohnzimmer),
	change_person('Alex', wohnzimmer),
	output(folgen, A).


ask(Q, ["Ich", "weiß", "selber,", dass, das, Word, "ist!"]) :-
	situation(kind),
	normal(Location),
	member(Location, Q),
	person('Du', Location),
	location(Location, Word,_).


ask(Q, ["Nein,", das, hier, ist, nicht, Word, "-", das, sieht, man, "doch."]) :-
	situation(kind),
	normal(Location),
	member(Location, Q),
	not(person('Du', Location)),
	location(Location, Word,_).

ask(Q,["Bitte,", ich, beende, jetzt, das, "Gespräch,", ich, will, lieber, "spielen."]) :-
	situation(kind),
	member(danke, Q),
	person('Du', Location),
	change_situation(Location).

ask(Q, A) :-
	situation(kind),
	(
		member(beenden, Q);
		member(tschuess, Q);
		member(gehen, Q);
		member(ende, Q);
		member(wiedersehen, Q)
		),
	nl,
	writeln("Willst du unser Gespräch etwa einfach so beenden?"),
	nl,
	read_sentence(Input),
	(
		(
			member(ja, Input),
			person('Du', Location),
			change_situation(Location),
			output(gespraech_ende, A)
			);
		output(no, A)
		).

ask(Q, A) :-
	situation(kind),
	(
		member(alt, Q);
		member(alter, Q)
		),
	nl,
	writeln("Willst du etwa wissen wie alt ich bin?"),
	nl,
	read_sentence(Input),
	(
		(
			member(ja, Input),
			alter_antwort(A),
			retract(alter_antwort(A)
				),
			assertz(alter_antwort(["Das", habe, ich, dir, doch, bereits, "gesagt."]))
			);
		output(no, A)
		).


ask(Q,A) :-
	situation(kind),
	(
		member(name, Q);
		member(heißt, Q);
		member(heisst, Q)
		),
	nl,
	writeln("Willst du meinen Namen wissen?"),
	nl,
	read_sentence(Input),
	(
		(
			member(ja, Input),
			name_antwort(A),
			retract(name_antwort(A)),
			assertz(name_antwort(["Kannst", du, dir, nichtmal, meinen, "Namen", "merken?"]))
			);
		output(no, A)
		).

%wollen wir hier nciiht auch Situation beamter zulassen? so nach dem motto: was koennen sie ueber das opfer sagen: er sagt dann haalt nur Opfer ist Putzfrau, weis nciht mehr
ask(Q,["Das", "Opfer", ist, die, "Putzfrau", der, "Familie."]) :-
	not(situation(kind)),
	not(situation(beamter)),
	member(opfer, Q).


ask(Q, []) :- 
	not(situation(kind)),
	not(situation(beamter)),
	member(lageplan, Q),
	lageplan.


ask(Q, []) :- 
	not(situation(kind)),
	not(situation(beamter)),
	(
		member(tatorte, Q);
		member(räume, Q)
		),
	nl,
	writeln("Alle Räume im Haus kommen als Tatort in Frage:"),
	lageplan.


ask(Q, A) :-
	(
		member(verdächtigung, Q);
		member(verdächtige, Q);
		member(verdächtigter, Q);
		member(verdächtig, Q);
		member(täter, Q)
		),
	nl,
	writeln("Möchtest du eine Verdächtigung äußern?"),
	nl,
	read_sentence(Input),
	(
		(
			member(ja, Input),
			verdaechtigungszahl(Anzahl),
			Anzahl < 3,
			verdaechtigung(A),
			set_verdaechtigung
			);
		output(no, A)
		).


	

output(garten,
	["Du", gehst, in, den, "Garten.",
	"\n\nEr", ist, "wunderschön", und, man, "sieht,", dass, diese, "Familie", einen, "Gärtner", haben, "muss.",
	"\nEine", rechteckig, gestutzte, "Hecke", "schützt", das, "Innere", vor, neugierigen, "Blicken.",
	"\nAußerdem", gibt, es, ein, "großes,", buntes, "Blumenbeet", und, einen, riesigen, "Apfelbaum.",
	"\n\nDas", "Highlight", des, "Gartens", ist, aber, klar, die, "große", "Sitzecke", mit, "Holzbänken", und, einer, "Grillschale,",
	"\nin", der, es, scheinbar, vor, "Kurzem", noch, gebrannt, "hatte."]
	).

output(arbeitszimmer, 
	["Du", betrittst, das, "Arbeitszimmer.", 
	"\n\nEs", ist, offensichtlich, dass, dies, das, "Reich", des, "Vaters", "ist.",
	"\nDas", "Zimmer", ist, "spärlich", "eingerichtet -", lediglich, eine, "Schrankwand", voll, mit, "Ordnern", und, "DVDs", und,
	"\nein", "Schreibtisch", sowie, ein, "Stuhl", finden, sich, "hier.",
	"\n\nAn", der, "Wand", "hängt", neben, einigen, "Bildern", und, einem, "Kalender", auch, eine, "Dartscheibe,", in, der, noch, einige, "Darts", "stecken.",
	"\nDie", "Dartscheibe", scheint, mit, einem, "Foto", "geschmückt", zu, "sein,", auf, das, offensichtlich, mehrfach, gezielt, "wurde."]
	).

output(kueche, 
	["Du", betrittst, die, "Küche.",
	"\n\nDer", "Raum", ist, beinahe, quadratisch, mit, einer, "großen", "Küchenzeile", auf, der, rechten, und, einer, "Schrankwand", mit, "Kühlschrank", auf, der, linken, "Seite.",
	"\nEin", "Fenster", zum, "Garten", sorgt, "für", viel, "Licht", und, einen, "schönen", "Ausblick", auf, den, "Garten.",
	"\n\nDie", letzte, "Person,", die, hier, gekocht, "hat,", scheint, nicht, sehr, ordentlich, gewesen, zu, "sein,",
	"\nden", "überall", liegen, noch, "Reste", der, "Mahlzeit", "herum."]).

output(schlafzimmer, 
	["Du", betrittst, das, "Schlafzimmer.",
	"\n\nEs", ist, klar, dass, die, "Mutter", bei, dessen, "Einrichtung", die, "Finger", im, "Spiel", "hatte.",
	"\nDas", ganze, "Zimmer", ist, liebevoll, mit, "Dekoartikeln", "geschmückt," ,
	"\ndie", "Uhr", auf, dem,"Nachttisch", scheint, aber, "überhaupt", nicht, ins, "Bild", zu, "passen.",
	"\nEin", "Kleiderschrank" , steht, an, der, "Wand", gegenüber, von, der, "Tür.",
	"\nDie", "Daunendecke", liegt, "säuberlich", gefaltet, auf, dem, "Bett,", 
	"\nin", der, "Mitte", erkennt, man, "- bei", genauem, "Hinsehen-", eine, leichte, "Wölbung."]
	).

output(wohnzimmer, 
	["Du", betrittst, das, "Wohnzimmer.",
	"\n\nEs", ist, das, "schönste", "Zimmer", des, "Hauses, ", mit, einer, "Sofaecke", und , einem, großen, bodentiefen, "Fenster", durch, das, man, einen, "Blick", auf, den, ganzen, "Garten hat.", 
	"\nEine", riesige, "Bücherwand", ziert, die, "Längsseite.",
	"\nDas", beeindruckende, prunkvolles, "Gemälde", an, der, "Wand", direkt, "über", dem, "Sofa", zieht, dich, sofort, in, seinen, "Bann."]
	).
%Gemaelde ist Eingang zu Geheimgang
%wenn morsen not true, dann "Das Bild sieht irgendwie so aus als wuerde es ein Geheimnis verbrgen, aber ich kann es nciht erkennen"
%nach morsen: morsen true: "Wusste ich doch, dass hier etwas hintersteckt, aber mit dem Eigang zum Geheimgang hatte ich nciht gerechnet."
%willst du in geheimgang gehen?

output(eingangsbereich, 
	["Du", betrittst, den, "Eingangsbereich.", 
	"\n\nDas", einzige, "Möbelstück", hier, ist, eine, "Kommode,", auf, der, die, ganzen, "Schlüssel", der, "Familie", sowie, die, neueste, "Post", zu, liegen, "scheint.",
	"\nIn", der, "Garderobe", finden, sich, auf, den, ersten, "Blick", nur, einige, "Jacken", und, "Schuhe,", die, viele, "Schlammspuren", hinterlassen, "haben.",
	"\n\nDas", "Licht", an, der, "Decke", flackert, "nervös."]
	).

output(eingangsbereich_beamter, 
	["Du", betrittst, den, "Eingangsbereich.",
	"\n\nDort", steht, ein, weiterer, "Beamter", und, schreibt, etwas, in, sein, "Notizbuch.", 
	"\n\nEr", steht, neben, einer, "Kommode,", auf, der, die, ganzen, "Schlüssel", der, "Familie", sowie, die, neueste, "Post", zu, liegen, "scheint.",
	"\nIn", der, "Garderobe", finden, sich, auf, den, ersten, "Blick", nur, einige, "Jacken", und, "Schuhe,", die, viele, "Schlammspuren", hinterlassen, "haben.",
	"\n\nDas", "Licht", an, der, "Decke", flackert, "nervös."]
	).

output(geheimgang,
	["Du bist in einem Gang, da du kaum etwas sehen kannst, machst du erstmal deine Taschenlampe an.",
	"\nLangsam leuchtest du mit dem Lichtkegel den Gang ab, hier gibt es kaum was.",
	"\nDu läufst weiter, da entdeckst du etwas vor dir auf dem Boden."]
	).

output(taeter_info, 
	["Unsere", "Tatverdächtigen", sind, diese, sechs, "Personen:",
	"\n\nDer", "Vater:", "Er", ist, 39, "Jahre", alt, und, ein, echter, "Workaholic.",
	"\nEr", hat, seine, "Frau", schon, "länger", im, "Verdacht,", "eine", "Affäre", mit, einem, "Freund", oder, "Angestellten", zu, "haben.",
	"\n\nDie", "Mutter:", "Sie", ist, 32, "Jahre", alt, und, im, "Moment", unzufrieden, mit, ihrem, "Leben.",
	"\nSie", hat, ihre, "Arbeit", "für", die, "Familie", "aufgegeben,", doch, ihr, "Ehemann", ist, selten, zuhause, und, das, gemeinsame, "Kind", ist, sehr, "anstrengend.",
	"\nDennoch", beteuert, "sie,", immer, treu, gewesen, zu, "sein.",
	"\n\nDer", "Gärtner:", "Er", ist, 27, "Jahre", alt, und, stammt, "ursprünglich", aus, "Mexiko.",
	"\nEr", ist, sehr, "gutaussehend,", macht, viel, "Sport", und, ist, vorallem, morgens, im, "Haus,", weshalb, der, "Ehemann", ihn, als, erstes, einer, "Affäre", mit, seiner, "Frau", "verdächtigte.",
	"\nMan", hat, dennoch, das, "Gefühl,", dass, ihm, der, "Job", hier, viel, "Spaß", macht, und, er, ihn, auf, keine, "Fall", verlieren, "will.",
	"\n\nDer", "Koch:", "Er", ist, 59, "Jahre", alt, und, arbeitet, schon, seit, vielen, "Jahren", "für", den, "Mann", und, seine, "Familie.",
	"\nAllerdings", ist, er, nicht, mehr, so, oft, im, "Haus,", da, er, etwas, gegen, dass, "restliche,", aus, dem, "Ausland", stammende, "Personal", "hat.",
	"\n\nDer", "Nachbar:", "Er", ist, 34, "Jahre", "alt,", nicht, verheiratet, und, wohnt, erst, seit, einem, "Jahr", "nebenan.",
	"\nIn", letzter, "Zeit", scheint, sich, die, "Mutter", "oft", mit, ihm, zu, "treffen,", weshalb, der, "Ehemann", auch, ihn, bereits, als, "mögliche", "Affäre", in, "Betracht", gezogen, "hatte.",
	"\nSeit", ein, paar, "Monaten", "häufen", sich, bei, ihm, aber, die, "Besuche", einer, anderen, "Frau,", weshalb, der, "Ehemann", diesen, "Gedanken", bereits, verworfen, "hat.",
	"\n\nDer", "Besuch:", "Er", ist, die, "große", "Unbekannte", auf, unserer, "Liste.",
	"\nEr", muss, ein, "Freund", des, "Ehemannes", gewesen, "sein -", dieser, jedoch, wollte, dazu, vor, seiner, "Frau", nichts, "sagen.",
	"\nMöglicherweise", handelt, es, sich, um, einen, "Privatdetektiv?"]
	).

output(gespraech_ende, 
	["Du", beendest, das, "Gespraech."]
	).

output(kind, 
	["Du", gehst, zu, dem, "Kind", und, beginnst, ein, "Gespraech."]
	).

output(beamter, 
	["Du", sprichst, den, "Beamten", im, "Eingangsbereich", "an.",
	"\n\n'Guten", "Tag!", "Was", "können", "Sie", mir, "über", unseren, "Fall", "erzählen?'",
	"\n'Ich", denke, "nicht,", dass, ich, mehr, "weiß", als, "Sie -", ich, bin, gerade, "dabei,", mir, die, "Informationen", "über", die, "Tatverdächtigen", "aufzuschreiben.'"]
	).

output(no, 
	["Okay,", dann, eben, "nicht."]
	).

output(no_hinweis, 
	["Einen", weiteren, "Hinweis", musst, du, dir, erst, "erarbeiten."]
	).

output(no_tipp, 
	["Ich", gebe, dir, jetzt, keinen, weiteren, "Tipp."]
	).

output(no_hilfe, 
	["Ich", habe, gerade, keine, "Lust", dir, zu, "helfen."]
	).

output(falscher_rat1,
	["Ich gebe dir keinen Rat, aber lass uns lieber etwas singen.",
	"\nDie Putzfrau ist tot, die Putzfrau ist tot, sie kann nicht mehr Putzen tralala, tralala, sie kann nicht mehr putzen tralala tralala."]
	).

output(falscher_rat2,
	["Ich gebe dir keinen Rat, aber lass uns lieber etwas singen.",
	"\nDer Mörder war wieder der Gärtner und er plant schon den nächsten Coup.",
	"\nDer Mörder ist immer der Gärtner und er schlägt erbarmungslos zu."]
	).

output(no_bitte, 
	["Ohne", "Bitte", geht, hier, "garnichts -" , "Deine", "Eltern", haben, bei, der, "Erziehung", ja, mal, voll, "versagt."]
	).

output(help, 
	["Ich", hoffe, ich, konnte, dir, "helfen."]
	).

output(nothing, 
	[]
	).

output(solved, 
	["Du", hast, den, "Fall", "gelöst,", herzlichen, "Glückwunsch!","\nBeende", das, "Programm", mit, "'bye'."]
	).

output(wrong_suspicion, ["Dieser", "Verdacht", ist, leider, "falsch,", versuche, es, "später", "nochmal!", "Du", hast, noch, Anzahl, "Verdächtigungsversuche", "übrig."]) :-
	verdaechtigungszahl(AlteAnzahl),
	Anzahl is 2 - AlteAnzahl.

output(beamter_stay, 
	["Okay,", was, wollen, sie, "wissen?"]
	).

output(geheimunbekannt,
	["Irgendwas ist an dem Gebälde merkwürdig, aber du kannst nicht herausfinden was."]
	).

output(geheimbekannt,
	["Hinter dem Gebälde versteckt sich der versteckte Eingang zum Geheimgang."]
	).


output(folgen,
	["Du folgst Alex ins Wohnzimmer, dort geht er zielstrebig zu dem Gemälde über dem Sofa. \nEr drück einen Knopf im Rahmen, der aussieht wie ein Zierstein, das Bild klappt zur Seite und legt den Eingang zu einem Geheimgang frei. \n'Geh rein, das wird dir bei dem Fall helfen, außer du gruselst dich zu arg.'"]
	).

output(geheimgewesen,
	["Du entscheidest dich dazu nicht nochmal in den Geheimgang zu gehen."]
	).