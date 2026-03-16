let equalSource = "equal(~message, ~actual, ~expected)"

let equal = (~message, ~actual, ~expected) => {
  `equal(~message="${message}", ${actual}, ${expected})`
}
