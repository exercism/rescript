let keep = (arr: array<'a>, predicate: 'a => bool): array<'a> =>
  arr->Array.reduce([], (acc, elem) =>
    predicate(elem) ? Array.concat(acc, [elem]) : acc
  )

let discard = (arr: array<'a>, predicate: 'a => bool): array<'a> =>
  keep(arr, x => !predicate(x))
