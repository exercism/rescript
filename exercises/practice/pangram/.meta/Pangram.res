let isPangram = sentence => {
  let set =
    sentence
    ->String.toLowerCase
    ->String.split("")
    ->Array.filter(c => c >= "a" && c <= "z")
    ->Set.fromArray

  Set.size(set) == 26
}
