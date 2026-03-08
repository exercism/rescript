export const slug = 'hello-world';

export const assertionFunctions = `let stringEqual = (~message=?, a: string, b: string) =>
  assertion(~message?, ~operator="stringEqual", (a, b) => a == b, a, b)`;

/**
 * @param {object} c - The canonical test case object
 * @param {string} moduleName - The PascalCase version of the slug
 */
export const template = (c, moduleName) => {
  return `test("${c.description}", () => {
  stringEqual(~message="${c.description}", ${moduleName}.hello(), "${c.expected}")
})\n\n`;
};