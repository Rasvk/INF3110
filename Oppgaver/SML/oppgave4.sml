fun power (a, b) =
	if b = 1 then a else 
	a * power (a, b-1);