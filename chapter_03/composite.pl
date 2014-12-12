% Chapter III
% Composite  numbers 
%
% Try online: http://swish.swi-prolog.org/p/FsdhKmBM.pl
% 

% Composite number, recognizer
c(Z) :-
    nonvar(Z),
    % check
    hyphens(Z),
    length(Z, LZ),
    Z2 is LZ >> 1 - 1,
    % generate
    hyphens_leq(X, Z2),
    hyphens_leq(Y, Z2),
    % trial
    % apply the definition
    phrase((seq(X),seq([-,t]),seq(Y),seq([-,q]),seq(Z)), String),
    tq(String),
    write(String), nl.

% Composite number, generator
c(Z) :-
    var(Z),
    % generate
    hyphens(X),
    hyphens(Y),
    length(X, LX),
    length(Y, LY),
    LZ is (LX + 1) * (LY + 1),
    hyphens_leq(Z, LZ),
    % apply the definition
    phrase((seq(X),seq([-,t]),seq(Y),seq([-,q]),seq(Z)), String),
    tq(String),
    write(String), nl.


% Accepted symbols
hyphens([-]).
hyphens([-|Rest]) :-
    hyphens(Rest).


hyphens_leq(_, 0) :-
    !,
    fail.
hyphens_leq([-], Remaining) :-
    Remaining > 0.
hyphens_leq([-|Rest], Remaining) :-
    M is Remaining - 1,
    hyphens_leq(Rest, M).

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
    hyphens(X).

% Rule: Suppose X, Y, and Z all stand for particular strings containing only hyphens.
% 		And suppose that XtYqZ is known to be a theorem. The XtY-qZX is a theorem.
tq(NewString) :-
    phrase((seq(X),seq([t]),seq(Y),seq([-,q]),seq(Z),seq(X)), NewString),
    hyphens(X), hyphens(Y), hyphens(Z),
    phrase((seq(X),seq([t]),seq(Y),seq([q]),seq(Z)), String),
    tq(String).

% utility: seq.
seq([]) --> [].
seq([E|Es]) --> [E], seq(Es).

/** <examples>
?- c([-]).
?- c([-,-]).
?- c([-,-,-]).
?- c([-,-,-,-]).
?- c([-,-,-,-,-,-,-,-,-,-,-]).
*/

