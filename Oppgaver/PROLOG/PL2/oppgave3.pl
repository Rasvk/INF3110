addAtEnd([], Object, [Object]).
addAtEnd([H|T], Object, [H|List]) :- addAtEnd(T, Object, List). 


reverse([], []).
reverse([X], [X]).
reverse([X|Xs], Y) :- reverse(Xs, Z), addAtEnd(Z, X, Y).