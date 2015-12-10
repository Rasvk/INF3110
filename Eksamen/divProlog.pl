%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Random representation of facts: %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% the population of norway is 4,5 million
population(norway, 4500000).
% norway is a rich country
rich(norway).
% 2 is a prime number
is_prime(2).
% someone wrote hamlet
wrote(someone, hamlet).
% all humans are mortal
mortal(X) :- human(X).
% all rich people pay taxes
pays_taxes(X) :- rich(X).
% ivar takes his umbrella if it rains
takes_umbrella(ivar) :- rains.
% Firebrigade employees are men over six feet tall.
firebrigade_employee(X) :- man(X), over_six_feet(X).

% italian food
italian(pizza).
italian(spaghetti).
% indian food
indian(tandoori).
indian(tikkaMasala).
indian(curry).
% mild food
mild(tandoori).
% ola likes italian food and mild indian food
likes(ola, X) :- italian(X).
likes(ola, X) :- indian(X), mild(X).
% nationality(Person, From).
nationality(ola, nor).
nationality(eyvind, nor).
nationality(rupinder, ind).
nationality(raji, ind).
% Norwegians like italian and mild indian food
likes(X, Y) :- nationality(X, nor), italian(Y).
likes(X, Y) :- nationality(X, nor), indian(Y), mild(Y).
% Indians like indian food
likes(X, Y) :- nationality(X, ind), indian(Y).

% star(Star).
star(sun).
star(vega).
star(sirius).
% orbits(Orbits, Element).
orbits(mercury, sun). 
orbits(venus, sun).
orbits(earth, sun). 
orbits(mars, sun). 
orbits(moon, earth). 
orbits(deimos, mars).
% Elements that orbit the sun are planets
planet(B) :- orbits(B, sun).
% Elements that orbit planets are satellites
satellite(B) :- orbits(B, A), planet(A).
% the sun, planets and satellites are part of solar
solar(sun).
solar(X) :- planet(X).
solar(X) :- satellite(X).

% reindeerLine(From, To).
reindeerLine(northpole,oslo). 
reindeerLine(oslo,london). 
reindeerLine(oslo,copenhagen). 
reindeerLine(copenhagen,berlin). 
reindeerLine(northpole,stockholm). 
reindeerLine(stockholm,moscow). 
% connections of reindeerLines
connection(X, Y) :- reindeerLine(X, Z), reindeerLine(Z, Y).
connection(X, Y) :- reindeerLine(X, Z), connection(Z, Y).
% direct connections of reindeerLines
direct_connection(X, Y) :- reindeerLine(X, Z), reindeerLine(Z, Y).

% p(Child, Mother, Father, Birthday).
p(anne, aase, aale, 1960).
p(arne, aase, aale, 1962).
p(beate, anne, lars, 1989).
p(bjorn, lise, arne, 1990).
child(X, Y) :- p(X, _, Y, _).
child(X, Y) :- p(X, Y, _, _).
% grandchild
grandchild(X, Y) :- child(X, Z), child(Z, Y).
% common descendants
common_descendants(X, Y) :- child(Z, X), child(Z, Y).
common_descendants(X, Y) :- grandchild(Z, X), grandchild(Z, Y).
common_descendants(X, Y) :- child(Z1, X), child(Z2, Y), common_descendants(Z1, Z2).
% siblings
sibling(X, Y) :- child(X, Z), child(Y, Z), X \== Y.
% no siblings
only_child(X) :- p(X, _, _, _), \+sibling(X, Anyone).

% boss(Boss, Employee).
boss(eva, anne).
boss(eva, atle).
boss(lars, eva).
% X is superior to Y
sup(X, Y) :- boss(X, Y).
sup(X, Y) :- boss(X, Z), sup(Z, Y).
% X has multiple bosses
multipleBosses(X) :- boss(B1, X), boss(B2, X), B1 \== B2.
% X is not its own boss, X does not have more than one boss
ok(X) :- \+boss(X, X), \+multipleBosses(X).

% local storage (Index, Item).
ls(1, ole).
ls(2, dole).
ls(3, ole).
% remote storage (Index, Item).
rs(1, ole).
rs(2, dole).
rs(3, doffen).
rs(5, dolly).
% find Item(X) at index(I), search local storage first
find(I, X) :- ls(I, X); rs(I, X).
% Item at Index(I) is different in local/remote
error(I) :- ls(I, Res1), rs(I, Res2), Res1 \== Res2.
% Item(X) is stored at two different indexes
multi(X) :- ls(I1, X), ls(I2, X), I1 \== I2.
multi(X) :- rs(I1, X), rs(I2, X), I1 \== I2.
multi(X) :- ls(I1, X), rs(I2, X), I1 \== I2.

%%%%%%%%%%%%%%%%%%%%%%%
% More advanced facts %
%%%%%%%%%%%%%%%%%%%%%%%

% empty(Xs).
% True if Xs is empty
empty([]).

% one_element_list(Xs).
% True if Xs only has one element
one_element_list([_]).

% min_two_element_list(Xs).
% True if Xs has at least two elements
min_two_element_list([_,_|_]).

% is_sorted(Xs).
% True if Xs is sorted
%
% eg. 	is_sorted([1, 2, 3, 4]).
%		yes
%		is_sorted([2, 1, 4, 3]).
%		no
is_sorted([]).
is_sorted([_]).
is_sorted([X,Y|Z]) :- X =< Y, is_sorted([Y|Z]). 

% split(Xs, Ys, Zs).
% True if Ys and Zs zipped is Xs
%
% eg. 	split([1, 2, 3, 4], [1, 3], [2, 4]).
%		yes
%		split([1, 5, 10, 20], Ys, Zs).
%		Ys = [1, 10].
%		Zs = [5, 20].
split([], [], []).
split([X], [X], []).
split([X,Y|Xs], [X|Ys], [Y|Zs]) :- split(Xs, Ys, Zs). 

% merge(Xs, Ys, Zs).
% True if Xs and Ys merged equals Zs
%
% eg. 	merge([1, 5, 8], [2, 3, 4, 9], Zs).
%		Zs = [1, 2, 3, 4, 5, 8, 9].
merge([], Ys, Ys).
merge(Xs, [], Xs).
merge([X|Xs], [Y|Ys], [X|Zs]) :- X =< Y, merge(Xs, [Y|Ys], Zs). 
merge([X|Xs], [Y|Ys], [Y|Zs]) :- Y 	< X, merge([X|Xs], Ys, Zs). 

% mergesort(Xs, Ys).
% True if Ys is Xs sorted by mergesort
%
% eg. 	mergesort([1, 5, 3, 10, 9, 8], Ys).
%		Ys = [1, 3, 5, 8, 9, 10].
mergesort(Xs, []) :- empty(Xs).
mergesort(Xs, Xs) :- one_element_list(Xs).
mergesort(Xs, Res) :- 	min_two_element_list(Xs), 
						split(Xs, Ys, Zs),
						mergesort(Ys, Res1),
						mergesort(Zs, Res2),
						merge(Res1, Res2, Res).

% sameHead(Xs, Ys).
% True if first element of Xs and Ys are the same
%
% eg. 	sameHead([1, 2, 3], [1, 4, 5]).
% 		yes
%		sameHead([X, 1], [2, 3]).
%		X = 2
%		sameHead([1, 2], [3, 4]).
%		no
sameHead([X|_Xs], [X|_Ys]).

% zip(Xs, Ys, Zs).
% True if Zs is composed of alternating elements
% from Xs and Ys from the head
%
% eg.	zip([1, 2, 3], [a, b, c], [1, a, 2, b, 3, c]).
%		yes
%		zip([1], [a, b], [1, a, b]).
%		no
zip([], [], []).
zip([X|Xs], [Y|Ys], [X,Y|Zs]) :- zip(Xs, Ys, Zs).

% stutter(Xs).
% 
% eg. 	stutter([a, a, b, b]).
%		yes
%%		stutter([1, 1, 1, 1, 1, 1]).
%		yes
%		stutter([1, a, a, 1]).
%		no
stutter(XS) :- zip(X, X, XS).

% append3(Xs, Ys, Zs, Rs).
% True if Rs is a concatenated list of Xs, Ys and Zs
% 
% eg.	append([1, 2], [a, b], [3, 4], Rs).
%		Rs = [1, 2, a, b, 3, 4].
append3([], [], Zs, Zs).
append3([], [Y|Ys], Zs, [Y|Rs]) :- append3([], Ys, Zs, Rs).
append3([X|Xs], Ys, Zs, [X|Rs]) :- append3(Xs, Ys, Zs, Rs).

% sublist(Xs, Ys).
% True if Xs is a sublist of Ys
%
% eg. 	sublist([a, b], [1, 2, a, b, 3]).
%		yes
%		sublist(Xs, [a, b]).
%		Xs = [a, b] ;
%		Xs = [b]	;
%		Xs = [] 	;
%		Xs = [a]	;
%		false.
sublist(Xs, Ys) :- append3(_, Xs, _, Ys).

% onestep(Xs, Ys).
% True if Ys is Xs with one rewrite rules applied
%
% eg. 	onestep([a, b, c, c, b, a], Ys).
%		Ys = [b, a, c, c, b, a] ; first rule
%		Ys = [a, b, c, b, a]    ; second rule
rewrite([a, b], [b, a]).
rewrite([c, c], [c]).

onestep(Xs, Ys) :- 	rewrite(A, B),
					append3(X, A, Y, Xs),
					append3(X, B, Y, Ys).

% manystep(Xs, Ys).
% True if Ys is Xs with one or more rewrite rules applied
manystep(Xs, Xs).
manystep(Xs, Ys) :- onestep(Xs, Zs), manystep(Zs, Ys).

% normalform(Xs, Ys).
% True if Ys is Xs with all possible rewrite rules applied
normalform(Xs, Ys) :- manystep(Xs, Ys), \+onestep(Ys, _Zs).

% toList(Xt, Ys).
% True if Ys is the tree Xt represented as a list
%
% eg.	toList(node(leaf(1), 4, node(leaf(5), 6, leaf7)), Y).
%		Y = [1, 4, 5, 6, 7].
toList(leaf(X), [X]).
toList(node(L, H, R), List) :- toList(L, L1), toList(R, L2), append(L1, [H|L2], List).

% del(X, Xs, Ys).
% True if Ys is the list Xs with one occurence of X removed
%
% eg.	del(2, [3, 2, 1, 2, 3], Ys).
%		Ys = [3, 1, 2, 3].
%		Ys = [3, 2, 1, 3].
del(X, [X|Xs], Xs).
del(X, [Y|Xs], [Y|Ys]) :- del(X, Xs, Ys).

% delN(Xs, Num, Zs).
% True if Zs is the list Xs with element at place Num (1-indexed) removed
%
% eg.	delN(['fee', 'foe', 'fum'], 2, ZS).
%		ZS = ['fee', 'fum'].
delN(XS, 0, XS).
delN([], _, []).
delN([_X|XS], 1, XS).
delN([X|XS], N, [X|YS]) :- N > 1, M is N-1, delN(XS, M, YS).% ivar studies informatics
studies(ivar, informatics).


% addAtEnd(Xs, Y, Zs).
% True if Zs is the list Xs with Y added to the end
%
% eg. 	addAtEnd([1, 2, 3, 4], 5, Zs).
%		Zs = [1, 2, 3, 4, 5].
addAtEnd([], Object, [Object]).
addAtEnd([H|T], Object, [H|List]) :- addAtEnd(T, Object, List). 

% reverse(Xs, Ys).
% True if Ys is Xs reversed
%
% eg. 	reverse([1, 2, 3], Ys).
%		Ys = [3, 2, 1].
reverse([], []).
reverse([X], [X]).
reverse([X|Xs], Y) :- reverse(Xs, Z), addAtEnd(Z, X, Y).

% natural_number(X).
% True if X is a natural number (successor of 0)
%
% eg. 	natural_number(0).
%		yes
%		natural_number(s(s(s(0)))).
%		yes
%		natural_number(4).
%		no
natural_number(0).
natural_number(s(X)) :- natural_number(X).

% plus(X, Y, Z).
% True if Z is the result of adding X and Y.
%
% eg. 	plus(s(s(0)), s(0), Z).
%		Z = s(s(s(0))).
plus(0, N, N).
plus(s(X), N, s(XPlusN)) :- plus(X, N, XPlusN).

% mul(X, Y, Z).
% True if Z is the result of multiplying X and Y
%
% eg.	mul(s(s(s(0))), s(s(s(0))), Z).
%		Z = s(s(s(s(s(s(s(s(s(0))))))))). 
%		3 * 3 = 9...
mul(0, Y, 0).
mul(s(X), Y, Z) :- mul(X, Y, XY), plus(XY, Y, Z).

% greater_than(X, Y).
% True if X is greater than Y
%
% eg. 	greater_than(s(s(s(0))), s(s(0))).
%		Yes
%		greater_than(s(s(0)), s(s(s(0)))).
% 		no
greater_than(s(_), 0).
greater_than(s(X), s(Y)) :- greater_than(X, Y).
