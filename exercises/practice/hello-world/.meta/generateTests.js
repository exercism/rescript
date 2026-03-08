import { fileURLToPath } from 'node:url';
import path from 'node:path';
import getValidCases from '../../../../test_generator/getCases.js';
import { generate, toPascalCase } from '../../../../test_generator/testGenerator.js';
import { slug, assertionFunctions, template } from './testTemplate.js';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const cases = getValidCases(slug);
const outputPath = path.resolve(__dirname, '..', 'tests', `${toPascalCase(slug)}_test.res`);

generate(outputPath, slug, cases, assertionFunctions, template);