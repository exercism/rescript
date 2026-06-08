open Node

let slug = fileURLToPath(%raw(`import.meta.url`))->basename->Utils.filenameToSlug

let template = (case: GetCases.case) => {
  let phrase = Utils.getTestCaseInput(case, "phrase")

  let expectedStr = switch case.expected->JSON.Decode.string {
  | Some(str) => `Some(${JSON.stringify(JSON.Encode.string(str))})`
  | None => "None"
  }

  // EDIT THIS WITH YOUR ASSERTIONS
  AssertionGenerators.equal(
    ~message=case.description,
    ~actual=`clean(${phrase})`,
    ~expected=expectedStr,
  )
}

TestGenerator.generateTests(slug, template, [Equal])
