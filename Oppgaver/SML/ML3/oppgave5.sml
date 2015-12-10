(* 'a list * 'b -> 'b *)
fun append(nil, l) = l
  | append(x::l, m) = append(l, m);