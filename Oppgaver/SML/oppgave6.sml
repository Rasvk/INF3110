fun max2 (a, b) =
	if a > b then a else b;

fun max3 (a, b, c) =
	max2 (max2 (a, b), c);

fun max [] = raise Empty
	| max [x] = x
	| max (x::xs) = max2(x, max xs);