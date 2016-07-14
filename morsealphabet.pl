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

% dann muss man Kind folgen, dieses führt einen in Geheimgang, dort ligt Tatwaffe

bef --> befehl1.
bef --> befehl2.
befehl1 --> verbpro, pro. %verb und pronomen
befehl2 --> verbprae, praepro.
praepro --> prae, pro, prae.
praepro --> prae, pro.
praepro --> prae. %praeposition

verbpro --> f,o,l,g,e.
verbprae --> k,o,m,m,e.

pro --> m,i,r.
prae --> m,i,t.


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
				

welcherBefehl(B,Nummer) :- 
				((B=["..-.", "---", ".-..", "--.", ".", "--", "..", ".-."], Nummer is 1);
				(B=["-.-", "---", "--", "--", ".", "--", "..", "-"], Nummer is 2);
				(B=["-.-", "---", "--", "--", ".", "--", "..", "-", "--", "..", ".-."], Nummer is 3);
				(B=["-.-", "---", "--", "--", ".", "--", "..", "-", "--", "..", ".-.", "--", "..", "-"], Nummer is 4)). %B ist der Befehl
	
check_morse_uebersetzung(Input,Nummer,A):- 
								(Nummer = 1, Input = [folge, mir], writeln("Super, du hast den Satz richtig übersetzt."), output_morsen(A));
								(Nummer = 2, Input = [komme, mit], writeln("Super, du hast den Satz richtig übersetzt."), output_morsen(A));
								(Nummer = 3, Input = [komme, mit, mir], writeln("Super, du hast den Satz richtig übersetzt."), output_morsen(A));
								(Nummer = 4, Input = [komme, mit, mir, mit], writeln("Super, du hast den Satz richtig übersetzt."), output_morsen(A));
								(writeln("Leider falsch übersetzt. Versuch es nocheinmal."), morsen1(Nummer,A)).

morsen(A) :-  setof(X,bef(X,[]),Befehlliste), random_permutation(Befehlliste,[B|_Restpermut]), welcherBefehl(B,Nummer),
			nl,
			writeln("Ich morse dir den nächsten Hinweis, du muss ihn nurnoch übersetzen."),
			writeln("Hier ist noch das Morsealphabet, damit du es nciht ganz so schwer hast:"),
			morsealphabet,
			write("Und hier ist der Satz: "), writeln(B),
			writeln("Jetzt kannst du loslegen, den Hinweis zu entschlüsseln. Deine Lösung:"),
			read_sentence(Input), 
			check_morse_uebersetzung(Input,Nummer,A).

morsen1(Nummer,A) :- writeln("Deine Lösung:"),
			read_sentence(Input), 
			check_morse_uebersetzung(Input,Nummer,A).


output_morsen(["Also,", dann, folge, mir, "mal,", ich, zeige, dir, "was.", "Das", wird, dich, von, den, "Socken", "hauen."]).