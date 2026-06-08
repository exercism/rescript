let sum = num => (num * (num + 1)) / 2

let squareOfSum = num => sum(num) * sum(num)

let sumOfSquares = num => (num * (num + 1) * ((2 * num) + 1)) / 6

let differenceOfSquares = num => squareOfSum(num) - sumOfSquares(num)