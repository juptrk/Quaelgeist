% PROLOG
% Ein-/Ausgaberahmen für Eliza-Programme


:- include('read.pl').

quaelgeist :- greeting(), read_sentence(Input), quaelgeist(Input),!.
quaelgeist([bye]) :- writeln("Danke, dass du 'Quälgeist' gespielt hast! Hoffentlich bis bald...").
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
  	writeln("'Im Flur, aber der Gerichtsmediziner sagt, dass die Leiche bewegt wurde, also ist der Flur nicht unser Tatort.'"),
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
	nl.