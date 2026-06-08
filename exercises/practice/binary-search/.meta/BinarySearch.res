let find = (array: array<int>, value: int): option<int> => {
  let rec go = (lo, hi) =>
    if lo > hi {
      None
    } else {
      let mid = lo + (hi - lo) / 2
      // Use getUnsafe because our bounds logic ensures 'mid' is valid
      let midVal = Array.getUnsafe(array, mid)

      if midVal < value {
        go(mid + 1, hi)
      } else if midVal > value {
        go(lo, mid - 1)
      } else {
        Some(mid)
      }
    }

  go(0, Array.length(array) - 1)
}
