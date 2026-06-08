import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { dictEqual } from "../../../../test_generator/assertions.js";
import { generateTests } from '../../../../test_generator/testGenerator.js';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const slug = path.basename(path.resolve(__dirname, '..'))

export const assertionFunctions = [dictEqual]

export const template = (c) => {
  const entries = Object.entries(c.expected)
    .sort(([a], [b]) => a.localeCompare(b))
    .map(([k, v]) => `"${k}": ${v}`)

  const sentence = c.input.sentence.replace(/\n/g, '\\n')

  const actual = `countWords("${sentence}")`
  let expected = `dict{${entries.join(', ')}}`
  const asserted = `dictEqual(~message="${c.description}", ${actual}, ${expected})`
  if (asserted.length <= 80) {
    return asserted
  }

  expected = expected.length <= 40
    ? expected
    : `dict{\n      ${entries.join(',\n      ')},\n    }`

  return `dictEqual(
    ~message="${c.description}",
    ${actual},
    ${expected},
  )`
}

generateTests(__dirname, slug, assertionFunctions, template)
