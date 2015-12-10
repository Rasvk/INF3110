empty([]).

one_element_list([_]).

min_two_element_list([_,_|_]).

is_sorted([]).
is_sorted([_]).
is_sorted([X,Y|Z]) :- X =< Y, is_sorted([Y|Z]). 

split([], [], []).
split([X], [X], []).
split([X,Y|Xs], [X|Ys], [Y|Zs]) :- split(Xs, Ys, Zs). 

merge([], Ys, Ys).
merge(Xs, [], Xs).
merge([X|Xs], [Y|Ys], [X|Zs]) :- X =< Y, merge(Xs, [Y|Ys], Zs). 
merge([X|Xs], [Y|Ys], [Y|Zs]) :- Y 	< X, merge([X|Xs], Ys, Zs). 

mergesort(Xs, []) :- empty(Xs).
mergesort(Xs, Xs) :- one_element_list(Xs).
mergesort(Xs, Res) :- 	min_two_element_list(Xs), 
						split(Xs, Ys, Zs),
						mergesort(Ys, Res1),
						mergesort(Zs, Res2),
						merge(Res1, Res2, Res).