open Node

let slug = fileURLToPath(%raw(`import.meta.url`))->basename->Utils.filenameToSlug

let template = (case: GetCases.case) => {
  let expectedStr = JSON.stringify(case.expected)
  let input = Utils.getTestCaseInput(case, "garden")

  AssertionGenerators.equal(
    ~message=case.description,
    ~actual=`annotate(${input})`,
    ~expected=expectedStr,
  )
}

TestGenerator.generateTests(slug, template, [Equal])
