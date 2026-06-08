open Node
open Utils

let slug = fileURLToPath(%raw(`import.meta.url`))->basename->Utils.filenameToSlug

let toPointLit = (json): string => {
  let dict = json->JSON.Decode.object->Option.getOrThrow
  let x = dict->Dict.get("x")->Option.mapOr("0.", toResFloat)
  let y = dict->Dict.get("y")->Option.mapOr("0.", toResFloat)
  let angle = dict->Dict.get("angle")->Option.mapOr("0.", toResFloat)

  `{x: ${x}, y: ${y}, angle: ${angle}}`
}

let toPrismLit = (json): string => {
  let dict = json->JSON.Decode.object->Option.getOrThrow

  let id =
    dict
    ->Dict.get("id")
    ->Option.flatMap(JSON.Decode.float)
    ->Option.mapOr("0", f => f->Float.toInt->Int.toString)

  let point = toPointLit(json)

  `{id: ${id}, point: ${point}}`
}

let expectedSeq = (case: GetCases.case) =>
  case.expected
  ->JSON.Decode.object
  ->Option.flatMap(dict => dict->Dict.get("sequence"))
  ->Option.flatMap(JSON.Decode.array)
  ->Option.map(arr => {
    let items =
      arr
      ->Array.map(item => item->JSON.Decode.float->Option.getOr(0.)->Float.toInt->Int.toString)
      ->Array.join(", ")
    "[" ++ items ++ "]"
  })
  ->Option.getOr("[]")

let template = (case: GetCases.case) => {
  let inputDict = case.input->JSON.Decode.object->Option.getOrThrow

  let start =
    inputDict
    ->Dict.get("start")
    ->Option.map(toPointLit)
    ->Option.getOr("{}")

  let prisms =
    inputDict
    ->Dict.get("prisms")
    ->Option.flatMap(JSON.Decode.array)
    ->Option.map(arr => "[" ++ arr->Array.map(toPrismLit)->Array.join(", ") ++ "]")
    ->Option.getOr("[]")

  AssertionGenerators.equal(
    ~message=case.description,
    ~actual=`findSequence(${start}, ${prisms})`,
    ~expected=expectedSeq(case),
  )
}

TestGenerator.generateTests(slug, template, [Equal])
