open Node

let slug = fileURLToPath(%raw(`import.meta.url`))->basename->Utils.filenameToSlug

let template = (case: GetCases.case) => {
  let coins = Utils.getTestCaseInput(case, "coins")
  let target = Utils.getTestCaseInput(case, "target")

  let expectedStr = switch case.expected->JSON.Decode.array {
  | Some(arr) =>
    let ints =
      arr
      ->Array.filterMap(JSON.Decode.float)
      ->Array.map(f => f->Float.toString)
      ->Array.join(", ")

    `Some([${ints}])`
  | None => "None"
  }

  AssertionGenerators.equal(
    ~message=case.description,
    ~actual=`${case.property}(${coins}, ${target})`,
    ~expected=expectedStr,
  )
}

TestGenerator.generateTests(slug, template, [Equal])
