% PROLOG
% Ein-/Ausgaberahmen für Eliza-Programme


:- include('read.pl').

quaelgeist :- greeting(), read_sentence(Input), quaelgeist(Input),!.
quaelgeist([bye]) :- writeln('Goodbye. I hope I have helped you').
quaelgeist(Input) :-
  match(Input,Output), % match ist der interessante Teil!
  reply(Output),
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
	nl.