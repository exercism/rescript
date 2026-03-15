import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { assertEqual } from "../../../../test_generator/assertions.js";
import { generateTests } from '../../../../test_generator/testGenerator.js';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const slug = path.basename(path.resolve(__dirname, '..'))

export const assertionFunctions = [assertEqual]

const float = n => Number.isInteger(n) ? `${n}.0` : `${n}`

const point = ({x, y, angle}) =>
  `{x: ${float(x)}, y: ${float(y)}, angle: ${float(angle)}}`

export const template = (c) => {
  const lines = []
  lines.push(`let start: point = ${point(c.input.start)}`)

  if (c.input.prisms.length <= 1) {
    const inner = c.input.prisms.map(p => `{id: ${p.id}, point: ${point(p)}}`).join(', ')
    lines.push(`let prisms: array<prism> = [${inner}]`)
  } else {
    lines.push('let prisms: array<prism> = [')
    for (const p of c.input.prisms)
      lines.push(`    {id: ${p.id}, point: ${point(p)}},`)
    lines.push('  ]')
  }

  lines.push('let result = findSequence(start, prisms)')

  const seq = c.expected.sequence
  if (seq.length <= 10) {
    lines.push(`let expected = [${seq.join(', ')}]`)
  } else {
    lines.push('let expected = [')
    for (let i = 0; i < seq.length; i += 10)
      lines.push('    ' + seq.slice(i, i + 10).join(', ') + ',')
    lines.push('  ]')
  }

  lines.push(`assertEqual(~message="${c.description}", result, expected)`)
  return lines.join('\n  ')
}

generateTests(__dirname, slug, assertionFunctions, template)
