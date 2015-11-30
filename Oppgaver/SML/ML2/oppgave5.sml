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

(* mullist test *)
mullist([1, 0, ~1], [3, 4, 5]);
mullist([1, 2, 3, 4], [1, 2, 3, 4]);
