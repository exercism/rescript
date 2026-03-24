open Node

let slug = fileURLToPath(%raw(`import.meta.url`))->basename->Utils.filenameToSlug

let template = (case: GetCases.case) => {
  let input = Utils.getTestCaseInput(case, "strand")

  let expectedStr = switch case.expected->JSON.Decode.array {
  | Some(arr) => {
      let variants =
        arr
        ->Array.map(val => {
          val->JSON.Decode.string->Option.getOr("")->String.capitalize
        })
        ->Array.join(", ")

      `Some([${variants}])`
    }
  | None => "None"
  }

  AssertionGenerators.equal(
    ~message=case.description,
    ~actual=`${case.property}(${input})`,
    ~expected=expectedStr,
  )
}

TestGenerator.generateTests(slug, template, [Equal])
