open Node

let slug = fileURLToPath(%raw(`import.meta.url`))->basename->Utils.filenameToSlug

// REMOVE WHEN IMPLEMENTING TEST
panic("test not yet implemented")

// UNCOMMENT CODE BELOW AND EDIT WITH YOUR TEST TEMPLATE
// let template = (case: GetCases.case) => {
//   let expectedStr = JSON.stringify(case.expected)
//   let input = Utils.getTestCaseInput(case, "phrase")

// EDIT THIS WITH YOUR ASSERTIONS (use genAssert... name to generate an assertion in the template)
//   AssertionGenerators.equal(
//     ~message=case.description,
//     ~actual=`functionName(${input})`,
//     ~expected=expectedStr,
//   )
// }

// TestGenerator.generateTests(slug, template, [Equal])
