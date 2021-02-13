#!/usr/bin/env python3

from metacall import metacall_load_from_file, metacall

metacall_load_from_file('rb', [ 'multiply.rb' ]);

metacall_load_from_file('node', [ 'main.js' ]);

def test():
	return metacall('multiply', 3, 4); # 12

def world():
	return metacall('hello', 'asd'); # 'Hello asd'
