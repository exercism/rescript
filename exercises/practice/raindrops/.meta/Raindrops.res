let convert = n => {
  let s = (n % 3 == 0 ? "Pling" : "") ++ (n % 5 == 0 ? "Plang" : "") ++ (n % 7 == 0 ? "Plong" : "")
  s == "" ? Int.toString(n) : s
}
