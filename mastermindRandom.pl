:- encoding(iso_latin_1).

%ab zweiter Permutation aus verschiedenen Tail waehlen, damit nicht eine Zahl doppelt/dreifach vorkommt

code([Erste,Zweite,Dritte]) :- random_permutation(['1','2','3','4','5'],[Erste|Tail1]), 
							random_permutation(Tail1,[Zweite|Tail2]), 
							random_permutation(Tail2,[Dritte|_Tail3]).


% Testet, ob zwei Listen identisch sind
listen_vergleich([],[]). %Abbruchbedingung
listen_vergleich([Head1|Tail1],[Head2|Tail2]) :- Head1 = Head2, listen_vergleich(Tail1, Tail2).

%tipp(User3,Letztes, Counter) :- (User3 = Letztes, NewCounter is Counter+1, write("Du hast "), write(NewCounter), writeln("  Zahlen an der richtigen Stelle."));
%								(write("Du hast "), write(Counter), writeln(" Zahlen an der richtigen Stelle.")).
tipp([],[],0).

tipp([User|Userrest],[Code|Coderest], Counter) :- (User=Code, tipp(Userrest,Coderest,SubCounter), Counter is SubCounter+1);
													(tipp(Userrest,Coderest,Counter)). 



hinweis([],_Code,0).
hinweis([User|Userrest],Code, Counter) :- (member(User,Code), hinweis(Userrest,Code,SubCounter), Counter is SubCounter+1);
										(hinweis(Userrest,Code,Counter)).

check_code(Input,Code,Schritt, A, T) :- (listen_vergleich(Input,Code), writeln("Du hast den Code geknackt."),
					output_mastermind(T, A));
					%ab 6 Schritten bekommt man immer den Tipp
					(Schritt > 5, writeln("Leider immernoch falsch. Hier ein paar Tipps:"),
						hinweis(Input,Code,Counter1), write(Counter1), writeln(" von deinen Zahlen sind im Code enthalten, die anderen nicht, ich verrate aber nicht welche ätschi bätsch."),
						tipp(Input,Code,Counter2), write("Du hast "), write(Counter2), writeln(" Zahl/en an der richtigen Stelle."),
						mastermind1(Schritt, Code, A, T));
					%jedes zweite Mal bekommt man einen Tipp
					(Tipp is Schritt mod 2, Tipp = 0, writeln("Leider immernoch falsch. Hier ein paar Tipps:"),
						hinweis(Input,Code,Counter1), write(Counter1), writeln(" von deinen Zahlen sind im Code enthalten, die anderen nicht, ich verrate aber nicht welche ätschi bätsch."),
						tipp(Input,Code,Counter2), write("Du hast "), write(Counter2), writeln(" Zahl/en an der richtigen Stelle."),
						mastermind1(Schritt, Code, A, T));
					
					(writeln("Leider falsch."), mastermind1(Schritt, Code, A, T)).

					%(Schritt = 5, writeln("Leider falsch. Hier noch ein Tipp:"), writeln("Die mittlere Zahl ist außerdem noch durch 3 teilbar."), 
					%	mastermind1(Schritt, Code));
					%(Schritt = 8, writeln("Leider falsch. Mein letzter Tipp für dich:"), 
					%	writeln("Wenn du die erste und die letzte Zahl addierst, dann erhältst du die mittlere Zahl."), 
					%	mastermind1(Schritt, Code)); %dann sind nur noch diese zwei Kombis möglich: 264 und 462
					%(writeln("Leider falsch."), mastermind1(Schritt, Code)). %alle andere Zustände

mastermind(A, T) :- code(Code),
			writeln("Ich habe mir einen Code ausgedacht, er besteht aus 3 Zahlen (1-5)."),
			writeln("Jede Zahl darf nur einmal vorkommen."),
			writeln("Du errätst meinen 3-stelligen Code nie. Was ist deine Idee?"),
			read_sentence([Input|_Tail]), atom_chars(Input,InputListe),check_code(InputListe,Code, 1, A, T).
			%read(Input), check_code(Input,Code,1).

mastermind1(Schritt, Code, A, T) :- SchrittNeu is Schritt + 1, writeln("Los rate nochmal, 3-stellig ist der Code, Zahlen von 1 bis 5."), 
read_sentence([Input|_Tail]),atom_chars(Input,InputListe), check_code(InputListe,Code, SchrittNeu, A, T).
%read(Input), check_code(Input,Code, SchrittNeu).

output_mastermind(angestellter, ["Na", "schön,", hier, ein, "Tipp", zum, "Fall:", "Der", "Mörder", ist, "EIN", "Angestellter", in, unserem, "Haus."]).
output_mastermind(sonstige, ["Na", "schön,", hier, ein, "Tipp", zum, "Fall:", "Der", "Mörder", ist, "KEIN", "Angestellter", in, unserem, "Haus."]).