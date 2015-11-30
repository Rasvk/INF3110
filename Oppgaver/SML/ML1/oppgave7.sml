fun first [] = ""
	| first [x] = x
	| first (x::xs) = x;

fun last [] = ""
	| last [x] = x
	| last (x::xs) = last xs;

fun car (x::xs) = x;
fun cdr (x::xs) = xs;

fun nth (n, x) =
	if x = [] then ""
	else if n = 1 then car x
	else nth (n-1, cdr x);