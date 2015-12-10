fun removeElement(nil, i: int) = nil
  | removeElement(l::ls, i) = if l = i 
                              then removeElement(ls, i) 
                              else l::removeElement(ls, i);


fun gcd(i, j) = if i = 0
                then j
                else gcd(j mod i, i);