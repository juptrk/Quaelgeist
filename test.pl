bef --> befehl1.
bef --> befehl2.
befehl1 --> verbpro, pro. %verb und pronomen
befehl2 --> verbprae, praepro.
praepro --> prae, pro, prae.
praepro --> prae, pro.
praepro --> prae.

%%%%%%%%



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

welcherBefehl(B) :- 
				((B=["..-.", "---", ".-..", "--.", ".", "--", "..", ".-."], Nummer is 1);
				(B=["-.-", "---", "--", "--", ".", "--", "..", "-"], Nummer is 2);
				(B=["-.-", "---", "--", "--", ".", "--", "..", "-", "--", "..", ".-."], Nummer is 3);
				(B=["-.-", "---", "--", "--", ".", "--", "..", "-", "--", "..", ".-.", "--", "..", "-"], Nummer is 4)),
				out(Nummer). %B ist der Befehlt

out(Nummer):- write("Es war Befehl:"), write(Nummer).
getBefehl:- bef(B,[]), welcherBefehl(B).