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
