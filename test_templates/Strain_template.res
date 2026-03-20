open Node

let slug = fileURLToPath(%raw(`import.meta.url`))->basename->Utils.filenameToSlug

let template = (case: GetCases.case) => {
  let inputDict = case.input->JSON.Decode.object->Option.getOrThrow

  let predicateKey =
    inputDict
    ->Dict.get("predicate")
    ->Option.flatMap(JSON.Decode.string)
    ->Option.getOr("")

  let predicate = switch predicateKey {
  | "fn(x) -> true" => "(_ => true)"
  | "fn(x) -> false" => "(_ => false)"
  | "fn(x) -> x % 2 == 1" => "(x => mod(x, 2) == 1)"
  | "fn(x) -> x % 2 == 0" => "(x => mod(x, 2) == 0)"
  | "fn(x) -> starts_with(x, 'z')" => "(x => String.startsWith(x, \"z\"))"
  | "fn(x) -> contains(x, 5)" => "(x => Array.includes(x, 5))"
  | _ => "(_ => true)" // Default fallback
  }

  let list = Utils.getTestCaseInput(case, "list")

  // EDIT THIS WITH YOUR ASSERTIONS
  AssertionGenerators.equal(
    ~message=case.description,
    ~actual=`${case.property}(${list}, ${predicate})`,
    ~expected=JSON.stringify(case.expected),
  )
}

TestGenerator.generateTests(slug, template, [Equal])
