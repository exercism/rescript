# Exercism ReScript Track

[![Configlet](https://github.com/exercism/rescript/actions/workflows/configlet.yml/badge.svg)](https://github.com/exercism/rescript/actions/workflows/configlet.yml)
[![Test](https://github.com/exercism/rescript/actions/workflows/test.yml/badge.svg)](https://github.com/exercism/rescript/actions/workflows/test.yml)

Exercism exercises in ReScript.

## Installation

Track exercises target [ReScript] 12.2.0 using the [ReScript Test][ReScriptTest] testing framework on [Node.js] 22+. If you're contributing to the track, you will also need [make].

### Setting up the development environment

Run the following commands from inside the project root directory to install the required tools:

```shell
npm install
git submodule update --init --recursive # add/update a local copy of the problem-specification submodule
```

To automate the creation of practice exercise tests, our track tooling consumes data from the the [problem specifications][exercism-problem-specifications-link] submodule. Because these specifications serve as the canonical source for all Exercism tracks, any upstream updates ensure our test cases remain consistent with the global exercise standard.

If you have format on save enabled for JSON files, it is recommended to disable this feature. Alternatively save JSON files with `Ctrl+K s` to save without applying formatting rules.

## Running the development environment

Open up two terminals. By running the commands below, files will compile on save and re-run the test suite.

```shell
# Terminal 1
npm run res:start

# Terminal 2
npm run test
```

## Adding Exercises

Documentation on contributing to Exercism can be found [here][exercism-contributing-docs-link].

New practice exercises can be added via:

```shell
bin/add-practice-exercise <exercise-slug>

# Optionally, you can also specify the exercise's difficulty (via `-d`) and/or author's GitHub username (via `-a`):
bin/add-practice-exercise -a foobar -d 3 <exercise-slug>
```

Now complete the following steps:

- Ensure that the new exercise data is correctly placed in order of difficulty and then alphabetically within that difficulty rating - `config.json`
- Implement exercise test cases, detailed in the [testing](#testing) section below - `templates/Test_template.res`
- Write an example of code here that will pass all test cases. This does not need to be the finest example of how to complete this exercise, but it must pass all the test cases - `exercises/practice/<exercise-slug>/.meta/<exercise-name>.res`
- Update the example solution's interface file with the function signatures - `exercises/practice/<exercise-slug>/.meta/<exercise-name>.reso`
- Create an exercise stub which returns `panic("'<function-name>' has not been implemented")` - `exercises/practice/<exercise-slug>/src/<exercise-name>.res`
- Update the exercise stub's interface file with the exposed function signatures so that the student has a reference to what names and types are used - `exercises/practice/<exercise-slug>/src/<exercise-name>.resi`

## Testing

Tests are written using [rescript-test][ReScriptTest]. There is a test templating system in place to reduce the amount of work needed by a developer. Follow these steps when writing tests:

- `exercises/practice/<exercise-slug>/.meta/tests.toml` - if any of these test cases are not relevant to the language, add `ignore = true` on a newline below the description
- `test_templates/<Exercise>_template.res` - edit this file to allow the test generator to automatically create test files. If this file does not exist, copy `templates/Test_template.res` and rename to match the aforementioned filename.
  - you must write your comparator functions - https://bloodyowl.github.io/rescript-test/assertions.
  - common assertions with comparator functions are located at `test_generator/Assertions.res`. Add the ones you'd like to use to the `generateTests` function's last argument, eg `TestGenerator.generateTests(slug, template, [DictEqual])`.
  - edit the `template` function so that it will generate the test cases. The `case` parameter refers to a test case in `problem-specifications/exercises/<exercise-slug>/canonical-data.json`. Refer to other exercise test templates for inspiration.

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

## Coding Style

Use `PascalCase.res` for ReScript implementation file names.
A ReScript interface file (`.resi`) should be included with every exercise to help the user get started.

Run `make format` on your code before pushing.

If you are using VS Code, install the official [ReScript VS Code extension][rescript-vs-code-extension] for syntax highlighting and code formatting.

## Linting & Formatting

[`configlet`][configlet] is an Exercism-wide tool for working with tracks. You can download it by running:

```shell
./bin/fetch-configlet
```

Run the [`lint` command][configlet-link-link] to verify if exercises have the required files and if config files are correct. Address any issues before pushing your changes:

```shell
./bin/configlet lint
```

Run the [`fmt` command][configlet-fmt-link] to verify if the configuration files are formatted correctly. Address any issues before pushing your changes:

```shell
./bin/configlet fmt

# check a single exercise
./bin/configlet fmt -e <exercise-slug>

# auto format files
./bin/configlet fmt -uy
```

If you are auto formatting files, only commit the files relevant to your pull request.

## Feedback

If you find this documentation is inaccurate or incomplete, or can be improved in any way, please don't hesitate to create a new topic on the [Exercism Forum][exercism-forum]

[ReScript]: https://rescript-lang.org/
[ReScriptTest]: https://bloodyowl.github.io/rescript-test/
[Node.js]: https://nodejs.org/
[repository]: https://github.com/exercism/rescript
[issue-link]: https://github.com/exercism/rescript/issues
[configlet-lint-link]: https://exercism.org/docs/building/configlet/lint
[configlet-fmt-link]: https://exercism.org/docs/building/configlet/fmt
[github-fork-pr-link]: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork
[exercism-pr-docs-link]: https://exercism.org/docs/building/github/contributors-pull-request-guide
[exercism-contributing-docs-link]: https://exercism.org/docs/building
[exercism-problem-specifications-link]: https://github.com/exercism/problem-specifications
[configlet]: https://exercism.org/docs/building/configlet
[make]: https://www.gnu.org/software/make/
[rescript-vs-code-extension]: https://marketplace.visualstudio.com/items?itemName=chenglou92.rescript-vscode
[exercism-forum]: https://forum.exercism.org/
