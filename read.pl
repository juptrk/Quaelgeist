% PROLOG

% alle Zeichen einlesen bis Delimiter
read_string(Delimiter,String) :- get0(C), name(Delimiter,[DelChar]), read_string(DelChar,C,String).

read_string(DelChar,DelChar,[]) :- !. %get0(10). liest Zeilenumbruchzeichen
%ignoriert .,!?
read_string(DelChar,C,RestString) :- C =:= 33, get0(Cnew), read_string(DelChar,Cnew,RestString).
read_string(DelChar,C,RestString) :- C =:= 44, get0(Cnew), read_string(DelChar,Cnew,RestString).
read_string(DelChar,C,RestString) :- C =:= 46, get0(Cnew), read_string(DelChar,Cnew,RestString).
read_string(DelChar,C,RestString) :- C =:= 63, get0(Cnew), read_string(DelChar,Cnew,RestString).
read_string(DelChar,C,[C|RestString]) :- get0(Cnew), read_string(DelChar,Cnew,RestString).

% Liste trennen in Wörter
split_string(_,[],[]).
split_string(SepChar,CharList,[Chunk|SingleLists]) :- get_chunk(SepChar,CharList,Chunk,RestCharList),
                                                      split_string(SepChar,RestCharList,SingleLists).

% einzelne Wörter erkennen
get_chunk(_,[],[],[]).
get_chunk(SepChar,[SepChar|RestCharList],[],RestCharList) :- !.
get_chunk(SepChar,[OtherChar|RestCharList],[OtherChar|RestChunk],UnusedCharList) :-
  get_chunk(SepChar,RestCharList,RestChunk,UnusedCharList).

% String-Darstellung (Zahlenlisten) in Atome umwandeln
strings_to_atoms([],[]).
strings_to_atoms([X|Xs],[Y|Ys]) :- name(Y,X), strings_to_atoms(Xs,Ys).

% alles zusammen: ganzen Satz einlesen
read_sentence(Sentence) :- read_string("\n",String), list_lower(String,Lower), split_string(32,Lower,Words), strings_to_atoms(Words,Sentence).


%wandelt Eingabe in LowerCase um 
list_lower([],[]).
list_lower([UpperHead|UpperTail],[LowerHead|LowerTail]) :- to_lower(UpperHead,LowerHead), list_lower(UpperTail,LowerTail).