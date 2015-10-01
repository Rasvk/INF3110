fun mulall(v: int, l: int list) = 
	List.map (fn x => x * v) l;

fun powlist(x: int, 0) = [1]
	| powlist(x: int, y: int) = mulall(x, powlist(x, y-1))@[1];
