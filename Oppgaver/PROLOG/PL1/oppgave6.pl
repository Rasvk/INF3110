%tel(county, person, number).

tel(hundre_meter_skogen, ole_brumm, 123).
tel(hundre_meter_skogen2, ole_brumm2, 123).
tel(hundre_meter_skogen2, ole_brumm2, 1234).
tel(hundre_meter_skogen3, ole_brumm3, 12345).
%tel(County, _, 123).

local(N1, N2) :- tel(X, _, N1), tel(X, _, N2).

unique(X) :- tel(County1, Person1, X),
			 tel(County2, Person2, X),
			 County1 == County2,
			 Person1 == Person2.