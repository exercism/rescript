open Test
open Isogram

let assertEqual = (~message=?, a: 'a, b: 'a) => assertion(~message?, ~operator="assertEqual", (a, b) => a == b, a, b)

test("empty string", () => {
  assertEqual(~message="empty string", isIsogram(""), true)
})

test("isogram with only lower case characters", () => {
  assertEqual(~message="isogram with only lower case characters", isIsogram("isogram"), true)
})

test("word with one duplicated character", () => {
  assertEqual(~message="word with one duplicated character", isIsogram("eleven"), false)
})

test("word with one duplicated character from the end of the alphabet", () => {
  assertEqual(~message="word with one duplicated character from the end of the alphabet", isIsogram("zzyzx"), false)
})

test("longest reported english isogram", () => {
  assertEqual(~message="longest reported english isogram", isIsogram("subdermatoglyphic"), true)
})

test("word with duplicated character in mixed case", () => {
  assertEqual(~message="word with duplicated character in mixed case", isIsogram("Alphabet"), false)
})

test("word with duplicated character in mixed case, lowercase first", () => {
  assertEqual(~message="word with duplicated character in mixed case, lowercase first", isIsogram("alphAbet"), false)
})

test("hypothetical isogrammic word with hyphen", () => {
  assertEqual(~message="hypothetical isogrammic word with hyphen", isIsogram("thumbscrew-japingly"), true)
})

test("hypothetical word with duplicated character following hyphen", () => {
  assertEqual(~message="hypothetical word with duplicated character following hyphen", isIsogram("thumbscrew-jappingly"), false)
})

test("isogram with duplicated hyphen", () => {
  assertEqual(~message="isogram with duplicated hyphen", isIsogram("six-year-old"), true)
})

test("made-up name that is an isogram", () => {
  assertEqual(~message="made-up name that is an isogram", isIsogram("Emily Jung Schwartzkopf"), true)
})

test("duplicated character in the middle", () => {
  assertEqual(~message="duplicated character in the middle", isIsogram("accentor"), false)
})

test("same first and last characters", () => {
  assertEqual(~message="same first and last characters", isIsogram("angola"), false)
})

test("word with duplicated character and with two hyphens", () => {
  assertEqual(~message="word with duplicated character and with two hyphens", isIsogram("up-to-date"), false)
})
