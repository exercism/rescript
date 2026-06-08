export const intEqual = `let intEqual = (~message=?, a: int, b: int) => assertion(~message?, ~operator="intEqual", (a, b) => a == b, a, b)`;
export const stringEqual = `let stringEqual = (~message=?, a: string, b: string) => assertion(~message?, ~operator="stringEqual", (a, b) => a == b, a, b)`;
export const assertEqual = `let assertEqual = (~message=?, a: 'a, b: 'a) => assertion(~message?, ~operator="assertEqual", (a, b) => a == b, a, b)`;

export const dictEqual = `let dictEqual = (~message=?, a: Dict.t<'a>, b: Dict.t<'a>) => {
  let toSorted = d => {
    let arr = Dict.toArray(d)
    arr->Array.sort(((k1, _), (k2, _)) => (compare(k1, k2) :> float))
    arr
  }
  assertion(~message?, ~operator="dictEqual", (a, b) => toSorted(a) == toSorted(b), a, b)
}`;

/** * Asserts that two floats are equal within a specified precision. 
 * The `digits` argument determines the tolerance (10^-digits).
 * Defaults to 2 decimal places (0.01 tolerance).
 */
export const floatEqual = `let floatEqual = (~message=?, ~digits=2, a: float, b: float) => {
  let tolerance = 10.0 ** -.Float.fromInt(digits)
  assertion(
    ~message?,
    ~operator="floatEqual",
    (a, b) => Math.abs(a -. b) <= tolerance,
    a,
    b,
  )
}`;