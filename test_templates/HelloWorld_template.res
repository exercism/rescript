let slug = "hello-world"

// EDIT THIS WITH YOUR TEST TEMPLATES
let template = (case: GetCases.case) => {
  let expectedStr = JSON.stringify(case.expected)

  // EDIT THIS WITH YOUR ASSERTIONS (use genAssert... name to generate an assertion in the template)
  Assertions.genAssertEqual(~message=case.description, ~actual="hello()", ~expected=expectedStr)
}

TestGenerator.generateTests(slug, template)
