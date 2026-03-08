open Test

let skip = (name, _cb) => Console.log("Skipped: " ++ name)

let stringEqual = (~message=?, a: string, b: string) =>
  assertion(~message?, ~operator="stringEqual", (a, b) => a == b, a, b)

test("Say Hi!", () => {
  stringEqual(~message="Say Hi!", HelloWorld.hello(), "Hello, World!")
})
