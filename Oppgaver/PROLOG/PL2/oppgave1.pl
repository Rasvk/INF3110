p(anne, aase, aale, 1960).
p(arne, aase, aale, 1962).
p(beate, anne, lars, 1989).
p(bjorn, lise, arne, 1990).

child(X, Y) :- p(X, _, Y, _).
child(X, Y) :- p(X, Y, _, _).

grandchild(X, Y) :- child(X, Z), child(Z, Y).

common_descendants(X, Y) :- child(Z, X), child(Z, Y).
common_descendants(X, Y) :- grandchild(Z, X), grandchild(Z, Y).
common_descendants(X, Y) :- child(Z1, X), child(Z2, Y), common_descendants(Z1, Z2).

sibling(X, Y) :- child(X, Z), child(Y, Z), X \== Y.

only_child(X) :- p(X, _, _, _), \+sibling(X, Anyone).