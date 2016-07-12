
:- include('read.pl').
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


% dann muss man Kind folgen, dieses f�hrt einen in Geheimgang, dort ligt Tatwaffe


%liste random eins ausw�hlen und dann in dynamische liste mit rein und so darauf zugreifen
befehl1 --> verbpro, pro. %verb und pronomen
befehl2 --> verbprae, prae. %verb und praeposition


verbpro --> f,o,l,g,e.
verbprae --> k,o,m,m,e.

pro --> m,i,r.
prae --> m,i,t.

%leer --> ["  "].


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
				
	



befehl(Befehl,Nummer) :- befehl1(A,[]), befehl2(B,[]), random_permutation([A,B],[Befehl|_Restpermut]), 
				((befehl1(Befehl,[]), Nummer is 1);(befehl2(Befehl,[]), Nummer is 2)).
	
check_morse_uebersetzung(Input,Nummer):- 
								(Nummer = 1, Input = [folge, mir], writeln("Super, du hast den Satz richtig �bersetzt."));
								(Nummer = 2, Input = [komme, mit], writeln("Super, du hast den Satz richtig �bersetzt."));
								(writeln("Leider falsch �bersetzt. Versuch es nocheinmal."), morsen1(Nummer)).

morsen :- befehl(B,Nummer), 
			writeln(B),
			writeln(Nummer),
			nl,
			writeln("Ich morse dir den n�chsten Hinweis, du muss ihn nurnoch �bersetzen."),
			writeln("Hier ist noch das Morsealphabet, damit du es nciht ganz so schwer hast:"),
			morsealphabet,
			write("Und hier ist der Satz: "), writeln(B),
			writeln("Jetzt kannst du loslegen, den Hinweis zu entschl�sseln. Deine L�sung:"),
			read_sentence(Input), 
			check_morse_uebersetzung(Input,Nummer).

morsen1(Nummer) :- writeln("Deine L�sung:"),
			read_sentence(Input), 
			check_morse_uebersetzung(Input,Nummer).








%befehl ausgeben und user uebersetzung eingeben lassen , diese mit dynamsciher vergleichen
%retract(loseung(X)), X=1, Input=["folge"," ","mir"].