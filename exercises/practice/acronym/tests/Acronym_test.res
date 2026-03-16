open Test
open Acronym

test("basic", () => {Assertions.assertEqual(~message="basic", abbreviate("Portable Network Graphics"), "PNG")})

test("lowercase words", () => {Assertions.assertEqual(~message="lowercase words", abbreviate("Ruby on Rails"), "ROR")})

test("punctuation", () => {Assertions.assertEqual(~message="punctuation", abbreviate("First In, First Out"), "FIFO")})

test("all caps word", () => {Assertions.assertEqual(~message="all caps word", abbreviate("GNU Image Manipulation Program"), "GIMP")})

test("punctuation without whitespace", () => {Assertions.assertEqual(~message="punctuation without whitespace", abbreviate("Complementary metal-oxide semiconductor"), "CMOS")})

test("very long abbreviation", () => {Assertions.assertEqual(~message="very long abbreviation", abbreviate("Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me"), "ROTFLSHTMDCOALM")})

test("consecutive delimiters", () => {Assertions.assertEqual(~message="consecutive delimiters", abbreviate("Something - I made up from thin air"), "SIMUFTA")})

test("apostrophes", () => {Assertions.assertEqual(~message="apostrophes", abbreviate("Halley's Comet"), "HC")})

test("underscore emphasis", () => {Assertions.assertEqual(~message="underscore emphasis", abbreviate("The Road _Not_ Taken"), "TRNT")})
