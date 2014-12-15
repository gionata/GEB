% Chapter III
% Prime numbers
%
% Try online: http://swish.swi-prolog.org/p/pWugAhzf.pl
% 

% Do not divide
% Axiom schema XY dnd X where X and Y are hyphen-strings.
% A number can not be divided by a greater number
dnd(String) :-
    phrase((seq(X),seq(Y),seq([dnd]),seq(X)), String),
    hyphens(X),
    hyphens(Y).

% Rule: If X dnd Y is a theorem, then so is X dnd XY.
% y mod x is equal to (x+y) mod x
dnd(NewString) :-
    phrase((seq(X),seq([dnd]),seq(X),seq(Y)), NewString),
    phrase((seq(X),seq([dnd]),seq(Y)), String),
    dnd(String).

% Divisor free... up to...
% Rule I : If -- dnd Z is a theorem, so is Z df --.
df(NewString) :-
    phrase((seq(Z),seq([df]),seq([-,-])), NewString),
    phrase((seq([-,-]),seq([dnd]),(seq(Z))), String),
    dnd(String).
    
% Rule II: If Z df X is a theorem and also X- dnd Z is a theorem, Z df X- is a theorem.
df(NewString) :-
    phrase((seq(Z),seq([df]),seq(X), [-]), NewString),
    phrase((seq(Z),seq([df]),seq(X)), FirstTheorem),
    df(FirstTheorem),
    phrase((seq(Z),seq([dnd]),seq(X),[-]), SecondTheorem),
    dnd(SecondTheorem).

% Prime numbers
% Axiom: 2 is prime: p--
p([p,-,-]).

% Rule: If Z- df Z is a theorem, then pZ- is a theorem.
p([p,-|Z]) :-
    phrase((seq(Z),seq([-]),seq([df]),seq(Z)), NewString),
    df(NewString).

% Strings of hyphens
hyphens([-]).
hyphens([-|Rest]) :-
    hyphens(Rest).


% utility: seq.
seq([]) --> [].
seq([E|Es]) --> [E], seq(Es).

/** <examples>
?- dnd([-,-,-,-,-,dnd,-,-]). % 5 dnd 2, X=2, Y=3, XY=5
?- dnd([-,-,dnd,-]).         % 2 dnd 1, X=1, Y=1, XY=2
?- dnd([-,-,-,-,-,dnd,-,-,-,-,-,-,-,-,-,-,-,-]).  % 5 dnd 12


?- df([-,-,-,df,-,-]). % 3 is not divided by 2
?- df([-,-,-,-,-,df,-,-,-,-]). % 5 is not divided by 2, 3 and 4
?- df([-,-,-,-,-,-,-,df,-,-,-,-,-,-]). % 7 is not divided by 2, 3, 4, 5, 6
?- df([-,-,-,-,-,-,-,-,df,-,-,-,-,-,-]). % 8 is not divided by 2, 3, 4, 5, 6, 7 (false!)

?- p([p,-,-]). 
?- p([p,-,-,-]).
?- p([p,-,-,-,-,-]).
?- p([p,-,-,-,-]).
*/
