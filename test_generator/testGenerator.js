import fs from 'node:fs';
import path from 'node:path';

export const toPascalCase = (slug) => 
  slug.split('-').map(w => w.charAt(0).toUpperCase() + w.slice(1)).join('');

export const generate = (outputPath, slug, cases, config) => {
  const moduleName = toPascalCase(slug);
  
  let output = `open Test\n\n`;
  output += `let skip = (name, _cb) => Console.log("Skipped: " ++ name)\n\n`;
  output += `${config.assertionFunctions}\n\n`;

  cases.forEach((c, index) => {
    const method = index === 0 ? "test" : "skip";
    output += config.template(method, c, moduleName);
  });

  if (!fs.existsSync(path.dirname(outputPath))) {
    fs.mkdirSync(path.dirname(outputPath), { recursive: true });
  }

  fs.writeFileSync(outputPath, output, 'utf-8');
  console.log(`Generated: ${path.basename(outputPath)}`);
};