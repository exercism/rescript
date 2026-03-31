# Exercism ReScript Track

[![Configlet](https://github.com/exercism/rescript/actions/workflows/configlet.yml/badge.svg)](https://github.com/exercism/rescript/actions/workflows/configlet.yml) [![Test](https://github.com/exercism/rescript/actions/workflows/test.yml/badge.svg)](https://github.com/exercism/rescript/actions/workflows/test.yml)

Exercism exercises in ReScript.

## Installation

Track exercises target [Rescript] 12.2.0 using the [ReScript Test][ReScriptTest] testing framework on [Node.js] 22+. If you're contributing to the track, you will also need [make](https://www.gnu.org/software/make/).

### Setting up the development environment

Run the following commands from inside the project root directory to install the required tools:

```shell
npm install
git submodule update --init --recursive # add/update a local copy of the problem-specification submodule
```

To automate the creation of practice exercise tests, our track tooling consumes data from the the [problem specifications][exercism-problem-specifications-link] submodule. Because these specifications serve as the canonical source for all Exercism tracks, any upstream updates ensure our test cases remain consistent with the global exercise standard.

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
A ReScript [interface file][rescript-interface-file-link] (`.resi`) should be included with every exercise to help the user get started.
For example:

```shell
# exercises/practice/<exercise-name>/.meta/Example.resi
let add: (int, int) => int
```

Run `make format` on your code before pushing.

If you are using VS Code, install the official [ReScript VS Code extension](https://marketplace.visualstudio.com/items?itemName=chenglou92.rescript-vscode) for syntax highlighting and code formatting. Unofficial plugins exist for JetBrains products.
Terminal based text editors often work with the [ReScript Language Server][rescript-language-server-link] installed. Refer to the documentation of your text editor / IDE for further instructions

## Adding Exercises

Documentation on contributing to Exercism can be found [here][exercism-contributing-docs-link].

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
- `exercises/practice/<exercise-slug>/src/<exercise-name>.res` - create an exercise stub here which returns `panic("'<function-name>' has not been implemented")`. Update the interface file with the function signatures, so that the student has a reference to what names and types are used.

## Testing

Tests are written using [rescript-test](https://bloodyowl.github.io/rescript-test/). There is a test templating system in place to reduce the amount of work needed by a developer. Follow these steps when writing tests:

- `exercises/practice/<exercise-slug>/.meta/tests.toml` - if any of these test cases are not relevant to the language, add `ignore = true` on a newline below the description
- `exercises/practice/<exercise-slug>/.meta/testTemplate.js` - edit this file to allow the test generator to automatically create test files.
  - you must write your comparator functions - https://bloodyowl.github.io/rescript-test/assertions.
  - common assertions with comparator functions are located at `test_generator/assertions.js`. Pass the required ones into the `assertionFunctions` array.
  - edit the `template` function so that it will generate the test cases. The `c` variable refers to a test case in `problem-specifications/exercises/<exercise-slug>/canonical-data.json`. Look at other exercise test templates for inspiration.

Run all exercise's tests:

```shell
make test
```

This command will iterate over all exercises and check to see if their example implementation passes all the tests.

To test that the example solution will pass the test suite, run:

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
./bin/configlet fmt -e <exercise-slug>

# auto format files
./bin/configlet fmt -u
```

If you are auto formatting files, only commit the files relevant to your pull request.

## Pull Requests

Familiarise yourself with the Exercism [documentation][exercism-pr-docs-link] on pull requests.

Make sure your work is commited on a new branch. When you are ready to submit your changes, push your changes to your forked repository and open a pull request on the language track [repository].

More details on how to create pull requests from a fork can be found [here][github-fork-pr-link].

## Feedback

If you find this documentation is inaccurate or incomplete, or can be improved in any way, please don't hesitate to raise an [issue][issue-link] or submit a pull request.

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
[rescript-language-server-link]: https://www.npmjs.com/package/@rescript/language-server
[rescript-interface-file-link]: https://rescript-lang.org/docs/manual/module#every-resi-file-is-a-signature
