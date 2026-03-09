import path from 'node:path';
import getValidCases from './getCases.js';
import { generate, toPascalCase } from './testGenerator.js';

export const generateTests = (dir, slug, assertionFunctions, template) => {
    const outputPath = path.resolve(dir, '..', 'tests', `${toPascalCase(slug)}_test.res`);
    const cases = getValidCases(slug);
    generate(outputPath, slug, cases, assertionFunctions, template);
}

