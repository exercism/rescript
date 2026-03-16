// @module("node:path") external join: array<string> => string = "join"
@module("node:path") @variadic external join: array<string> => string = "join"
@module("node:path") external resolve: (string, string) => string = "resolve"
@module("node:path") external resolve3: (string, string, string) => string = "resolve"
@module("node:path") external resolve4: (string, string, string, string) => string = "resolve"
@module("node:path") external dirname: string => string = "dirname"
@module("node:path") external basename: string => string = "basename"

@module("node:fs") external readFileSync: (string, string) => string = "readFileSync"
@module("node:fs") external writeFileSync: (string, string, string) => unit = "writeFileSync"
@module("node:fs") external existsSync: string => bool = "existsSync"
@module("node:fs") external mkdirSync: (string, {"recursive": bool}) => unit = "mkdirSync"

@module("node:url") external fileURLToPath: string => string = "fileURLToPath"
