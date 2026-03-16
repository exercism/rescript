open Test
open Assertions
open HelloWorld

test("Say Hi!", () => {assertEqual(~message="Say Hi!", hello(), "Hello, World!")})
