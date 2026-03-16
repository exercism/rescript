open Test

let assertEqual = (~message=?, a, b) =>
  assertion(~message?, ~operator="assertEqual", (a, b) => a == b, a, b)

// This returns the string of code the user actually sees in the test
let genAssertEqual = (~message, ~actual, ~expected) => {
  `assertEqual(~message="${message}", ${actual}, ${expected})`
}

let dictEqual = (~message=?, a: Dict.t<'a>, b: Dict.t<'a>) => {
  let toSorted = d => {
    let arr = Dict.toArray(d)
    arr->Array.sort(((k1, _), (k2, _)) => (compare(k1, k2) :> float))
    arr
  }
  assertion(~message?, ~operator="dictEqual", (a, b) => toSorted(a) == toSorted(b), a, b)
}

/** * Asserts that two floats are equal within a specified precision. 
 * The `digits` argument determines the tolerance (10^-digits).
 * Defaults to 2 decimal places (0.01 tolerance).
 */
let floatEqual = (~message=?, ~digits=2, a: float, b: float) => {
  let tolerance = 10.0 ** -.Float.fromInt(digits)
  assertion(~message?, ~operator="floatEqual", (a, b) => Math.abs(a -. b) <= tolerance, a, b)
}
