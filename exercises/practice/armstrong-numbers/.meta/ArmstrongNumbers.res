let isArmstrongNumber = n => {
  let digits = n->Int.toString->String.split("")->Array.filterMap(d => d->Int.fromString)
  let len = Array.length(digits)
  let sum = Array.reduce(digits, 0, (acc, digit) => digit ** len + acc)
  n == sum
}
