open Node

let slug = fileURLToPath(%raw(`import.meta.url`))->basename->Utils.filenameToSlug

let template = (case: GetCases.case) => {
  let number = Utils.getTestCaseInput(case, "number")
  let expected = JSON.stringify(case.expected)

  let actual = switch case.property {
  | "squareOfSum" => `squareOfSum(${number})`
  | "sumOfSquares" => `sumOfSquares(${number})`
  | "differenceOfSquares" => `differenceOfSquares(${number})`
  | _ => panic(`Unknown property: ${case.property}`)
  }

  AssertionGenerators.equal(
    ~message=case.description,
    ~actual,
    ~expected,
  )
}

TestGenerator.generateTests(slug, template, [Equal])
