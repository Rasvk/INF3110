% ivar studies informatics
studies(ivar, informatics).

% the population of norway is 4,5 million
population(norway, 4500000).

% norway is a rich country
rich(norway).

% 2 is a prime number
is_prime(2).

% someone wrote hamlet
wrote(hamlet, someone).

% all humans are mortal
mortal(X) :- human(X).

% all rich people pay taxes
pays_taxes(X) :- rich(X).

% ivar takes his umbrella if it rains
takes_umbrella(ivar) :- rains.

% Firebrigade employees are men over six feet tall.
firebrigade_employee(X) :- man(X), over_six_feet(X).