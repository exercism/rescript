import { stringEqual } from "../../../../test_generator/assertions.js";

export const slug = 'two-fer';

export const assertionFunctions = [ stringEqual ]

export const template = (c) => {
  return `stringEqual(~message="${c.description}", twoFer(), "${c.expected}")`
}