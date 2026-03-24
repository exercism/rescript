let getCharCode = chr => chr->String.charCodeAt(0)

let codeA = getCharCode("A")->Option.getOrThrow
let codeZ = getCharCode("Z")->Option.getOrThrow
let code0 = getCharCode("0")->Option.getOrThrow
let code9 = getCharCode("9")->Option.getOrThrow

let transformChar = char =>
  char
  ->String.toUpperCase
  ->getCharCode
  ->Option.flatMap(code =>
    if code >= codeA && code <= codeZ {
      (codeA + codeZ - code)
      ->String.fromCharCode
      ->String.toLowerCase
      ->Some
    } else if code >= code0 && code <= code9 {
      char->Some
    } else {
      None
    }
  )

let encode = phrase =>
  phrase
  ->String.split("")
  ->Array.filterMap(transformChar)
  ->Array.mapWithIndex((char, i) => i > 0 && mod(i, 5) == 0 ? " " ++ char : char)
  ->Array.join("")

let decode = phrase =>
  phrase->String.split("")->Array.filterMap(transformChar)->Array.join("")
