// Abstracted form of comparator functions, so we can generate the string that the user sees in the test

let equal = (~message, ~actual, ~expected) => {
  `equal(~message="${message}", ${actual}, ${expected})`
}
