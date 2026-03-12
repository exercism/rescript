open Test
open Leap

let assertEqual = (~message=?, a: 'a, b: 'a) => assertion(~message?, ~operator="assertEqual", (a, b) => a == b, a, b)

test("year not divisible by 4 in common year", () => {
  assertEqual(~message="year not divisible by 4 in common year", isLeapYear(2015), false)
})

test("year divisible by 2, not divisible by 4 in common year", () => {
  assertEqual(~message="year divisible by 2, not divisible by 4 in common year", isLeapYear(1970), false)
})

test("year divisible by 4, not divisible by 100 in leap year", () => {
  assertEqual(~message="year divisible by 4, not divisible by 100 in leap year", isLeapYear(1996), true)
})

test("year divisible by 4 and 5 is still a leap year", () => {
  assertEqual(~message="year divisible by 4 and 5 is still a leap year", isLeapYear(1960), true)
})

test("year divisible by 100, not divisible by 400 in common year", () => {
  assertEqual(~message="year divisible by 100, not divisible by 400 in common year", isLeapYear(2100), false)
})

test("year divisible by 100 but not by 3 is still not a leap year", () => {
  assertEqual(~message="year divisible by 100 but not by 3 is still not a leap year", isLeapYear(1900), false)
})

test("year divisible by 400 is leap year", () => {
  assertEqual(~message="year divisible by 400 is leap year", isLeapYear(2000), true)
})

test("year divisible by 400 but not by 125 is still a leap year", () => {
  assertEqual(~message="year divisible by 400 but not by 125 is still a leap year", isLeapYear(2400), true)
})

test("year divisible by 200, not divisible by 400 in common year", () => {
  assertEqual(~message="year divisible by 200, not divisible by 400 in common year", isLeapYear(1800), false)
})
