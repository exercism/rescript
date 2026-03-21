open Node

let slug = fileURLToPath(%raw(`import.meta.url`))->basename->Utils.filenameToSlug

let template = (case: GetCases.case) => {
  let colors = Utils.getTestCaseInput(case, "colors")
  let expectedObj =
    case.expected
    ->JSON.Decode.object
    ->Option.getOrThrow
  let value =
    expectedObj
    ->Dict.get("value")
    ->Option.getOrThrow
    ->JSON.stringify
  let unit =
    expectedObj
    ->Dict.get("unit")
    ->Option.getOrThrow
    ->JSON.Decode.string
    ->Option.getOrThrow

  AssertionGenerators.equal(
    ~message=case.description,
    ~actual=`label(${colors})`,
    ~expected=`"${value} ${unit}"`,
  )
}

TestGenerator.generateTests(slug, template, [Equal])
