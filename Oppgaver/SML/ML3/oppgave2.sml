(* (('a -> 'b) -> 'a -> 'b) -> 'a -> 'b' *)
fun Y f x = f (Y f) x;

(* (int -> int) -> int -> int *)
fun F f x = if x = 0 then 1 else x * f(x - 1);
F (fn x => x) 0; (* 1 *)
F (fn x => x) 1; (* 0 *)
F (fn x => x) 2; (* 2 *)
F (fn x => x) 3; (* 6 *)
