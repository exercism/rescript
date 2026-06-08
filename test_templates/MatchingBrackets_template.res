open Node

let slug = fileURLToPath(%raw(`import.meta.url`))->basename->Utils.filenameToSlug

let template = (case: GetCases.case) => {
  let expectedStr = JSON.stringify(case.expected)
  let input = Utils.getTestCaseInput(case, "value")

  AssertionGenerators.equal(
    ~message=case.description,
    ~actual=`isPaired(${input})`,
    ~expected=expectedStr,
  )
}

TestGenerator.generateTests(slug, template, [Equal])
