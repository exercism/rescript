let slug = "acronym"

let template = (case: GetCases.case) => {
  let expectedStr = JSON.stringify(case.expected)

  let input = Utils.getTestCaseInput(case, "phrase")
  let phrase = JSON.stringify(input)

  // EDIT THIS WITH YOUR ASSERTIONS (use genAssert... name to generate an assertion in the template)
  Assertions.genAssertEqual(
    ~message=case.description,
    ~actual=`abbreviate(${phrase})`,
    ~expected=expectedStr,
  )
}

TestGenerator.generateTests(slug, template)
