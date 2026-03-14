export const intEqual = `let intEqual = (~message=?, a: int, b: int) => assertion(~message?, ~operator="intEqual", (a, b) => a == b, a, b)`;
export const stringEqual = `let stringEqual = (~message=?, a: string, b: string) => assertion(~message?, ~operator="stringEqual", (a, b) => a == b, a, b)`;
export const assertEqual = `let assertEqual = (~message=?, a: 'a, b: 'a) => assertion(~message?, ~operator="assertEqual", (a, b) => a == b, a, b)`;
export const dictEqual = `const dictEqual = (~message=?, a: Dict.t<'a>, b: Dict.t<'a>) => {
  const toSorted = d => {
    const arr = Dict.toArray(d)
    arr->Array.sort(((k1, _), (k2, _)) => (compare(k1, k2) :> float))
    arr
  }
  assertion(~message?, ~operator="dictEqual", (a, b) => toSorted(a) == toSorted(b), a, b)
}`
