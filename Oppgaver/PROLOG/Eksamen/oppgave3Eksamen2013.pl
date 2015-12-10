% 		toList(X, Y).
% eg.   toList(node(leaf(1), 4, node(leaf(5), 6, leaf7)), Y).
%		Y = [1, 4, 5, 6, 7].

toList(leaf(X), [X]).
toList(node(L, H, R), List) :- toList(L, L1), toList(R, L2), append(L1, [H|L2], List).

%		del(X, XS, Y).
% eg.	del(2, [3, 2, 1, 2, 3], Y).
%		Y = [3, 1, 2, 3].
%		Y = [3, 2, 1, 3].

del(X, [X|XS], XS).
del(X, [Y|XS], [Y|YS]) :- del(X, XS, YS).

% 		delN(XS, Num, ZS).
% eg.	delN(['fee', 'foe', 'fum'], 2, ZS).
%		ZS = ['fee', 'fum'].

delN(XS, 0, XS).
delN([], _, []).
delN([_X|XS], 1, XS).
delN([X|XS], N, [X|YS]) :- N > 1, M is N-1, delN(XS, M, YS).