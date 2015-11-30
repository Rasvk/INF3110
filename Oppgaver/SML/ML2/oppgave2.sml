fun rep (v, 0) = nil
  | rep (v, n) = v::rep(v, n-1);