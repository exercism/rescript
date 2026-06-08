open Node

let slug = fileURLToPath(%raw(`import.meta.url`))->basename->Utils.filenameToSlug

// EDIT THIS WITH YOUR TEST TEMPLATES
let template = (case: GetCases.case) => {
  let expectedStr = JSON.stringify(case.expected)

  // EDIT THIS WITH YOUR ASSERTIONS (use genAssert... name to generate an assertion in the template)
  AssertionGenerators.equal(~message=case.description, ~actual="hello()", ~expected=expectedStr)
}

TestGenerator.generateTests(slug, template, [Equal])
