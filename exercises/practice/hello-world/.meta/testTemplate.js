import { stringEqual } from "../../../../test_generator/assertions.js";

export const slug = 'hello-world';

export const assertionFunctions = [ stringEqual ]

export const template = (c, moduleName) => {
  return `stringEqual(~message="${c.description}", hello(), "${c.expected}")`
}