import { stringEqual } from "../../../../test_generator/assertions.js";

export const slug = 'two-fer';

export const assertionFunctions = [ stringEqual ]

export const template = (c) => {
  if (c.input.name) {
    return `stringEqual(~message="${c.description}", twoFer(Some("${c.input.name}")), "${c.expected}")`
  } else {
    return `stringEqual(~message="${c.description}", twoFer(None), "${c.expected}")`
  } 
}