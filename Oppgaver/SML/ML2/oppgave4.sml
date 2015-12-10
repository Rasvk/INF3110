fun mulall(v, l) = 
	map (fn x => x * v) l;

fun powlist(_, 0) = [1]
	| powlist(x, y) = mulall(x, powlist(x, y-1))@[1];

mulall(5, [1, 2, 3, 4, 5]);
powlist(5, 5);