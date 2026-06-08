let countWords = (sentence: string): Dict.t<int> =>
  sentence
  ->String.toLowerCase
  ->String.match(/\b[\w']+\b/g)
  ->Option.mapOr([], Array.keepSome)
  ->Array.reduce(dict{}, (acc, word) => {
    let count = Dict.get(acc, word)->Option.getOr(0)
    Dict.set(acc, word, count + 1)
    acc
  })
