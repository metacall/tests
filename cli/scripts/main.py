#!/usr/bin/env python3

from metacall import metacall_load_from_file, metacall

metacall_load_from_file('rb', [ 'multiply.rb' ]);

def test():
	return metacall('multiply', 3, 4); # 12
