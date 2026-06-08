import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { assertEqual } from "../../../../test_generator/assertions.js";
import { generateTests } from '../../../../test_generator/testGenerator.js';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const slug = path.basename(path.resolve(__dirname, '..'))

// EDIT THIS WITH YOUR ASSERTIONS
export const assertionFunctions = [ assertEqual ]

// EDIT THIS WITH YOUR TEST TEMPLATES
export const template = (c) => {
  const { array, value } = c.input
  const expected = c.expected

  const arrayStr = `[${array.join(', ')}]`

  const expectedStr = (typeof expected === 'number')
    ? `Some(${expected})`
    : "None"

  return `assertEqual(~message="${c.description}", find(${arrayStr}, ${value}), ${expectedStr})`
}

generateTests(__dirname, slug, assertionFunctions, template)