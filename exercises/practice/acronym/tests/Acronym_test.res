open Test
open Acronym

let stringEqual = (~message=?, a: string, b: string) => assertion(~message?, ~operator="stringEqual", (a, b) => a == b, a, b)

test("basic", () => {
  stringEqual(~message="basic", abbreviate("Portable Network Graphics"), "PNG")
})

test("lowercase words", () => {
  stringEqual(~message="lowercase words", abbreviate("Ruby on Rails"), "ROR")
})

test("punctuation", () => {
  stringEqual(~message="punctuation", abbreviate("First In, First Out"), "FIFO")
})

test("all caps word", () => {
  stringEqual(~message="all caps word", abbreviate("GNU Image Manipulation Program"), "GIMP")
})

test("punctuation without whitespace", () => {
  stringEqual(~message="punctuation without whitespace", abbreviate("Complementary metal-oxide semiconductor"), "CMOS")
})

test("very long abbreviation", () => {
  stringEqual(~message="very long abbreviation", abbreviate("Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me"), "ROTFLSHTMDCOALM")
})

test("consecutive delimiters", () => {
  stringEqual(~message="consecutive delimiters", abbreviate("Something - I made up from thin air"), "SIMUFTA")
})

test("apostrophes", () => {
  stringEqual(~message="apostrophes", abbreviate("Halley's Comet"), "HC")
})

test("underscore emphasis", () => {
  stringEqual(~message="underscore emphasis", abbreviate("The Road _Not_ Taken"), "TRNT")
})

