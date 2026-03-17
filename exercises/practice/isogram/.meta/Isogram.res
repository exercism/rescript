let isIsogram = phrase => {
  let charSet = Set.make()

  phrase
  ->String.toLowerCase
  ->String.split("")
  ->Array.every(c => {
    if c == " " || c == "-" {
      true
    } else if charSet->Set.has(c) {
      false
    } else {
      charSet->Set.add(c)
      true
    }
  })
}
