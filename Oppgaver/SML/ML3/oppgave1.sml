(* (int * int) -> int *)
fun a(x, y) = x + 2 * y;

(* (real * real) -> real *)
fun b(x, y) = x + y / 2.0;

(* ('a -> 'b) -> 'a -> 'b *)
fun c(f) = fn y => f(y);

(* ('a -> 'a) * 'a -> 'a *)
fun d(f, x) = f(f(x));

(* 'a * 'a * ('a -> bool) -> 'a *)
fun e(x, y, b) = if b(y) then x else y;