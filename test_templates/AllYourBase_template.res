let slug = "all-your-base"

let template = (case: GetCases.case) => {
  let expectedStr = Array.isArray(case.expected) ? `Some(${JSON.stringify(case.expected)})` : "None"

  let inputBase = Utils.getTestCaseInput(case, "inputBase")
  let digits = Utils.getTestCaseInput(case, "digits")
  let outputBase = Utils.getTestCaseInput(case, "outputBase")

  // EDIT THIS WITH YOUR ASSERTIONS (e.g. generateEqual, to generate an assertion in the template)
  AssertionGenerators.equal(
    ~message=case.description,
    ~actual=`rebase(${inputBase}, ${digits}, ${outputBase})`,
    ~expected=expectedStr,
  )
}

// ADD ASSERTION DEPENDENCIES (e.g. [#equal, #deepEqual])
TestGenerator.generateTests(slug, template, [Equal])
