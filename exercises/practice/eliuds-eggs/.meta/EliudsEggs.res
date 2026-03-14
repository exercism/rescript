let eggCount = num => {
  let rec aux = (count, acc) => {
    switch count {
    | 0 => acc
    | _ if count % 2 !== 0 => aux(count - 1, acc + 1)
    | _ => aux(count / 2, acc)
    }
  }
  aux(num, 0)
}
