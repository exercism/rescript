open Test
open SpaceAge

let floatEqual = (~message=?, ~digits=2, a: float, b: float) => {
  let tolerance = 10.0 ** -.Float.fromInt(digits)
  assertion(
    ~message?,
    ~operator="floatEqual",
    (a, b) => Math.abs(a -. b) <= tolerance,
    a,
    b,
  )
}

test("age on Earth", () => {
  floatEqual(~message="age on Earth", age(Earth, 1000000000), 31.69)
})

test("age on Mercury", () => {
  floatEqual(~message="age on Mercury", age(Mercury, 2134835688), 280.88)
})

test("age on Venus", () => {
  floatEqual(~message="age on Venus", age(Venus, 189839836), 9.78)
})

test("age on Mars", () => {
  floatEqual(~message="age on Mars", age(Mars, 2129871239), 35.88)
})

test("age on Jupiter", () => {
  floatEqual(~message="age on Jupiter", age(Jupiter, 901876382), 2.41)
})

test("age on Saturn", () => {
  floatEqual(~message="age on Saturn", age(Saturn, 2000000000), 2.15)
})

test("age on Uranus", () => {
  floatEqual(~message="age on Uranus", age(Uranus, 1210123456), 0.46)
})

test("age on Neptune", () => {
  floatEqual(~message="age on Neptune", age(Neptune, 1821023456), 0.35)
})
