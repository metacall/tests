const { sum } = require('./sum.py');
const { foldr, call } = require('fn.op');

console.log(foldr(call, 10)([s => s * s, k => sum(k, 10)])); // 400
