let slug = "bob"

let template = (case: GetCases.case) => {
  let expectedStr = JSON.stringify(case.expected)

  let input = Utils.getTestCaseInput(case, "heyBob")
  let phrase = JSON.stringify(input)

  // EDIT THIS WITH YOUR ASSERTIONS (use genAssert... name to generate an assertion in the template)
  Assertions.genAssertEqual(
    ~message=case.description,
    ~actual=`response(${phrase})`,
    ~expected=expectedStr,
  )
}

TestGenerator.generateTests(slug, template)
