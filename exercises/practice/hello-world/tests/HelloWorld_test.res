open Test

let stringEqual = (~message=?, a: string, b: string) =>
  assertion(~message?, ~operator="stringEqual", (a, b) => a == b, a, b)

let skip = (name, _cb) => Console.log("Skipped test: " ++ name)

test("Say Hi!", () => {
  stringEqual(~message="Say Hi!", HelloWorld.hello(), "Hello, World!")
})

skip("Say Hi Again!", () => {
  stringEqual(~message="Say Hi!", HelloWorld.hello(), "Hello, World!")
})
