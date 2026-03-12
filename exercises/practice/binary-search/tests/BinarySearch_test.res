open Test
open BinarySearch

let assertEqual = (~message=?, a: 'a, b: 'a) => assertion(~message?, ~operator="assertEqual", (a, b) => a == b, a, b)

test("finds a value in an array with one element", () => {
  assertEqual(~message="finds a value in an array with one element", find([6], 6), Some(0))
})

test("finds a value in the middle of an array", () => {
  assertEqual(~message="finds a value in the middle of an array", find([1, 3, 4, 6, 8, 9, 11], 6), Some(3))
})

test("finds a value at the beginning of an array", () => {
  assertEqual(~message="finds a value at the beginning of an array", find([1, 3, 4, 6, 8, 9, 11], 1), Some(0))
})

test("finds a value at the end of an array", () => {
  assertEqual(~message="finds a value at the end of an array", find([1, 3, 4, 6, 8, 9, 11], 11), Some(6))
})

test("finds a value in an array of odd length", () => {
  assertEqual(~message="finds a value in an array of odd length", find([1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 634], 144), Some(9))
})

test("finds a value in an array of even length", () => {
  assertEqual(~message="finds a value in an array of even length", find([1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377], 21), Some(5))
})

test("identifies that a value is not included in the array", () => {
  assertEqual(~message="identifies that a value is not included in the array", find([1, 3, 4, 6, 8, 9, 11], 7), None)
})

test("a value smaller than the array's smallest value is not found", () => {
  assertEqual(~message="a value smaller than the array's smallest value is not found", find([1, 3, 4, 6, 8, 9, 11], 0), None)
})

test("a value larger than the array's largest value is not found", () => {
  assertEqual(~message="a value larger than the array's largest value is not found", find([1, 3, 4, 6, 8, 9, 11], 13), None)
})

test("nothing is found in an empty array", () => {
  assertEqual(~message="nothing is found in an empty array", find([], 1), None)
})

test("nothing is found when the left and right bounds cross", () => {
  assertEqual(~message="nothing is found when the left and right bounds cross", find([1, 2], 0), None)
})
