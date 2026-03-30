let roman = n => {
  let rec aux = (s, remainder) => {
    switch remainder {
    | r if r >= 1000 => aux(s ++ "M", r - 1000)
    | r if r >= 900 => aux(s ++ "CM", r - 900)
    | r if r >= 500 => aux(s ++ "D", r - 500)
    | r if r >= 400 => aux(s ++ "CD", r - 400)
    | r if r >= 100 => aux(s ++ "C", r - 100)
    | r if r >= 90 => aux(s ++ "XC", r - 90)
    | r if r >= 50 => aux(s ++ "L", r - 50)
    | r if r >= 40 => aux(s ++ "XL", r - 40)
    | r if r >= 10 => aux(s ++ "X", r - 10)
    | r if r >= 9 => aux(s ++ "IX", r - 9)
    | r if r >= 5 => aux(s ++ "V", r - 5)
    | r if r >= 4 => aux(s ++ "IV", r - 4)
    | r if r >= 1 => aux(s ++ "I", r - 1)
    | _ => s
    }
  }
  aux("", n)
}
