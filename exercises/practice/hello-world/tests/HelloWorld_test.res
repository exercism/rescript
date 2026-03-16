open Test
open HelloWorld

test("Say Hi!", () => {Assertions.assertEqual(~message="Say Hi!", hello(), "Hello, World!")})
