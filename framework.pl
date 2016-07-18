% PROLOG
% Ein-/Ausgaberahmen für Eliza-Programme


:- include('read.pl').
:- encoding(iso_latin_1).

quaelgeist :- greeting(), read_sentence(Input), quaelgeist(Input),!.
quaelgeist([quälgeist, beenden]) :-
	nl,
	writeln("Wollen Sie das Spiel wirklich beenden?"),
	nl,
	read_sentence(Input),
	(
		(
			member(ja, Input),
			nl,
			nl,
			writeln("Danke, dass du 'Quälgeist' gespielt hast! Hoffentlich bis bald...")
			);
		(
			nl,
			reply(["Okay, dann setzten Sie das Spiel fort."]),
			nl,
			nl,
			read_sentence(NewInput),
			quaelgeist(NewInput)
			)
		).

quaelgeist([quälgeist]) :-
	nl,
	writeln("Wollen Sie das Spiel wirklich beenden?"),
	nl,
	read_sentence(Input),
	(
		(
			member(ja, Input),
			nl,
			nl,
			writeln("Danke, dass du 'Quälgeist' gespielt hast! Hoffentlich bis bald...")
			);
		(
			nl,
			reply(["Okay, dann setzten Sie das Spiel fort."]),
			nl,
			nl,
			read_sentence(NewInput),
			quaelgeist(NewInput)
			)
		).

quaelgeist(Input) :-
  	match(Input,Output), % match ist der interessante Teil!
  	nl,
  	reply(Output),
  	nl,
  	read_sentence(Input1),!,
  	quaelgeist(Input1).

reply([Head|Tail]) :- write(user_output,Head), write(user_output,' '), reply(Tail).
reply([]) :- nl.

greeting :- 
	writeln("   .-''-.                                           .---.                                                 "),
	writeln("  //'` `\\|                            __.....__     |   |              __.....__     .--.                 "),
	writeln(" '/'    '|                        .-''         '.   |   |  .--./)  .-''         '.   |__|                 "),
	writeln("|'      '|                       /     .-''`'-.  `. |   | /.''\\\\  /     .-''`'-.  `. .--.            .|   "),
	writeln("||     /||                 __   /     /________\\   \\|   || |  | |/     /________\\   \\|  |          .' |_  "),
	writeln(" \\'. .'/||     _    _   .:--.'. |                  ||   | \\`-' / |                  ||  |     _  .'     | "),
	writeln("  `--'` ||    | '  / | / |   \\ |\\    .-------------'|   | /(´'`  \\    .-------------'|  |   .' |'--.  .-' "),
	writeln("        ||   .' | .' | `` __ | | \\    '-.____...---.|   | \\ '---. \\    '-.____...---.|  |  .   | / |  |   "),
	writeln("        || />/  | /  |  .'.''| |  `.             .' |   |  /'´`'.\\ `.             .' |__|.'.'| |// |  |   "),
	writeln("        ||//|   `'.  | / /   | |_   `''-...... -'   '---' ||     ||  `''-...... -'     .'.'.-'  /  |  '.' "),
	writeln("        |'/ '   .'|  '/\\ \\._,\\ '/                         \\'. __//                     .'   \\_.'   |   /  "),
	writeln("        |/   `-'  `--'  `--'  `´                           `'---'                                  `'-'   "),
	nl,
	nl,
	nl,
	writeln("Du wurdest in deiner Funktion als Ermittler zum Tatort gerufen. Dies ist letzte Chance dich zu beweisen -"),
	writeln("Der Chef hat dir bereits ein Ultimatum gestellt."),
	writeln("Du fährst mit dem Auto vor dem Tatort vor, ein schönes Einfamilienhaus in der Vorstadt."),
	nl,
	writeln("Als du aussteigst kommt bereits ein Streifenpolizist auf dich zu und begrüßt dich:"),
	nl,
	writeln("'Guten Morgen!'"),
	writeln("'Guten Morgen - was ist hier passiert?'"),
	writeln("'Die Putzfrau des Hauses wurde ermordet. Mehr wissen wir noch nicht - der Gerichtsmediziner hat die Leiche bereits mitgenommen um sie zu untersuchen.'"),
  	writeln("'Wo wurde sie gefunden?.'"),
  	writeln("'Im Flur - aber der Gerichtsmediziner sagt, dass die Leiche bewegt wurde, also ist der Flur nicht unser Tatort.'"),
  	writeln("'Weiß man etwas über die Tatwaffe?'"),
  	writeln("'Leider auch noch nicht, wir hoffen du bekommst das raus.'"),
	writeln("'Okay - gibt es Zeugen?'"),
	writeln("'Nicht wirklich - nur das Kind der Familie, das behauptet etwas gesehen zu haben.'"),
	writeln("'Kann ich mit dem Kind sprechen?'"),
	writeln("'Du kannst es versuchen - aber es ist schwierig sich mit dem Kind zu unterhalten. Es läuft irgendwo im Haus rum. Viel Erfolg!'"),
	writeln("'Danke...'"),
	nl,
	writeln("Du betrittst das Haus."),
	nl,
	writeln("Im Eingangsbereich steht ein weiterer Beamter und schreibt etwas in sein Notizbuch."),
	nl,
	writeln("Er steht neben einer Kommode, auf der die ganzen Schlüssel der Familie sowie die neueste Post zu liegen scheint."),
	writeln("In der Garderobe finden sich auf den ersten Blick nur einige Jacken und Schuhe, die viele Schlammspuren hinterlassen haben."),
	nl,
	writeln("Das Licht an der Decke flackert nervös."),
	nl,
	writeln("Denk dran, in diesen Fall sind verschiedene Personen verstrickt, nicht jeder hat die gleichen Infos."),
	writeln("Es kann also sein, dass eine Person eine Frage nicht beantworten kann, aber eine andere Person die Frage beantworten kann."),
	writeln("Manchmal ist es auch besser man ist in keinem Gespräch, um sich z.B. in Ruhe umzuschauen."),
	nl, 
	writeln("Du kannst jederzeit eine Verdächtigung abgeben, insgesamt hast du 3 Versuche um auf die richtige Lösung des Falls zu kommen."),
	writeln("Verdächtigungen werden im neutralen Rahmen getätigt, also wenn du gerade nicht in einem Gespräch mit einer Person bist."),
	nl.