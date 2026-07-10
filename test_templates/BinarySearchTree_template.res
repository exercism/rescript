open Node

let slug = fileURLToPath(%raw(`import.meta.url`))->basename->Utils.filenameToSlug

let rec tree = json =>
  switch json->JSON.Decode.object {
  | None => "EmptyTree"
  | Some(dict) =>
    let data =
      dict
      ->Dict.get("data")
      ->Option.flatMap(JSON.Decode.string)
      ->Option.getOr("0")
    let left = dict->Dict.get("left")->Option.mapOr("EmptyTree", tree)
    let right = dict->Dict.get("right")->Option.mapOr("EmptyTree", tree)

    `TreeNode({value: ${data}, left: ${left}, right: ${right}})`
  }

let template = (case: GetCases.case) => {
  let treeData =
    case.input
    ->JSON.Decode.object
    ->Option.getOrThrow
    ->Dict.get("treeData")
    ->Option.mapOr("[]", Utils.jsonStringArrayToIntArrayString)

  switch case.property {
  | "data" =>
    AssertionGenerators.equal(
      ~message=case.description,
      ~actual=`binarySearchTree(${treeData})`,
      ~expected=tree(case.expected),
    )
  | "sortedData" =>
    AssertionGenerators.equal(
      ~message=case.description,
      ~actual=`binarySearchTree(${treeData})->sortedData`,
      ~expected=Utils.jsonStringArrayToIntArrayString(case.expected),
    )
  | _ => panic(`unknown property: ${case.property}`)
  }
}

TestGenerator.generateTests(slug, template, [Equal])
