italian(pizza).
italian(spaghetti).

indian(tandoori).
indian(tikkaMasala).
indian(curry).

mild(tandoori).

nationality(ola, nor).
nationality(eyvind, nor).
nationality(rupinder, ind).
nationality(raji, ind).

likes(X, Y) :- nationality(X, nor), italian(Y).
likes(X, Y) :- nationality(X, nor), indian(Y), mild(Y).
likes(X, Y) :- nationality(X, ind), indian(Y).
