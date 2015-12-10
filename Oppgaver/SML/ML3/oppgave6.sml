infix ++;
fun x ++ y = str(x) ^ str(y);
fun x ++ y = x ^ str(y);
fun x ++ y = str(x) ^ y;
fun x ++ y = x ^ y;


val c1 = #"a";
val c2 = #"h";
val s1 = "bcd";
val s2 = "efg";

c1 ++ c2;
s1 ++ c2;
c1 ++ s1;
s1 ++ s2;