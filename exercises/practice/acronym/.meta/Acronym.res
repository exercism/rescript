let abbreviate = (phrase: string): string => {
  switch phrase->String.match(/[a-zA-Z']+/g) {
  | Some(words) =>
    words
    ->Array.filterMap(w => w)
    ->Array.map(w => w->String.charAt(0)->String.toUpperCase)
    ->Array.join("")
  | None => ""
  }
}
