export const slug = 'hello-world';

export const assertionFunctions = `let stringEqual = (~message=?, a: string, b: string) =>
  assertion(~message?, ~operator="stringEqual", (a, b) => a == b, a, b)`;

export const template = (c, moduleName) => {
  return `stringEqual(~message="${c.description}", ${moduleName}.hello(), "${c.expected}")`
}