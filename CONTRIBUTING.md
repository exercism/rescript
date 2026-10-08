# How to contribute to the Exercism ReScript track

## **Do you want to add an exercise?**

- **Ensure that someone else isn't already adding it** by searching the [forum](https://forum.exercism.org/c/programming/rescript) and the repository's [issues](https://github.com/exercism/rescript/issues) and [pull requests](https://github.com/exercism/rescript/pulls).

- If nobody is yet adding the exercise, [open a conversation](https://forum.exercism.org/c/programming/rescript) and indicate you'd like to add the exercise.

- Read the [Add a Practice Exercise docs](https://exercism.org/docs/building/tracks/practice-exercises/add).

### Adding a practice exercise

1. Fork the repo: `gh repo fork exercism/rescript`
2. Populate the problem-specifications submodule: `git submodule update --init --recursive`
   - Periodically refresh it: `git submodule update --remote`
3. Run the add script: `bin/add-practice-exercises -a <your-github-username> -d <difficulty> <exercise-slug>`
4. Generate the tests:
    1. Create the template for the test generator: `make add-test-template EXERCISE=<exercise-slug>`
       - this creates file `test_templates/<PascalSlug>_template.res`
       - populate it based on the default comments, and browsing other templates
    2. Build the project: `npx rescript build`
       - this will create `test_templates/<PascalSlug>_template.res.js`
    3. Generate the tests: `make generate-test EXERCISE=<exercise-slug>`
       - review the generated `exercises/practice/<exercise-slug>/tests/<PascalSlug>_test.res` file
5. Create the stub source and interface files (refer to other exercises)
    - `exercises/practice/<exercise-slug>/src/<PascalSlug>.res` -- for each function being tested, create a binding that panics
    - `exercises/practice/<exercise-slug>/src/<PascalSlug>.resi` -- define the type signature for each function
6. Write the example solution
    - copy the contents of the stub files into the `.meta/` files
    - populate the `.meta/<PascalsSlug>.res` with your example solution.
      It doesn't have to be optimal: it exists as a proof the exercise can be solved.
7. Test with `make test-one EXERCISE=<exercise-slug>`
    - Caution: if you're on a Mac, the Makefile uses GNU sed features.
      - install it with homebrew: `brew install gnu-sed`
      - then put it in your path earlier than the system sed: `mkdir -p ~/bin && PATH="$HOME/bin:$PATH" && cd ~/bin && ln -s /path/to/gsed sed && cd -`

## **Do you want to report a bug?**

- **Ensure the bug was not already reported** by searching the [forum](https://forum.exercism.org/c/programming/rescript).

- If you're unable to find an open conversation addressing the problem, [open a new one](https://forum.exercism.org/new-topic?category=rescript). Be sure to include a **title and clear description**, as much relevant information as possible, and (when possible) a **code sample**.

## **Do you want to fix a bug?**

- **Ensure that the bug is [reported](#do-you-want-to-report-a-bug)**.
  Only start fixing the bug when there is agreement on whether (and how) it should be fixed.

- Fix the bug and [submit a Pull Request](https://exercism.org/docs/building/github/contributors-pull-request-guide) to this repository.

- Ensure the PR description clearly describes the problem and solution.
  Include a link to the bug's corresponding forum conversation.

- Before submitting, please read the [Contributors Pull Request Guide](https://exercism.org/docs/building/github/contributors-pull-request-guide) and [Pull Request Guide](https://exercism.org/docs/community/being-a-good-community-member/pull-requests).

## **Do you intend to add a new feature or change an existing one?**

- **Ensure that the feature or change is discussed on the [forum](https://forum.exercism.org/c/programming/rescript).**
  Only start adding the feature or change when there is agreement on whether (and how) it should be added or changed.

- Add the feature or change and [submit a Pull Request](https://exercism.org/docs/building/github/contributors-pull-request-guide) to this repository.

- Ensure the PR description clearly describes the problem and solution.
  Include a link to the bug's corresponding forum conversation.

- Before submitting, please read the [Contributors Pull Request Guide](https://exercism.org/docs/building/github/contributors-pull-request-guide) and [Pull Request Guide](https://exercism.org/docs/community/being-a-good-community-member/pull-requests).
