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
    % generate the multipliers
    hyphens(X),
    hyphens(Y),
    length(X, LX),
    length(Y, LY),
    LZ is (LX + 1) * (LY + 1),
    % generate only string having a reasonable number of hyphens, unless the interpreter can't manage the code
    hyphens_eq(Z, LZ),
    % apply the definition
    phrase((seq(X),seq([-,t]),seq(Y),seq([-,q]),seq(Z)), String),
    tq(String),
    write(String), nl.

% Strings of hyphens
hyphens([-]).
hyphens([-|Rest]) :-
    hyphens(Rest).

% Generate a string of, at most, Remaining hyphens
hyphens_leq(_, Remaining) :-
    Remaining =< 0,
    !,
    fail.
hyphens_leq([-], Remaining) :-
    Remaining > 0.
hyphens_leq([-|Rest], Remaining) :-
    M is Remaining - 1,
    hyphens_leq(Rest, M).

% Generate a string of Remaining hyphens
hyphens_eq([-], 1) :- !.
hyphens_eq(X, Remaining) :-
    X = [-|Rest],
    M is Remaining - 1,
    hyphens_eq(Rest, M).

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
?- c(X).
*/

