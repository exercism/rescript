open Node

let slug = fileURLToPath(%raw(`import.meta.url`))->basename->Utils.filenameToSlug

let template = (case: GetCases.case) => {
  let expectedStr = switch case.expected->JSON.Decode.array {
  | Some(arr) if Array.length(arr) > 0 => `Some(${JSON.stringify(case.expected)})`
  | _ => "None"
  }

  let subject = Utils.getTestCaseInput(case, "subject")
  let candidates = Utils.getTestCaseInput(case, "candidates")

  // EDIT THIS WITH YOUR ASSERTIONS
  AssertionGenerators.equal(
    ~message=case.description,
    ~actual=`findAnagrams(${subject}, ${candidates})`,
    ~expected=expectedStr,
  )
}

TestGenerator.generateTests(slug, template, [Equal])
