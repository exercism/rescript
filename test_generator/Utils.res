let getTestCaseInput = (case: GetCases.case, inputName: string) => {
  case.input
  ->JSON.Decode.object
  ->Option.getOrThrow
  ->Dict.get(inputName)
  ->Option.getOrThrow
  ->JSON.stringify
}

// Convert string case input to variant - this is a capitalized string which the compiler reads as a variant
let getTestCaseInputAsVariant = (case: GetCases.case, inputName: string) => {
  case.input
  ->JSON.Decode.object
  ->Option.flatMap(dict => Dict.get(dict, inputName))
  ->Option.flatMap(JSON.Decode.string)
  ->Option.map(String.capitalize)
  ->Option.getOr("")
}

let filenameToSlug = (str: string) => {
  str
  // Remove file extensions if present
  ->String.replaceRegExp(/[._].*$/, "")
  // Handle PascalCase/camelCase: Insert hyphen before caps
  ->String.replaceRegExp(/([a-z0-9])([A-Z])/g, "$1-$2")
  ->String.toLowerCase
}

// JSON helper - if there's no decimal point, add one for ReScript float syntax (e.g., "10" -> "10.")
let toResFloat = (json: JSON.t) => {
  let f = json->JSON.Decode.float->Option.getOr(0.0)
  let s = f->Float.toString
  !String.includes(s, ".") ? s ++ "." : s
}

// Convert JSON encoded array of strings to an array of variants
let caseStringArrayToVariantArray = (json): array<string> => {
  json
  ->JSON.Decode.array
  ->Option.map(arr => {
    arr->Array.filterMap(item => {
      item
      ->JSON.Decode.string
      ->Option.map(String.capitalize)
    })
  })
  ->Option.getOr([]) // If decoding fails or is null, return []
}

// Convert an array to a string representation eg. "[Item1, Item2, Item3]"
let arrayToString = arr => `[` ++ arr->Array.join(", ") ++ `]`
