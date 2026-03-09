import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { stringEqual } from "../../../../test_generator/assertions.js";
import { generateTests } from '../../../../test_generator/testGenerator.js';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const slug = path.basename(path.resolve(__dirname, '..'))

// EDIT THIS WITH YOUR ASSERTIONS
export const assertionFunctions = [ stringEqual ]

// EDIT THIS WITH YOUR TEST TEMPLATES
export const template = (c) => {
  if (c.input.name) {
    return `stringEqual(~message="${c.description}", twoFer(Some("${c.input.name}")), "${c.expected}")`
  } else {
    return `stringEqual(~message="${c.description}", twoFer(None), "${c.expected}")`
  } 
}

generateTests(__dirname, slug, assertionFunctions, template)