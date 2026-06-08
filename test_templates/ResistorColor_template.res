open Node

let slug = fileURLToPath(%raw(`import.meta.url`))->basename->Utils.filenameToSlug

let template = (case: GetCases.case) => {
  let functionArgs =
    case.property == "colorCode" ? `(${Utils.getTestCaseInput(case, "color")})` : ""

  AssertionGenerators.equal(
    ~message=case.description,
    ~actual=`${case.property}${functionArgs}`,
    ~expected=JSON.stringify(case.expected),
  )
}

TestGenerator.generateTests(slug, template, [Equal])
