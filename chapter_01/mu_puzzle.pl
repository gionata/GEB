% Chapter I
% The MU-puzzle
%
% Given a formal system MIU defined on the alphabet {'m', 'i', 'u'}, an axiom 'mi' and four rules, can we produce 'mu'?
%
% Example: gprolog --consult-file mu_puzzle.pl --query-goal 'miu([m,u])'
% Try online: http://swish.swi-prolog.org/p/usGAXmHA.pl

% Accepted symbols
accepted_symbol(m).
accepted_symbol(i).
accepted_symbol(u).

% Recognize only legal strings.
legal_string([]) :- !.
legal_string([Letter|Rest]) :-
    accepted_symbol(Letter), !,
	legal_string(Rest).

% axiom: 'mi' is a valid string
miu([m,i]) :- !,
    write('Axiom'), nl.

% Rule I  : If you possess a string whose last letter is 'i', you can add on a 'u' at the end.
miu(NewString) :-
    legal_string(NewString),
    reverse(NewString,[u|ReverseString]),
    ReverseString = [i|_],
    reverse(ReverseString,String),
    miu(String),
    write('Rule I'), nl.

% Rule II : Suppose you have 'm'X. Then you may add 'm'XX to your collection.
miu(NewString) :-
    legal_string(NewString),
    NewString = [m|XX],
    even(XX),
    halve(XX, X, X),
    miu([m|X]),
    write('Rule II'), nl.

% Rule III:  If 'i','i','i' occurs in one of the strings in your collection, you may make a new
%            string with 'u' in place of 'i','i','i'.
miu(NewString) :-
    legal_string(NewString),
    replacement([u],[i,i,i],NewString,String),
    miu(String),
    write('Rule III'), nl.

% Rule IV :  If UU occurs inside one of your strings, you can drop it. 
miu(NewString) :-
    legal_string(NewString),
    replacement([u,u], [], NewString, String),
    miu(String),
    write('Rule IV'), nl.

% utility: halve
halve(List,A,B) :-
    halve(List,List,A,B), !.
halve(B,[],[],B).
halve(B,[_],[],B).
halve([H|T],[_,_|T2],[H|A],B) :-
    halve(T,T2,A,B). 

% utility: replacement. We suppose the prolog interpreter has a built in predicate phrase
replacement(A, B,  Ag, Bg) :-
    phrase((seq(S1),seq(A),seq(S2)), Ag),
    phrase((seq(S1),seq(B),seq(S2)), Bg).

seq([]) --> [].
seq([E|Es]) --> [E], seq(Es).

% utility: even number of symbols
even([]).
even([_,_|Rest]) :-
    even(Rest).
        
/** <examples>

?- miu([m,i]).
?- miu([m,i,u]).
?- miu([m,i,u,i,u]).
?- miu([m,i,u,i,u,i,u,i,u]).
?- miu([m,i,i]).
?- miu([m,i,i,u]).
?- miu([m,i,i,u,i,i,u]).
?- miu([m,i,i,i,i]).
?- miu([m,i,i,i,i,u]).
?- miu([m,i,i,i,i,i,i,i,i]).
?- miu([m,u,i]).
?- miu([m,u]).

*/