
%:- include('read.pl').
:- encoding(iso_latin_1).

morsealphabet :- 
				nl,
				writeln("A   -->   .-"),
				writeln("B   -->   -..."),
				writeln("C   -->   -.-."),
				writeln("D   -->   -.."),
				writeln("E   -->   ."),
				writeln("F   -->   ..-."),
				writeln("G   -->   --."),
				writeln("H   -->   ...."),
				writeln("I   -->   .."),
				writeln("J   -->   .---"),
				writeln("K   -->   -.-"),
				writeln("L   -->   .-.."),
				writeln("M   -->   --"),
				writeln("N   -->   -."),
				writeln("O   -->   ---"),
				writeln("P   -->   .--."),
				writeln("Q   -->   --.-"),
				writeln("R   -->   .-."),
				writeln("S   -->   ..."),
				writeln("T   -->   -"),
				writeln("U   -->   ..-"),
				writeln("V   -->   ...-"),
				writeln("W   -->   .--"),
				writeln("X   -->   -..-"),
				writeln("Y   -->   -.--"),
				writeln("Z   -->   --.."),
				nl.


loesungWorte("Folge mir").
loesungMorse("..-. --- .-.. --. .  -- .. .-.").


% dann muss man Kind folgen, dieses führt einen in Geheimgang, dort ligt Tatwaffe


%liste random eins auswählen und dann in dynamische liste mit rein und so darauf zugreifen
befehl1 --> verbpro, leer, pro. %verb und pronomen
befehl2 --> verbprae, leer, prae. %verb und praeposition


verbpro --> f,o,l,g,e.
verbprae --> k,o,m,m,e.

pro --> m,i,r.
prae --> m,i,t.

leer --> ["  "].


a   -->   [".-"].
b   -->   ["-..."].
c   -->   ["-.-."].
d   -->   ["-.."].
e   -->   ["."].
f   -->   ["..-."].
g   -->   ["--."].
h   -->   ["...."].
i   -->   [".."].
j   -->   [".---"].
k   -->   ["-.-"].
l   -->   [".-.."].
m   -->   ["--"].
n	-->   ["-."].			
o   -->   ["---"].
p	-->   [".--."].			
q   -->   ["--.-"].
r   -->   [".-."].
s	-->   ["..."].			
t   -->   ["-"].
u   -->   ["..-"].
v   -->   ["...-"].
w   -->   [".--"].
x   -->   ["-..-"].
y   -->   ["-.--"].
z   -->   ["--.."].
				
	
%dynamisches Praedikat: 
:- retractall(loesung(_)). %brauche ich das hier?
:- dynamic loesung/1.
loesung(0).	

%uebersetzung von befehl nch dynamisch merken			
befehl(Befehl) :- befehl1(A,[]), befehl2(B,[]), random_permutation([A,B],[Befehl|_Restpermut]), 
				((befehl1(Befehl,[]), retract(loesung(_Old)), assertz(loesung(1)));(befehl2(Befehl,[]), retract(loesung(_Old)), assertz(loesung(2)))).
	
check_morse_uebersetzung(Input) :- retract(loesung(Befehlnummer)),
								(Befehlnummer = 1, Input = "folge mir", writeln("Super, du hast den Satz richtig übersetzt."));
								(Befehlnummer = 2, Input = "komme mit", writeln("Super, du hast den Satz richtig übersetzt."));
								(writeln("Leider falsch übersetzt. Versuch es nocheinmal."), morsen1).

morsen :- befehl(B), 
			nl,
			writeln("Ich morse dir den nächsten Hinweis, du muss ihn nurnoch übersetzen."),
			writeln("Hier ist noch das Morsealphabet, damit du es nciht ganz so schwer hast:"),
			morsealphabet,
			write("Und hier ist der Satz: "), writeln(B),
			writeln("Jetzt kannst du loslegen, den Hinweis zu entschlüsseln. Deine Lösung:"),
			read_sentence(Input), 
			check_morse_uebersetzung(Input).

morsen1 :- writeln("Deine Lösung:"),
			read(Input), 
			check_morse_uebersetzung(Input).








%befehl ausgeben und user uebersetzung eingeben lassen , diese mit dynamsciher vergleichen
%retract(loseung(X)), X=1, Input=["folge"," ","mir"].