let slug = "acronym"

let template = (case: GetCases.case) => {
  let expectedStr = JSON.stringify(case.expected)

  let phrase = Utils.getTestCaseInput(case, "phrase")

  // EDIT THIS WITH YOUR ASSERTIONS
  AssertionGenerators.equal(
    ~message=case.description,
    ~actual=`abbreviate(${phrase})`,
    ~expected=expectedStr,
  )
}

TestGenerator.generateTests(slug, template, [Equal])
