open Test
open EliudsEggs

let assertEqual = (~message=?, a: 'a, b: 'a) => assertion(~message?, ~operator="assertEqual", (a, b) => a == b, a, b)

test("0 eggs", () => {
  assertEqual(~message="0 eggs", eggCount(0), 0)
})

test("1 egg", () => {
  assertEqual(~message="1 egg", eggCount(16), 1)
})

test("4 eggs", () => {
  assertEqual(~message="4 eggs", eggCount(89), 4)
})

test("13 eggs", () => {
  assertEqual(~message="13 eggs", eggCount(2000000000), 13)
})
