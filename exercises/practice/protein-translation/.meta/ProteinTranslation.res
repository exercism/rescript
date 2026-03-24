type codons =
  | Methionine
  | Phenylalanine
  | Leucine
  | Serine
  | Tyrosine
  | Cysteine
  | Tryptophan
  | STOP

let strandToCodon = strand => {
  switch strand {
  | "AUG" => Some(Methionine)
  | "UUU" | "UUC" => Some(Phenylalanine)
  | "UUA" | "UUG" => Some(Leucine)
  | "UCU" | "UCC" | "UCA" | "UCG" => Some(Serine)
  | "UAU" | "UAC" => Some(Tyrosine)
  | "UGU" | "UGC" => Some(Cysteine)
  | "UGG" => Some(Tryptophan)
  | "UAA" | "UAG" | "UGA" => Some(STOP)
  | _ => None
  }
}

let proteins = strand => {
  let len = String.length(strand)

  let rec aux = (index, acc) => {
    if index >= len {
      Some(acc->List.toArray->Array.toReversed)
    } else {
      let chunk = String.substring(strand, ~start=index, ~end=index + 3)

      switch strandToCodon(chunk) {
      | Some(STOP) => Some(acc->List.toArray->Array.toReversed)
      | Some(codon) => aux(index + 3, list{codon, ...acc})
      | None => None
      }
    }
  }

  aux(0, list{})
}
