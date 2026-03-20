open Node

let slug = fileURLToPath(%raw(`import.meta.url`))->basename->Utils.filenameToSlug

let template = (case: GetCases.case) => {
  let sentence = Utils.getTestCaseInput(case, "sentence")

  let expectedDict = "dict" ++ JSON.stringify(case.expected)

  // EDIT THIS WITH YOUR ASSERTIONS
  AssertionGenerators.dictEqual(
    ~message=case.description,
    ~actual=`countWords(${sentence})`,
    ~expected=expectedDict,
  )
}

TestGenerator.generateTests(slug, template, [DictEqual])
