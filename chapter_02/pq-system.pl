% Chapter II
% The pq-system 
%
% A formal system pq defined on the alphabet {'p', 'q', '-'},
% a scheme of axioms 'Xp-qX-' and a rule 
%
% Example: gprolog --consult-file pq-system.pl --query-goal 'pq([-,p,-,-,-,q,-,-,-,-])'
% Try online: http://swish.swi-prolog.org/p/EMbUDnvE.pl

% Accepted symbols
hyphens([]).
hyphens([-|Rest]) :-
    hyphens(Rest).

accepted_symbol(p).
accepted_symbol(q).
accepted_symbol(-).

% Recognize only legal strings.
legal_string([]).
legal_string([Letter|Rest]) :-
	accepted_symbol(Letter), !,
	legal_string(Rest).

% Axioms:  Xp-qX- is an axiom, whenever X is composed of hyphens only.
pq(String) :-
    phrase((seq(X),seq([p,-,q]),seq(X),seq([-])), String),
    hyphens(X),
    write('Axiom'), nl, !.

% Rule: Suppose X, Y, and Z all stand for particular strings containing only hyphens.
% 		And suppose that XpYqZ is known to be a theorem. The XpY-qZ- is a theorem.
pq(NewString) :-
    phrase((seq(X),seq([p]),seq(Y),seq([-,q]),seq(Z),seq([-])), NewString),
    hyphens(X), hyphens(Y), hyphens(Z),
    phrase((seq(X),seq([p]),seq(Y),seq([q]),seq(Z)), String),
    pq(String),
    write('Rule'), nl, !.


% utility: seq.
seq([]) --> [].
seq([E|Es]) --> [E], seq(Es).

/** <examples>
?- pq([-,p,-,q,-,-]).
?- pq([-,-,p,-,q,-,-,-]).
?- pq([-,-,-,p,-,q,-,-,-,-]).
?- pq([-,p,-,-,-,q,-,-,-,-]).
?- pq([-,p,-,-,-,q,-,-,-,-]).
?- pq([-,-,-,-,-,-,-,-,-,-,p,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,q,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-]).
*/