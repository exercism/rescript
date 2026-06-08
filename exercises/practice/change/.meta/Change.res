let findFewestCoins = (coins, target) => {
  let table = Array.make(~length=target + 1, None)->(
    t => {
      t[0] = Some([])
      t
    }
  )
  let sorted = coins->Array.toSorted((a, b) => (a - b :> float))

  for amt in 1 to target {
    table[amt] =
      sorted->Array.reduce(None, (best, coin) =>
        switch (amt - coin, table->Array.get(amt - coin)->Option.flatMap(x => x)) {
        | (r, Some(sub)) if r >= 0 =>
          let path = Array.concat(sub, [coin])
          switch best {
          | Some(current) if Array.length(current) <= Array.length(path) => best
          | _ => Some(path)
          }
        | _ => best
        }
      )
  }

  table
  ->Array.get(target)
  ->Option.flatMap(x => x)
  ->Option.map(res => res->Array.toSorted((a, b) => (a - b :> float)))
}
