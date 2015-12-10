%%%%%%%%%%% Oppgave 2 a) %%%%%%%%%%%%%%

% boss(Boss, Employee).

boss(eva, anne).
boss(eva, atle).
boss(lars, eva).

sup(X, Y) :- boss(X, Y).
sup(X, Y) :- boss(X, Z), sup(Z, Y).

multipleBosses(X) :- boss(B1, X), boss(B2, X), B1 \== B2.
ok(X) :- \+boss(X, X), \+multipleBosses(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%% Oppgave 2 b) %%%%%%%%%%%%%%

ls(1, ole).
ls(2, dole).
ls(3, ole).

rs(1, ole).
rs(2, dole).
rs(3, doffen).
rs(5, dolly).

find(I, X) :- ls(I, X); rs(I, X).

error(I) :- ls(I, Res1), rs(I, Res2), Res1 \== Res2.

multi(X) :- (ls(I1, X), ls(I2, X), I1 \== I2).
multi(X) :- (rs(I1, X), rs(I2, X), I1 \== I2).
multi(X) :- (ls(I1, X), rs(I2, X), I1 \== I2).
