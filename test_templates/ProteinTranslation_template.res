open Node

let slug = fileURLToPath(%raw(`import.meta.url`))->basename->Utils.filenameToSlug

let template = (case: GetCases.case) => {
  let input = Utils.getTestCaseInput(case, "strand")

  let expectedStr = switch case.expected->JSON.Decode.array {
  | Some(arr) if arr->Array.length > 0 => {
      let variants =
        arr
        ->Array.map(val => {
          val->JSON.Decode.string->Option.getOr("")->String.capitalize
        })
        ->Array.join(", ")

      `Some([${variants}])`
    }
  | _ => "None"
  }

  AssertionGenerators.equal(
    ~message=case.description,
    ~actual=`${case.property}(${input})`,
    ~expected=expectedStr,
  )
}

TestGenerator.generateTests(slug, template, [Equal])
