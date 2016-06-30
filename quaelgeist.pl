:- include('framework.pl').

%Wissensbasis
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

alle_taeter(Taeter) :- setof(T, taeter(T), Taeter).

%Mord 
tatort(wohnzimmer).
tatwaffe(seil).
moerder(nachbar).

%wenn wir es randomisieren wollen, allerdings scheint das sehr schwierig, weil man dasn die Hinweise anpassen müsste etc.
%tatort(Tatort) :- alle_orte(Orte), random_permutation(Orte,[Tatort|_Rest]).
%tatwaffe(Tatwaffe) :- alle_waffen(Waffen), random_permutation(Waffen, [Tatwaffe|_Rest]).
%moerder(Moeder) :- alle_taeter(Taeter), random_permutation(Taeter,[Moeder|_Rest]).


mord :- tatort(Ort), tatwaffe(Waffe), moerder(Moerder), 
		write('Der Taeter ist: '), writeln(Moerder), write('Der Tatort ist: '), writeln(Ort), write('Die Tatwaffe ist: '), writeln(Waffe).




match([wer, ist, das, opfer],["Die", "Putzfrau", der, "Familie."]).
match([wie, ist, die, putzfrau, gestorben],[ ]) :- mord.
match(_, ["To", close, the, program, write, "bye."]).