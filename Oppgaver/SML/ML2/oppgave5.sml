(* pair = fn : 'a list * 'b list -> ('a * 'b) list *)
fun pair(nil, _) = []
  | pair(_, nil) = []
  | pair(x::xs, y::ys) = (x, y)::pair(xs, ys);

(* Pair tests *)
pair([1, 0, ~1], [3, 4, 5]);
pair([1, 2, 3, 4], [1, 2, 3, 4]);

(* mullist = fn : (int * int) list -> int *)
fun mullist(a, b) =
  foldl (op+ ) 0 (map (op* ) (pair(a, b)));

(* mullist test *)
mullist([1, 0, ~1], [3, 4, 5]);
mullist([1, 2, 3, 4], [1, 2, 3, 4]);
