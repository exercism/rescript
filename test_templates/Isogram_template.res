open Node

let slug = fileURLToPath(%raw(`import.meta.url`))->basename->Utils.filenameToSlug

let template = (case: GetCases.case) => {
  let number = Utils.getTestCaseInput(case, "phrase")

  // EDIT THIS WITH YOUR ASSERTIONS
  AssertionGenerators.equal(
    ~message=case.description,
    ~actual=`isIsogram(${number})`,
    ~expected=JSON.stringify(case.expected),
  )
}

TestGenerator.generateTests(slug, template, [Equal])
