% Chapter III
% The tq-system 
%
% A formal system tq defined on the alphabet {'t', 'q', '-'},
% a scheme of axioms 'Xt-qX' and a rule 'XtYqZ'->'XtY-qZX'
%
% Example: gprolog --consult-file pq-system.pl --query-goal 'tq([-,-,-,-,t,-,-,-,-,-,q,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-])'
%
% Try online: http://swish.swi-prolog.org/p/qnnMTlML.pl

% Accepted symbols
hyphens([]).
hyphens([-|Rest]) :-
    hyphens(Rest).

accepted_symbol(t).
accepted_symbol(q).
accepted_symbol(-).

% Recognize only legal strings.
legal_string([]).
legal_string([Letter|Rest]) :-
	accepted_symbol(Letter), !,
	legal_string(Rest).

% Axioms:  Xt-qX is an axiom, whenever X is composed of hyphens only.
tq(String) :-
    phrase((seq(X),seq([t,-,q]),seq(X)), String),
    hyphens(X),
    write('Axiom'), nl, !.

% Rule: Suppose X, Y, and Z all stand for particular strings containing only hyphens.
% 		And suppose that XtYqZ is known to be a theorem. The XtY-qZX is a theorem.
tq(NewString) :-
    phrase((seq(X),seq([t]),seq(Y),seq([-,q]),seq(Z),seq(X)), NewString),
    hyphens(X), hyphens(Y), hyphens(Z),
    phrase((seq(X),seq([t]),seq(Y),seq([q]),seq(Z)), String),
    tq(String),
    write('Rule'), nl, !.

% utility: seq.
seq([]) --> [].
seq([E|Es]) --> [E], seq(Es).

/** <examples>
?- tq([-,t,-,q,-]).
?- tq([-,-,-,-,-,t,-,q,-,-,-,-,-]).
?- tq([-,t,-,-,-,-,-,q,-,-,-,-,-]).
?- tq([-,-,t,-,-,-,q,-,-,-,-,-,-]).
?- tq([-,-,-,-,t,-,-,-,-,-,q,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-]).
*/
