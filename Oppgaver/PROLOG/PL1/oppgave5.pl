star(sun).
star(vega).
star(sirius).

orbits(mercury, sun). 
orbits(venus, sun).
orbits(earth, sun). 
orbits(mars, sun). 
orbits(moon, earth). 
orbits(deimos, mars).

planet(B) :- orbits(B, sun).
satellite(B) :- orbits(B, A), planet(A).
solar(sun).
solar(X) :- planet(X).
solar(X) :- satellite(X).
