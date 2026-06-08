let rebase = (inputBase, digits, outputBase) => {
  let hasInvalidDigit = digits->Array.some(d => d < 0 || d >= inputBase)
  let allZeros = digits->Array.every(d => d == 0)

  switch (inputBase, outputBase) {
  | (ib, _) if ib < 2 => None
  | (_, ob) if ob < 2 => None
  | _ if hasInvalidDigit => None
  | _ if allZeros => Some([0])
  | _ => {
      let total = digits->Array.reduce(0, (acc, d) => acc * inputBase + d)

      let rec generate = (acc, val) => {
        val == 0 ? acc : generate(list{mod(val, outputBase), ...acc}, val / outputBase)
      }

      let resultList = generate(list{}, total)
      Some(resultList->List.toArray)
    }
  }
}
