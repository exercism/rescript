open Node

let slug = fileURLToPath(%raw(`import.meta.url`))->basename->Utils.filenameToSlug

let template = (case: GetCases.case) => {
  let expectedStr = switch case.expected->JSON.Decode.float {
  | Some(n) => `Some(${Float.toString(n)})`
  | _ => "None"
  }

  let array = Utils.getTestCaseInput(case, "array")
  let value = Utils.getTestCaseInput(case, "value")

  // EDIT THIS WITH YOUR ASSERTIONS
  AssertionGenerators.equal(
    ~message=case.description,
    ~actual=`find(${array}, ${value})`,
    ~expected=expectedStr,
  )
}

TestGenerator.generateTests(slug, template, [Equal])
