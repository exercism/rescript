type dna =
  | A
  | C
  | G
  | T

let fromString = s => {
  switch s {
  | "A" => A
  | "C" => C
  | "G" => G
  | "T" => T
  | _ => panic("Invalid DNA base")
  }
}

let convert = s => {
  switch s {
  | A => "U"
  | C => "G"
  | G => "C"
  | T => "A"
  }
}

let toRna = dna => dna->String.split("")->Array.map(fromString)->Array.map(convert)->Array.join("")
