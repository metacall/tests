#
#	MetaCall Distributable by Parra Studios
#	Distributable infrastructure for MetaCall.
#
#	Copyright (C) 2016 - 2020 Vicente Eduardo Ferrer Garcia <vic798@gmail.com>
#
#	Licensed under the Apache License, Version 2.0 (the "License");
#	you may not use this file except in compliance with the License.
#	You may obtain a copy of the License at
#
#		http://www.apache.org/licenses/LICENSE-2.0
#
#	Unless required by applicable law or agreed to in writing, software
#	distributed under the License is distributed on an "AS IS" BASIS,
#	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#	See the License for the specific language governing permissions and
#	limitations under the License.
#

.PHONY: all help base test default

# Default target
default: all

# All targets
all:
	@$(MAKE) base
	@$(MAKE) test

# Show help
help:
	@echo 'Management commands for metacall-distributable:'
	@echo
	@echo 'Usage:'
	@echo '    make base         Build base container with a fresh download.'
	@echo '    make test         Run integration tests.'
	@echo '    make help         Show verbose help.'
	@echo

# Build base container
base:
	# Generate a unique id for invalidating the cache of test layers
	$(eval CACHE_INVALIDATE := $(shell date +%s))
	# Build base
	@cd base && docker build --build-arg CACHE_INVALIDATE=${CACHE_INVALIDATE} -t metacall/tests:base -f Dockerfile .

# Integration tests
test:
	# Generate a unique id for invalidating the cache of test layers
	$(eval CACHE_INVALIDATE := $(shell date +%s))
	# Run tests
	@cd cli && docker build --build-arg CACHE_INVALIDATE=${CACHE_INVALIDATE} -t metacall/tests:cli -f Dockerfile .
	@cd node && docker build --build-arg CACHE_INVALIDATE=${CACHE_INVALIDATE} -t metacall/tests:node -f Dockerfile .
	@echo "Done"

# Empty target do nothing
%:
	@:
