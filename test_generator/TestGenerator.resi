type assertionTag = Equal | DeepEqual | Throws

let generateTests: (string, GetCases.case => string, array<assertionTag>) => unit
