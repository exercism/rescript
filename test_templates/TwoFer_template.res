open Node

let slug = fileURLToPath(%raw(`import.meta.url`))->basename->Utils.filenameToSlug

let template = (case: GetCases.case) => {
  let inputDict = case.input->JSON.Decode.object->Option.getOrThrow
  let nameOption = inputDict->Dict.get("name")->Option.flatMap(JSON.Decode.string)

  let actualStr = switch nameOption {
  | Some(name) => `twoFer(Some("${name}"))`
  | None => `twoFer(None)`
  }

  // EDIT THIS WITH YOUR ASSERTIONS
  AssertionGenerators.equal(
    ~message=case.description,
    ~actual=actualStr,
    ~expected=JSON.stringify(case.expected),
  )
}

TestGenerator.generateTests(slug, template, [Equal])
