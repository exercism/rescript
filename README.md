# Exercism ReScript Track

[![Configlet](https://github.com/exercism/rescript/actions/workflows/configlet.yml/badge.svg)](https://github.com/exercism/rescript/actions/workflows/configlet.yml) [![Test](https://github.com/exercism/rescript/actions/workflows/test.yml/badge.svg)](https://github.com/exercism/rescript/actions/workflows/test.yml)

Exercism exercises in ReScript.

## Installation

The exercises in this langauge are written in [ReScript] v12.

### Prerequisites

- [Node.js] >= 22
- A package manager of your choice e.g. NPM (pre-installed with Node.js), PNPM etc.
- [make](https://www.gnu.org/software/make/) - look up OS specific installation guides

### Setting up the development environment

Make a fork of the ReScript languge track GitHub [repository]. Clone your fork onto your machine:

```shell
# assuming you didn't change the repository name
git clone https://github.com/<your-username>/rescript.git
cd rescript
vscode .
```

Run the following commands from inside to install the required tools:

```shell
npm install
git submodule update --init --recursive
```

If you have format on save enabled for JSON files, it is recommended to disable this feature. Alternatively save JSON files with `Ctrl+K s` to save without applying formatting rules.

### Running the development environment

Open up two terminals. By running the commands below, files will compile on save and re-run the test suite.

```shell
# Terminal 1
npm run res:start

# Terminal 2
npm run test
```

## Coding Style

Use `PascalCase.res` for Reason implementation file names.
A ReScript interface file (`.resi`) should be included with every exercise to help the user get started.

Run `make format` on your code before pushing.

If you are using VS Code, install the official [ReScript VS Code extension](https://marketplace.visualstudio.com/items?itemName=chenglou92.rescript-vscode) for syntax highlighting and code formatting.

## Adding Exercises

New practice exercises can be added via:

```shell
bin/add-practice-exercise <exercise-slug>

# Optionally, you can also specify the exercise's difficulty (via `-d`) and/or author's GitHub username (via `-a`):
bin/add-practice-exercise -a foobar -d 3 <exercise-slug>
```

Now complete the following steps:

- `config.json` - ensure that the new exercise data is correctly placed in order of difficulty and then alphabetically within that difficulty rating.
- implement exercise test cases, detailed in the [testing](#testing) section below.
- `exercises/practice/<exercise-slug>/.meta/<exercise-name>.res` - write an example of code here that will pass all test cases. This does not need to be the finest example of how to complete this exercise, but it must pass all the test cases. Update the interface file with the exposed function signatures in the `.resi` file.
- `exercises/practice/<exercise-slug>/wrc/<exercise-name>.res` - create an exercise stub here which returns `panic("'<function-name>' has not been implemented")`. Update the interface file with the function signatures, so that the student has a reference to what names and types are used.

## Testing

Tests are written using [rescript-test](https://bloodyowl.github.io/rescript-test/). There is a test templating system in place to reduce the amount of work needed by a developer. Follow these steps when writing tests:

- `exercises/practice/<exercise-slug>/.meta/tests.toml` - if any of these test cases are not relevant to the language, add `ignore = true` on a newline below the description
- `exercises/practice/<exercise-slug>/.meta/testTemplate.js` - edit this file to allow the test generator to automatically create test files.
  - you must write your comparator functions - https://bloodyowl.github.io/rescript-test/assertions.
  - common assertions with comparator functions are located at `test_generator/assertions.js`. Pass the required ones into the `assertionFunctions` array.
  - edit the `template` function so that it will generate the test cases. The `c` variable refers to a test case in `problem-specifications/exercises/<exercise-slug>/canonical-data.json`. Look at other exercise test templates for inspiration.

Run all exercise tests:

```shell
make test
```

This command will iterate over all exercises and check to see if their example implementation passes all the tests.

To test that all exercises will pass in the CI/CD environment, run:

```shell
./bin/verify-exercises

# test a single exercise:
./bin/verify-exercises <exercise-slug>
```

<!-- ### Using Docker

If your track has a working [test runner](https://exercism.org/docs/building/tooling/test-runners), the `./bin/verify-exercises-in-docker` script can also be used to test all exercises.
This script pulls (_downloads_) the test runner's [Docker image](https://exercism.org/docs/building/tooling/test-runners/docker) and then uses Docker to run that image to test an exercise.

```exercism/note
The main benefit of this approach is that it best mimics how exercises are tested in production (on the website).
Another benefit is that you don't have to install track-specific dependencies (e.g. an SDK) locally, you just need Docker installed.
```

To test a single exercise, run `./bin/verify-exercises-in-docker <exercise-slug>`. -->

## Linting & Formatting

[`configlet`](https://exercism.org/docs/building/configlet) is an Exercism-wide tool for working with tracks. You can download it by running:

```shell
./bin/fetch-configlet
```

Run the [`lint` command][configlet-link-link] to verify if exercises have the required files and if config files are correct. Address any issues before pushing your changes:

```shell
./bin/configlet lint
```

Run the [`fmt` command][configlet-fmt-link] to verify if exercises and configuration files are formatted correctly. Address any issues before pushing your changes:

```shell
./bin/configlet fmt

# check a single exercise
./bin/configlet -e <exercise-slug>

# auto format files
./bin/configlet fmt -u
```

If you are auto formatting files, only commit the files relevant to your pull request.

[ReScript]: https://rescript-lang.org/
[Node.js]: https://nodejs.org/
[repository]: https://github.com/exercism/rescript
[configlet-lint-link]: https://exercism.org/docs/building/configlet/lint
[configlet-fmt-link]: https://exercism.org/docs/building/configlet/fmt
