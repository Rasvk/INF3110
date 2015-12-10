
%		sameHead(Xs, Ys).
% 
% eg. 	sameHead([1, 2, 3], [1, 4, 5]).
% 		yes
%
%		sameHead([X, 1], [2, 3]).
%		X = 2
%
%		sameHead([1, 2], [3, 4]).
%		no

sameHead([X|_Xs], [X|_Ys]).

%		zip(Xs, Ys, Zs).
%
% eg.	zip([1, 2, 3], [a, b, c], [1, a, 2, b, 3, c]).
%		yes
%
%		zip([1], [a, b], [1, a, b]).
%		no

zip([], [], []).
zip([X|Xs], [Y|Ys], [X,Y|Zs]) :- zip(Xs, Ys, Zs).

%		stutter(Xs).
% eg. 	stutter([a, a, b, b]).
%		yes
%
%		stutter([1, 1, 1, 1, 1, 1]).
%		yes
%		
%		stutter([1, a, a, 1]).
%		no

% stutter([]).
% stutter([X,Y|List]) :- X == Y, stutter(List).

% stutter([]).
% stutter([X,Y|List]) :- zip([X], [Y], [X,X]), stutter(List).

stutter(XS) :- zip(X, X, XS).