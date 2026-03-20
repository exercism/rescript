open Node

let slug = fileURLToPath(%raw(`import.meta.url`))->basename->Utils.filenameToSlug

let template = (case: GetCases.case) => {
  let inputDict = case.input->JSON.Decode.object->Option.getOrThrow

  let planet =
    inputDict
    ->Dict.get("planet")
    ->Option.flatMap(JSON.Decode.string)
    ->Option.getOrThrow

  let seconds = Utils.getTestCaseInput(case, "seconds")

  // EDIT THIS WITH YOUR ASSERTIONS
  AssertionGenerators.floatApproximatelyEqual(
    ~message=case.description,
    ~actual=`age(${planet}, ${seconds})`,
    ~expected=JSON.stringify(case.expected),
  )
}

TestGenerator.generateTests(slug, template, [FloatApproximatelyEqual(2)])
