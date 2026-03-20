open Test
open PhoneNumber

let assertEqual = (~message=?, a: 'a, b: 'a) =>
  assertion(~message?, ~operator="assertEqual", (a, b) => a == b, a, b)

test("cleans the number", () => {
  assertEqual(~message="cleans the number", clean("(223) 456-7890"), Some("2234567890"))
})

test("cleans numbers with dots", () => {
  assertEqual(~message="cleans numbers with dots", clean("223.456.7890"), Some("2234567890"))
})

test("cleans numbers with multiple spaces", () => {
  assertEqual(
    ~message="cleans numbers with multiple spaces",
    clean("223 456   7890   "),
    Some("2234567890"),
  )
})

test("invalid when 9 digits", () => {
  assertEqual(~message="invalid when 9 digits", clean("123456789"), None)
})

test("invalid when 11 digits does not start with a 1", () => {
  assertEqual(~message="invalid when 11 digits does not start with a 1", clean("22234567890"), None)
})

test("valid when 11 digits and starting with 1", () => {
  assertEqual(
    ~message="valid when 11 digits and starting with 1",
    clean("12234567890"),
    Some("2234567890"),
  )
})

test("valid when 11 digits and starting with 1 even with punctuation", () => {
  assertEqual(
    ~message="valid when 11 digits and starting with 1 even with punctuation",
    clean("+1 (223) 456-7890"),
    Some("2234567890"),
  )
})

test("invalid when more than 11 digits", () => {
  assertEqual(~message="invalid when more than 11 digits", clean("321234567890"), None)
})

test("invalid with letters", () => {
  assertEqual(~message="invalid with letters", clean("523-abc-7890"), None)
})

test("invalid with punctuations", () => {
  assertEqual(~message="invalid with punctuations", clean("523-@:!-7890"), None)
})

test("invalid if area code starts with 0", () => {
  assertEqual(~message="invalid if area code starts with 0", clean("(023) 456-7890"), None)
})

test("invalid if area code starts with 1", () => {
  assertEqual(~message="invalid if area code starts with 1", clean("(123) 456-7890"), None)
})

test("invalid if exchange code starts with 0", () => {
  assertEqual(~message="invalid if exchange code starts with 0", clean("(223) 056-7890"), None)
})

test("invalid if exchange code starts with 1", () => {
  assertEqual(~message="invalid if exchange code starts with 1", clean("(223) 156-7890"), None)
})

test("invalid if area code starts with 0 on valid 11-digit number", () => {
  assertEqual(
    ~message="invalid if area code starts with 0 on valid 11-digit number",
    clean("1 (023) 456-7890"),
    None,
  )
})

test("invalid if area code starts with 1 on valid 11-digit number", () => {
  assertEqual(
    ~message="invalid if area code starts with 1 on valid 11-digit number",
    clean("1 (123) 456-7890"),
    None,
  )
})

test("invalid if exchange code starts with 0 on valid 11-digit number", () => {
  assertEqual(
    ~message="invalid if exchange code starts with 0 on valid 11-digit number",
    clean("1 (223) 056-7890"),
    None,
  )
})

test("invalid if exchange code starts with 1 on valid 11-digit number", () => {
  assertEqual(
    ~message="invalid if exchange code starts with 1 on valid 11-digit number",
    clean("1 (223) 156-7890"),
    None,
  )
})
