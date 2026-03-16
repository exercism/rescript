open Node

@module("toml") external parseToml: string => dict<'a> = "parse"

let getValidCases = (slug: string) => {
  let __dirname = dirname(fileURLToPath(%raw("import.meta.url")))

  let tomlPath = join([__dirname, "..", "exercises", "practice", slug, ".meta", "tests.toml"])
  let jsonPath = join([
    __dirname,
    "..",
    "problem-specifications",
    "exercises",
    slug,
    "canonical-data.json",
  ])

  let testMeta = parseToml(readFileSync(tomlPath, "utf-8"))
  let canonicalData: JSON.t = %raw("JSON.parse")(readFileSync(jsonPath, "utf-8"))

  // Using %raw here to keep the logic in JS for now
  let extractCases: (JSON.t, dict<'a>) => array<JSON.t> = %raw(`
    (data, meta) => {
      const validCases = [];
      const extract = (cases) => {
        for (const testCase of cases) {
          if (testCase.cases) {
            extract(testCase.cases);
          } else {
            const { uuid } = testCase;
            const m = meta[uuid];
            if (uuid && m && m.include !== false) {
              validCases.push(testCase);
            }
          }
        }
      };
      extract(data.cases);
      return validCases;
    }
  `)

  extractCases(canonicalData, testMeta)
}
