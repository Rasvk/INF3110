% 		append(Xs, Ys, Zs, Rs).
% eg.	append([1, 2], [a, b], [3, 4], Rs).
%		Rs = [1, 2, a, b, 3, 4].

append3([], [], Zs, Zs).
append3([], [Y|Ys], Zs, [Y|Rs]) :- append3([], Ys, Zs, Rs).
append3([X|Xs], Ys, Zs, [X|Rs]) :- append3(Xs, Ys, Zs, Rs).

% 		sublist(Xs, Ys).
% eg. 	sublist([a, b], [1, 2, a, b, 3]).
%		yes
%
%		sublist(Xs, [a, b]).
%		Xs = [a, b] ;
%		Xs = [b]	;
%		Xs = [] 	;
%		Xs = [a]	;
%		false.

sublist(Xs, Ys) :- append3(_, Xs, _, Ys).

% rules:
%		rewrite(To, From).
%		rewrite([a, b], [b, a]).
%		rewrite([c, c], [c]).

%		onestep(Xs, Ys).
% eg. 	onestep([a, b, c, c, b, a], Ys).
%		Ys = [b, a, c, c, b, a] ; first rule
%		Ys = [a, b, c, b, a]    ; second rule

rewrite([a, b], [b, a]).
rewrite([c, c], [c]).

onestep(Xs, Ys) :- 	rewrite(A, B),
					append3(X, A, Y, Xs),
					append3(X, B, Y, Ys).

% applies onestep recursively

manystep(Xs, Xs).
manystep(Xs, Ys) :- onestep(Xs, Zs), manystep(Zs, Ys).

normalform(Xs, Ys) :- manystep(Xs, Ys), \+onestep(Ys, _Zs).