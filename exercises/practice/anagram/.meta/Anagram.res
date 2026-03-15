let toChars = (word: string): string => {
  word
  ->String.toLowerCase
  ->String.split("")
  ->Array.toSorted(String.compare)
  ->Array.join("")
}

let isAnagram = (base: string, word: string): bool => {
  let lowerBase = String.toLowerCase(base)
  let lowerWord = String.toLowerCase(word)

  String.length(base) == String.length(word) &&
  lowerBase != lowerWord &&
  toChars(lowerBase) == toChars(lowerWord)
}

let findAnagrams = (subject, candidates) => {
  switch candidates->Array.filter(word => isAnagram(subject, word)) {
  | [] => None
  | result => Some(result)
  }
}
