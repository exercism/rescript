open Node

let slug = fileURLToPath(%raw(`import.meta.url`))->basename->Utils.filenameToSlug

let template = (case: GetCases.case) => {
  let functionArgs =
    case.property == "allergicTo"
      ? `${Utils.getTestCaseInputAsVariant(case, "item")}, ${Utils.getTestCaseInput(case, "score")}`
      : `${Utils.getTestCaseInput(case, "score")}`

  let expectedStr =
    case.property == "list"
      ? Utils.caseStringArrayToVariantArray(case.expected)->Utils.arrayToString
      : JSON.stringify(case.expected)

  AssertionGenerators.equal(
    ~message=case.description,
    ~actual=`${case.property}(${functionArgs})`,
    ~expected=expectedStr,
  )
}

TestGenerator.generateTests(slug, template, [Equal])
