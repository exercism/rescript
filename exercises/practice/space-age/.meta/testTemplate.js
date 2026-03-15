import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { floatEqual } from "../../../../test_generator/assertions.js";
import { generateTests } from '../../../../test_generator/testGenerator.js';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const slug = path.basename(path.resolve(__dirname, '..'))

// EDIT THIS WITH YOUR ASSERTIONS
export const assertionFunctions = [ floatEqual ]

// EDIT THIS WITH YOUR TEST TEMPLATES
export const template = (c) => {
  const { planet, seconds } = c.input

  return `floatEqual(~message="${c.description}", age(${planet}, ${seconds}), ${c.expected})`
}

generateTests(__dirname, slug, assertionFunctions, template)