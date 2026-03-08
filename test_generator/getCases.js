import { readFileSync } from 'node:fs';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';
import toml from 'toml';

const __dirname = dirname(fileURLToPath(import.meta.url));

/**
 * Retrieves and filters test cases based on the Exercism TOML config.
 * @param {string} slug - The exercise name (e.g., 'hello-world')
 */
export default function getValidCases(slug) {
  const tomlPath = join(__dirname, '..', 'exercises', 'practice', slug, '.meta', 'tests.toml');
  const jsonPath = join(__dirname, '..', 'problem-specifications', 'exercises', slug, 'canonical-data.json');

  const testMeta = toml.parse(readFileSync(tomlPath, 'utf-8'));
  const canonicalData = JSON.parse(readFileSync(jsonPath, 'utf-8'));

  const validCases = [];

  const extract = (cases) => {
    for (const testCase of cases) {
      if (testCase.cases) {
        extract(testCase.cases);
      } else {
        const { uuid } = testCase;
        const meta = testMeta[uuid];
        if (uuid && meta && meta.include !== false) {
          validCases.push(testCase);
        }
      }
    }
  };

  extract(canonicalData.cases);

  return validCases;
}