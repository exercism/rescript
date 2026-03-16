open Node

let toPascalCase = slug => {
  slug
  ->String.split("-")
  ->Array.map(w => w->String.charAt(0)->String.toUpperCase ++ String.slice(w, ~start=1))
  ->Array.join("")
}

let generate = (outputPath, slug, assertionFunctions, template) => {
  let moduleName = toPascalCase(slug)
  let cases = GetCases.getValidCases(slug)
  let lastCaseIndex = Array.length(cases) - 1

  let output = ref(`open Test\nopen ${moduleName}\n\n`)

  if Array.isArray(assertionFunctions) {
    let assertionsStr = assertionFunctions->Array.map(fn => String.trim(fn))->Array.join("\n\n")
    output := output.contents ++ assertionsStr ++ "\n\n"
  }

  cases->Array.forEachWithIndex((c, index) => {
    let {description} = c
    let testContent = template(c)
    let spacing = index == lastCaseIndex ? "\n" : "\n\n"

    output := output.contents ++ `test("${description}", () => {${testContent}})${spacing}`
  })

  let dir = dirname(outputPath)

  if !existsSync(dir) {
    mkdirSync(dir, {"recursive": true})
  }

  writeFileSync(outputPath, output.contents, "utf-8")
  Console.log(`Generated: ${basename(outputPath)}`)
}

let generateTests = (dir, slug, assertionFunctions, template) => {
  resolve4(dir, "..", "tests", `${toPascalCase(slug)}_test.res`)->generate(
    slug,
    assertionFunctions,
    template,
  )
}
