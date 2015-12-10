natural_number(0).
natural_number(s(X)) :- natural_number(X).

plus(0, N, N).
plus(s(X), N, s(XPlusN)) :- plus(X, N, XPlusN).

mul(0, Y, 0).
mul(s(X), Y, Z) :- mul(X, Y, XY), plus(XY, Y, Z).

greater_than(s(_), 0).
greater_than(s(X), s(Y)) :- greater_than(X, Y).