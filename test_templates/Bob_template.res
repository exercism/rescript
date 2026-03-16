open Node

let slug = fileURLToPath(%raw(`import.meta.url`))->basename->Utils.filenameToSlug

let template = (case: GetCases.case) => {
  let expectedStr = JSON.stringify(case.expected)

  let phrase = Utils.getTestCaseInput(case, "heyBob")

  // EDIT THIS WITH YOUR ASSERTIONS (use genAssert... name to generate an assertion in the template)
  AssertionGenerators.equal(
    ~message=case.description,
    ~actual=`response(${phrase})`,
    ~expected=expectedStr,
  )
}

TestGenerator.generateTests(slug, template, [Equal])
