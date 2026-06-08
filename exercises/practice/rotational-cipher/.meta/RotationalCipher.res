let rotate = (text: string, shiftKey: int): string =>
  text
  ->String.split("")
  ->Array.map(char => {
    let code = String.charCodeAt(char, 0)->Option.getOrThrow
    if code >= 97 && code <= 122 {
      String.fromCharCode(mod(code - 97 + shiftKey, 26) + 97)
    } else if code >= 65 && code <= 90 {
      String.fromCharCode(mod(code - 65 + shiftKey, 26) + 65)
    } else {
      char
    }
  })
  ->Array.join("")
