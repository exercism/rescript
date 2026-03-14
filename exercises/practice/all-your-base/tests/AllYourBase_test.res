open Test
open AllYourBase

let assertEqual = (~message=?, a: 'a, b: 'a) =>
  assertion(~message?, ~operator="assertEqual", (a, b) => a == b, a, b)

test("single bit one to decimal", () => {
  assertEqual(~message="single bit one to decimal", rebase(2, [1], 10), Some([1]))
})

test("binary to single decimal", () => {
  assertEqual(~message="binary to single decimal", rebase(2, [1, 0, 1], 10), Some([5]))
})

test("single decimal to binary", () => {
  assertEqual(~message="single decimal to binary", rebase(10, [5], 2), Some([1, 0, 1]))
})

test("binary to multiple decimal", () => {
  assertEqual(
    ~message="binary to multiple decimal",
    rebase(2, [1, 0, 1, 0, 1, 0], 10),
    Some([4, 2]),
  )
})

test("decimal to binary", () => {
  assertEqual(~message="decimal to binary", rebase(10, [4, 2], 2), Some([1, 0, 1, 0, 1, 0]))
})

test("trinary to hexadecimal", () => {
  assertEqual(~message="trinary to hexadecimal", rebase(3, [1, 1, 2, 0], 16), Some([2, 10]))
})

test("hexadecimal to trinary", () => {
  assertEqual(~message="hexadecimal to trinary", rebase(16, [2, 10], 3), Some([1, 1, 2, 0]))
})

test("15-bit integer", () => {
  assertEqual(~message="15-bit integer", rebase(97, [3, 46, 60], 73), Some([6, 10, 45]))
})

test("empty list", () => {
  assertEqual(~message="empty list", rebase(2, [], 10), Some([0]))
})

test("single zero", () => {
  assertEqual(~message="single zero", rebase(10, [0], 2), Some([0]))
})

test("multiple zeros", () => {
  assertEqual(~message="multiple zeros", rebase(10, [0, 0, 0], 2), Some([0]))
})

test("leading zeros", () => {
  assertEqual(~message="leading zeros", rebase(7, [0, 6, 0], 10), Some([4, 2]))
})

test("input base is one", () => {
  assertEqual(~message="input base is one", rebase(1, [0], 10), None)
})

test("input base is zero", () => {
  assertEqual(~message="input base is zero", rebase(0, [], 10), None)
})

test("input base is negative", () => {
  assertEqual(~message="input base is negative", rebase(-2, [1], 10), None)
})

test("negative digit", () => {
  assertEqual(~message="negative digit", rebase(2, [1, -1, 1, 0, 1, 0], 10), None)
})

test("invalid positive digit", () => {
  assertEqual(~message="invalid positive digit", rebase(2, [1, 2, 1, 0, 1, 0], 10), None)
})

test("output base is one", () => {
  assertEqual(~message="output base is one", rebase(2, [1, 0, 1, 0, 1, 0], 1), None)
})

test("output base is zero", () => {
  assertEqual(~message="output base is zero", rebase(10, [7], 0), None)
})

test("output base is negative", () => {
  assertEqual(~message="output base is negative", rebase(2, [1], -7), None)
})

test("both bases are negative", () => {
  assertEqual(~message="both bases are negative", rebase(-2, [1], -7), None)
})
