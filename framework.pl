% PROLOG
% Ein-/Ausgaberahmen für Eliza-Programme


:- include('read.pl').

quaelgeist :- read_sentence(Input), quaelgeist(Input),!.
quaelgeist([bye]) :- writeln('Goodbye. I hope I have helped you').
quaelgeist(Input) :-
  match(Input,Output), % match ist der interessante Teil!
  reply(Output),
  read_sentence(Input1),!,
  quaelgeist(Input1).

reply([Head|Tail]) :- write(user_output,Head), write(user_output,' '), reply(Tail).
reply([]) :- nl.
