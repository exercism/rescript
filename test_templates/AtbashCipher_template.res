open Node

let slug = fileURLToPath(%raw(`import.meta.url`))->basename->Utils.filenameToSlug

let template = (case: GetCases.case) => {
  let phrase = Utils.getTestCaseInput(case, "phrase")

  AssertionGenerators.equal(
    ~message=case.description,
    ~actual=`${case.property}(${phrase})`,
    ~expected=JSON.stringify(case.expected),
  )
}

TestGenerator.generateTests(slug, template, [Equal])
