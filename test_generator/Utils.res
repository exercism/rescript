let getTestCaseInput = (case: GetCases.case, inputName: string) => {
  case.input
  ->JSON.Decode.object
  ->Option.getOrThrow
  ->Dict.get(inputName)
  ->Option.getOrThrow
  ->JSON.stringify
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
