import path from 'node:path';
import { fileURLToPath } from 'node:url';
const __dirname = path.dirname(fileURLToPath(import.meta.url));
import { stringEqual } from "../../../../test_generator/assertions.js";

export const slug = path.basename(path.resolve(__dirname, '..'))

export const assertionFunctions = [ stringEqual ]

export const template = (c) => {
  if (c.input.name) {
    return `stringEqual(~message="${c.description}", twoFer(Some("${c.input.name}")), "${c.expected}")`
  } else {
    return `stringEqual(~message="${c.description}", twoFer(None), "${c.expected}")`
  } 
}