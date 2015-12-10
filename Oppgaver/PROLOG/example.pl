person(anne, sofia, martin, 1960).
person(john, sofia, george, 1965).
person(paul, sofia, martin, 1962).
person(maria, anne, mike, 1989).

child(X,Y) :- person(X,Z,Y,U).
child(X,Y) :- person(X,Y,Z,U).
siblings(X,Y) :- child(X,Z), child(Y,Z), X \== Y.