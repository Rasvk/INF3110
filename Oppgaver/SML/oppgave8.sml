fun smaa (v, []) = []
	| smaa (v, (x::xs)) =
		if x <= v then x::smaa(v, xs) else smaa(v, xs);

fun store (v, []) = []
	| store (v, (x::xs)) =
		if x > v then x::store(v, xs) else store(v, xs);

fun quicksort [] = []
    | quicksort [x] = [x]
    | quicksort (x::xs) = 
          quicksort(smaa(x, xs)) 
        @ [x]
        @ quicksort(store(x, xs));