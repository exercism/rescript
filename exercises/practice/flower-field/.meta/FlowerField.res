let annotate = (field: array<string>): array<string> => {
  let height = Array.length(field)
  if height == 0 {
    []
  } else {
    let width = switch field[0] {
    | Some(firstRow) => String.length(firstRow)
    | None => 0
    }

    let getAt = (r, c) => {
      if r >= 0 && r < height && c >= 0 && c < width {
        switch field[r] {
        | Some(row) => row->String.get(c)->Option.getOr(" ")
        | None => " "
        }
      } else {
        " "
      }
    }

    let directions = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]

    field->Array.mapWithIndex((row, r) => {
      row
      ->String.split("")
      ->Array.mapWithIndex((char, c) => {
        if char == "*" {
          "*"
        } else {
          let count = directions->Array.reduce(
            0,
            (acc, (dr, dc)) => {
              if getAt(r + dr, c + dc) == "*" {
                acc + 1
              } else {
                acc
              }
            },
          )

          if count == 0 {
            " "
          } else {
            Int.toString(count)
          }
        }
      })
      ->Array.join("")
    })
  }
}
