# Running the Tests

## Download an Exercise

Use the [Exercism CLI][cli] to download the exercise you want to work on.

```sh
exercism download --track=rescript --exercise=hello-world
```

Then change into the exercise directory.

```sh
cd /path/to/exercism/rescript/hello-world
```

## Install Dependencies

Before running the tests, install the exercise dependencies.

```sh
npm install
```

## Run the Tests

Compile and run the provided test suite using either `exercism test` or `npm install`.

## Understanding Test Results

The test runner shows each test run with a pass/fail status.

```text
1/3: no name given
  PASS - no name given
2/3: a name given
  FAIL - a name given
    ---
    operator: equal
    left:  One for you, one for me.
    right: One for Alice, one for me.
    ...
3/3: another name given
  FAIL - another name given
    ---
    operator: equal
    left:  One for you, one for me.
    right: One for Bob, one for me.
    ...

# Ran 3 tests (3 assertions)
# 1 passed
# 2 failed
```

`left` is what your code returned. `right` is what the test expected.

## Understanding the Exercise Structure

```text
two-fer/
├── src/
│   ├── TwoFer.res   // your solution goes here
│   └── TwoFer.resi  // the optional interface file containing signatures
├── tests/
│   └── TwoFer_test.res // your test suite
├── package.json // used to install project dependencies
└── ...
```

`TwoFer.resi` here is an optional interface file.
When present, it defines the function signatures your solution must satisfy and can serve as a hint for what to implement.

For example, if the interface declares:

```rescript
let hello: unit => string
```

Your implementation should define:

```rescript
let hello = () => "Hello, World!"
```

## Compiler Errors

If your code doesn't compile, ReScript's compiler produces detailed error messages with the exact location and expected types.

```text
  We've found a bug for you!

  1 │ let x: string = 42

  This has type: int
  But it's expected to have type: string

  You can convert int to string with Int.toString.
```

Read the error message carefully because it usually points directly to the problem.

[cli]: https://exercism.org/docs/using/solving-exercises/working-locally
