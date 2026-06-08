open Node

let slug = fileURLToPath(%raw(`import.meta.url`))->basename->Utils.filenameToSlug

let template = (case: GetCases.case) => {
  let year = Utils.getTestCaseInput(case, "year")

  // EDIT THIS WITH YOUR ASSERTIONS
  AssertionGenerators.equal(
    ~message=case.description,
    ~actual=`isLeapYear(${year})`,
    ~expected=JSON.stringify(case.expected),
  )
}

TestGenerator.generateTests(slug, template, [Equal])
