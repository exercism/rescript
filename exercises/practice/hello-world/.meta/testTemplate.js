export const slug = 'hello-world';

export const assertionFunctions = `let stringEqual = (~message=?, a: string, b: string) =>
  assertion(~message?, ~operator="stringEqual", (a, b) => a == b, a, b)`;

/**
 * @param {string} testMethod - 'test' or 'skip'
 * @param {object} c - The canonical test case object
 * @param {string} moduleName - The PascalCase version of the slug
 */
export const template = (testMethod, c, moduleName) => {
  return `${testMethod}("${c.description}", () => {
  stringEqual(~message="${c.description}", ${moduleName}.hello(), "${c.expected}")
})\n\n`;
};