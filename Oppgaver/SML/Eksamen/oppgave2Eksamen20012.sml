datatype exp = 
    Const of int 
  | Neg of exp
  | Add of (exp * exp);

datatype stacklang = 
    Push of int 
  | Op of (int list -> int list);


fun fAdd (nil) = nil
  | fAdd ([x]) = [x]
  | fAdd (x::y::ls) = (x+y)::ls;

fun fNeg (nil) = nil
  | fNeg ([x]) = [~x]
  | fNeg (x::ls) = (~x)::ls;

fun convert (Neg x) = convert(x)@[Op fNeg]
  | convert (Add (x, y)) = convert(x)@convert(y)@[Op fAdd]
  | convert (Const x) = [Push x];

fun evalStack(x, ls) = 
  let 
    val stackls = convert(x) 
    fun es([], ls) = ls
      | es((Op x)::sls, ls) = es(sls, x ls)
      | es((Push x)::sls, ls) = es(sls, x::ls)
  in
    es(stackls, ls)
  end;

val t = Neg (Add (Const 3, Const 5)) : exp
val lol = evalStack(t, [])
val st = [Push 3, Push 5, Op fAdd, Op fNeg] : stacklang list
