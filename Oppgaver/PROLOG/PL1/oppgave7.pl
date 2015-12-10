reindeerLine(northpole,oslo). 
reindeerLine(oslo,london). 
reindeerLine(oslo,copenhagen). 
reindeerLine(copenhagen,berlin). 
reindeerLine(northpole,stockholm). 
reindeerLine(stockholm,moscow). 

connection(X, Y) :- reindeerLine(X, Z), reindeerLine(Z, Y).
connection(X, Y) :- reindeerLine(X, Z), connection(Z, Y).

connection(X, Y) :- reindeerLine(X, Z), reindeerLine(Z, Y).