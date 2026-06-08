let response = s => {
  let normalized = String.trim(s)
  let isQuestion = String.endsWith(normalized, "?")
  let isShouting =
    String.toUpperCase(normalized) == normalized && String.toLowerCase(normalized) != normalized

  switch normalized {
  | "" => "Fine. Be that way!"
  | _ if isQuestion && isShouting => "Calm down, I know what I'm doing!"
  | _ if isShouting => "Whoa, chill out!"
  | _ if isQuestion => "Sure."
  | _ => "Whatever."
  }
}
