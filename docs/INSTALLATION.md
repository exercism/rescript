# Installation

This track uses ReScript 12 and relies on [Node.js][nodejs] 22 or greater.
Many systems will have this pre-installed or you may have previously installed it for another track.

Open a terminal and run:

```sh
node -v
```

If Node isn't installed or an older version is listed, please follow [the official Node.js installation][nodejs-install] instructions for your platform.

## Installing dependencies

Each ReScript exercise is a self-contained npm project.
After downloading an exercise with the [Exercism CLI][exercism-cli], install the project dependencies including ReScript and you're ready to go:

```sh
cd /path/to/exercise
npm install
```

## Editor support

The ReScript Project maintains a [list of both official and community-supported editor plugins][rescript-plugins].

[nodejs]: https://nodejs.org/
[nodejs-install]: https://nodejs.org/en/download
[exercism-cli]: https://github.com/exercism/cli
[rescript-plugins]: https://rescript-lang.org/docs/manual/editor-plugins
