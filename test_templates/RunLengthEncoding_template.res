open Node

let slug = fileURLToPath(%raw(`import.meta.url`))->basename->Utils.filenameToSlug

let template = (case: GetCases.case) => {
  let input = Utils.getTestCaseInput(case, "string")

  let actual = switch case.property {
  | "consistency" => `${input}->encode->decode`
  | prop => `${prop}(${input})`
  }

  let expected = switch case.property {
  | "consistency" => input
  | _ => case.expected->JSON.stringify
  }

  AssertionGenerators.equal(~message=case.description, ~actual, ~expected)
}

TestGenerator.generateTests(slug, template, [Equal])
