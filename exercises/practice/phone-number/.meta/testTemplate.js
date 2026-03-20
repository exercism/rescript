import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { assertEqual } from "../../../../test_generator/assertions.js";
import { generateTests } from '../../../../test_generator/testGenerator.js';
import { type } from 'node:os';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const slug = path.basename(path.resolve(__dirname, '..'))

// EDIT THIS WITH YOUR ASSERTIONS
export const assertionFunctions = [ assertEqual ]

// EDIT THIS WITH YOUR TEST TEMPLATES
export const template = (c) => {
  const expected = typeof c.expected == 'string'
  ? `Some("${c.expected}")`
  : "None"

  return `assertEqual(~message="${c.description}", clean("${c.input.phrase}"), ${expected})`
}

generateTests(__dirname, slug, assertionFunctions, template)