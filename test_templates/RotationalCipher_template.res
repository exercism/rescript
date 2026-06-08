open Node

let slug = fileURLToPath(%raw(`import.meta.url`))->basename->Utils.filenameToSlug

let template = (case: GetCases.case) => {
  let text = Utils.getTestCaseInput(case, "text")
  let shiftKey = Utils.getTestCaseInput(case, "shiftKey")

  // EDIT THIS WITH YOUR ASSERTIONS
  AssertionGenerators.equal(
    ~message=case.description,
    ~actual=`rotate(${text}, ${shiftKey})`,
    ~expected=JSON.stringify(case.expected),
  )
}

TestGenerator.generateTests(slug, template, [Equal])
