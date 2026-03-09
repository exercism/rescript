import fs from 'node:fs';
import path from 'node:path';
import getValidCases from './getCases.js';

export const generateTests = (dir, slug, assertionFunctions, template) => {
    const outputPath = path.resolve(dir, '..', 'tests', `${toPascalCase(slug)}_test.res`);
    const cases = getValidCases(slug);
    generate(outputPath, slug, cases, assertionFunctions, template);
}

const toPascalCase = (slug) => 
  slug.split('-').map(w => w.charAt(0).toUpperCase() + w.slice(1)).join('');

const generate = (outputPath, slug, cases, assertionFunctions, template) => {
  const moduleName = toPascalCase(slug);
  
  let output = `open Test
open ${moduleName}\n\n`;

  if (Array.isArray(assertionFunctions)) {
    output += assertionFunctions.map(fn => fn.trim()).join('\n\n') + '\n\n';
  }

  cases.forEach((c) => {
    output += `test("${c.description}", () => {
  ${template(c)}
})\n\n`
  });

  if (!fs.existsSync(path.dirname(outputPath))) {
    fs.mkdirSync(path.dirname(outputPath), { recursive: true });
  }

  fs.writeFileSync(outputPath, output, 'utf-8');
  console.log(`Generated: ${path.basename(outputPath)}`);
};