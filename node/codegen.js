#!/usr/bin/env node

const { metacall, metacall_load_from_file } = require('metacall');
const fs = require('fs');
const path = require('path');

const types = {
	Boolean: 'bool',
	Number: 'float',
	String: 'str',
};

const script = (body) =>
`import sys
import builtins
${body}
`;

const func = (name, signature, asserts, ret) =>
`def ${name}(${signature.join(', ')}):
	${asserts} # and sys.exit(1)
	return ${ret}
`;

const assert = (variable, literal, type) =>
	`(${variable} != ${literal})`;

/* TODO: Implement types */
/*	`(${variable} != ${literal} or type(${variable}) != builtins.${type})`;*/

const names = (prefix, size) =>
	Array.from(new Array(size), (_, index) => `${prefix}${index}`);

const params = names('a', 3);

const signatures = params.map((_, size) => params.slice(0, size).map((_, index) => params[index]));

const assertions = signatures.map(s => s.map(arg => assert(arg, 5.0, 'float' /* TODO: Implement types */)));

const functions = signatures.map((s, index) => {
	const a = assertions[index];
	return func(`f${index}`, s, a.length ? a.join(' or ') : 'False', 3.0 /* TODO: Implement return value */);
});

const code = functions.join('\n');
const file = path.join(process.cwd(), 'target.py');

fs.writeFileSync(file, code);

metacall_load_from_file('py', [ 'target.py' ]);

const calls = signatures.map(s => s.map(arg => 5));

calls.forEach((values, index) => metacall(`f${index}`, ...values) != 3.0 && process.exit(1));
