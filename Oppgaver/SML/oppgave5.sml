fun add ({teller=t1, nevner=n1}, {teller=t2, nevner = n2}) =
	let
		val newTeller = t1*n2 + n1*t2
		val newNevner = n1*n2
	in
		{teller=newTeller, nevner=newNevner}
	end;