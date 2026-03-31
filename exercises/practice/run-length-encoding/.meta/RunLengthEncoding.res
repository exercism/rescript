let isDigit = (ch: string) => {
  let ord = String.codePointAt(ch, 0)->Option.getOr(0)
  ord >= 48 && ord <= 57
}

let rec toInt = (s: string, ptr: int, acc: int) => {
  if ptr == String.length(s) {
    (ptr, acc)
  } else {
    let char = String.get(s, ptr)->Option.getOr("")
    if !isDigit(char) {
      (ptr, acc)
    } else {
      let digitValue = String.codePointAt(char, 0)->Option.getOr(48) - 48
      toInt(s, ptr + 1, 10 * acc + digitValue)
    }
  }
}

let rec skipWhileUnchanged = (s: string, startPtr: int, ptr: int): int => {
  let startChar = String.get(s, startPtr)
  let currentChar = String.get(s, ptr)

  if ptr < String.length(s) && currentChar == startChar {
    skipWhileUnchanged(s, startPtr, ptr + 1)
  } else {
    ptr
  }
}

let chunk = (plainText: string, startPtr: int) => {
  let nextPtr = skipWhileUnchanged(plainText, startPtr, startPtr + 1)
  let chunkLength = nextPtr - startPtr
  let chunkChar = String.get(plainText, startPtr)->Option.getOr("")

  let chunked = if chunkLength == 1 {
    chunkChar
  } else {
    Int.toString(chunkLength) ++ chunkChar
  }
  (nextPtr, chunked)
}

let expand = (rleText: string, startPtr: int) => {
  let firstChar = String.get(rleText, startPtr)->Option.getOr("")

  let (nextPtr, size) = if isDigit(firstChar) {
    toInt(rleText, startPtr, 0)
  } else {
    (startPtr, 1)
  }

  let expansionChar = String.get(rleText, nextPtr)->Option.getOr("")
  (nextPtr + 1, String.repeat(expansionChar, size))
}

let rec unfoldString = (startPtr: int, acc: string, consume, s: string): string => {
  if s == "" || startPtr >= String.length(s) {
    acc
  } else {
    let (nextPtr, nextChunk) = consume(s, startPtr)
    unfoldString(nextPtr, acc ++ nextChunk, consume, s)
  }
}

let encode = (phrase: string) => unfoldString(0, "", chunk, phrase)

let decode = (phrase: string) => unfoldString(0, "", expand, phrase)
