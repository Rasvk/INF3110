italian(pizza).
italian(spaghetti).

indian(tandoori).
indian(tikkaMasala).
indian(curry).

mild(tandoori).

likes(ola, X) :- italian(X).
likes(ola, X) :- indian(X), mild(X).