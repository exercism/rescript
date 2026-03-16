open Node

type case = {
  description: string,
  expected: JSON.t,
  input: JSON.t,
}

@module("toml") external parseToml: string => dict<'a> = "parse"

let getValidCases = (slug: string): array<case> => {
  let __dirname = dirname(fileURLToPath(%raw("import.meta.url")))

  let projectRoot = resolve(__dirname, "..")

  let tomlPath = join([projectRoot, "exercises", "practice", slug, ".meta", "tests.toml"])

  let jsonPath = join([
    projectRoot,
    "problem-specifications",
    "exercises",
    slug,
    "canonical-data.json",
  ])

  let testMeta = parseToml(readFileSync(tomlPath, "utf-8"))
  let canonicalData: JSON.t = %raw("JSON.parse")(readFileSync(jsonPath, "utf-8"))

  // Using %raw here to keep the logic in JS for now
  let extractCases: (JSON.t, dict<'a>) => array<case> = %raw(`
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
              // validCases.push(testCase);
              validCases.push({
                description: testCase.description,
                expected: testCase.expected,
                input: testCase.input
              });
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
