fun annengrad (a, b, c) = 
	let
		val r = Math.sqrt(2.0 * 2.0 - 4.0 * a * c)
	in
		(((~b + r) / 2.0 * a), ((~b - r) / 2.0 * a))
	end;