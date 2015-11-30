fun repeat(f, d, l) = 
  case l of
      []    => d
    | x::l' => f(x, repeat(f, d, l'));

fun repeat_alt(f, d, l) =
  case l of
      []    => d
    | x::l' => repeat_alt(f, f(d, x), l');

fun repeat_alt1(f, []) = 0
  | repeat_alt1(f, x::xs) = repeat_alt(f, x, xs);

fun minus(x: int, y: int) = x - y;

repeat_alt1(minus, [1, 2, 3]);