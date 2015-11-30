fun mulall(v: int, l: int list) = 
  List.map (fn x => x * v) l;

fun powlist(x: int, 0) = [1]
  | powlist(x: int, y: int) = mulall(x, powlist(x, y-1))@[1];

(* pair = fn : 'a list * 'b list -> ('a * 'b) list *)
fun pair([], []) = []
  | pair(x: int list, []) = []
  | pair([], y: int list) = []
  | pair(x::xs, y::ys) = (x, y)::pair(xs, ys);

(* Pair tests *)
pair([1, 0, ~1], [3, 4, 5]);
pair([1, 2, 3, 4], [1, 2, 3, 4]);

(* mullist = fn : (int * int) list -> int *)
fun mullist(a: int list, b: int list) =
  let
    val l = pair(a, b)
  in
    List.foldl op+ 0 (List.map (fn (x: int, y: int) => x * y) l)
  end;


fun poly (x: int, p: int list) =
	let
		val len = List.length p - 1
		val pow = powlist(x, len)
	in
		mullist(p, pow)
	end;

val p = [3, ~2, 0, 1];
poly(2, p);
poly(~1, p);