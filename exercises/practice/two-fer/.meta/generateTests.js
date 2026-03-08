import { fileURLToPath } from 'node:url';
import path from 'node:path';
import getValidCases from '../../../../test_generator/getCases.js';
import { generate, toPascalCase } from '../../../../test_generator/testGenerator.js';
import * as config from './testTemplate.js';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const cases = getValidCases(config.slug);
const outputPath = path.resolve(__dirname, '..', 'tests', `${toPascalCase(config.slug)}_test.res`);

generate(outputPath, config.slug, cases);