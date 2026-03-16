type assertionTag = Equal | DictEqual | Throws

let getAssertionSource = tag => {
  switch tag {
  | Equal => `let equal = (~message=?, a, b) => assertion(~message?, ~operator="equal", (a, b) => a == b, a, b)`
  | DictEqual => `let dictEqual = (~message=?, a: Dict.t<'a>, b: Dict.t<'a>) => {
      let toSorted = d => {
        let arr = Dict.toArray(d)
        arr->Array.sort(((k1, _), (k2, _)) => (compare(k1, k2) :> float))
        arr
      }
      assertion(~message?, ~operator="dictEqual", (a, b) => toSorted(a) == toSorted(b), a, b)
    }`
  | Throws => `let throws = (~message=?, f) => /* throws logic */`
  }
}
