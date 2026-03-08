import fs from 'node:fs';
import path from 'node:path';
import { template, assertionFunctions } from '../exercises/practice/hello-world/.meta/testTemplate.js';

export const toPascalCase = (slug) => 
  slug.split('-').map(w => w.charAt(0).toUpperCase() + w.slice(1)).join('');

export const generate = (outputPath, slug, cases) => {
  const moduleName = toPascalCase(slug);
  
  let output = `open Test
open ${moduleName}\n\n`;

  assertionFunctions.forEach(fn => output += `${fn}\n\n`)

  cases.forEach((c) => {
    output += `test("${c.description}", () => {
  ${template(c)}
})`
  });

  if (!fs.existsSync(path.dirname(outputPath))) {
    fs.mkdirSync(path.dirname(outputPath), { recursive: true });
  }

  fs.writeFileSync(outputPath, output, 'utf-8');
  console.log(`Generated: ${path.basename(outputPath)}`);
};