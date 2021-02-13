#
#	MetaCall Tests by Parra Studios
#	Integration tests for MetaCall Core infrastructure.
#
#	Copyright (C) 2016 - 2021 Vicente Eduardo Ferrer Garcia <vic798@gmail.com>
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

# Test Base Image
FROM alpine:latest AS test_base

# Image Descriptor
LABEL copyright.name="Vicente Eduardo Ferrer Garcia" \
	copyright.address="vic798@gmail.com" \
	maintainer.name="Vicente Eduardo Ferrer Garcia" \
	maintainer.address="vic798@gmail.com" \
	vendor="MetaCall Inc." \
	version="0.1"

# Install Dependencies
RUN apk update \
	&& apk add ca-certificates curl \
	&& curl -sL https://raw.githubusercontent.com/metacall/install/master/install.sh | sh

# NodeJS Base Image
FROM test_base AS test_node

# Copy NodeJS Scripts
COPY node/ /

# NodeJS Codegen Test
FROM test_node AS test_node_codegen

RUN metacall codegen.js

# NodeJS Load Python Module Test
FROM test_node AS test_node_fnpy

RUN metacall pip3 install -r requirements.txt \
	&& metacall import.js | grep '400'

# CLI Base Image
FROM test_base AS test_cli

# Copy CLI Scripts
COPY cli/ /

# Install MetaCall Port (TODO: Remove this requirement)
RUN metacall pip3 install metacall

# CLI Python Test
FROM test_cli AS test_cli_python

RUN printf 'load py main.py\ninspect\ncall test()\ncall world()\nexit' | metacall \
	| grep \
		-e '12' \
		-e '"Hello asd"'

# CLI NodeJS Test
FROM test_cli AS test_cli_node

RUN printf 'load node main.js\ninspect\ncall hello("efg")\nexit' | metacall \
	| grep \
		-e '"Hello efg"'

# CLI Ruby Test
FROM test_cli AS test_cli_ruby

RUN printf 'load rb multiply.rb\ninspect\ncall multiply(5, 5)\nexit' | metacall \
	| grep \
		-e '25'

# CLI C# Test
FROM test_cli AS test_cli_csharp

# TODO:
# RUN printf 'load cs main.cs\ninspect\ncall Say("asd")\nexit' | metacall \
# 	| grep \
# 		-e 'asd'

# Not Found Python Test
FROM test_base AS test_not_found_python

RUN printf 'load py none.py\nexit' | metacall \
	| grep \
		-e 'Script (none.py) load error in loader (py)' \
	&& printf 'load py none\nexit' | metacall \
	| grep \
		-e 'Script (none) load error in loader (py)'

# Not Found NodeJS Test
FROM test_base AS test_not_found_node

# TODO:
# RUN printf 'load node none.js\nexit' | metacall \
# 	&& printf 'load node none\nexit' | metacall

# Not Found Ruby Test
FROM test_base AS test_not_found_ruby

RUN printf 'load rb none.rb\nexit' | metacall \
	| grep \
		-e 'Script (none.rb) load error in loader (rb)' \
	&& printf 'load rb none\nexit' | metacall \
	| grep \
		-e 'Script (none) load error in loader (rb)'

# Not Found C# Test
FROM test_base AS test_not_found_csharp

# TODO:
# RUN printf 'load cs none.cs\nexit' | metacall \
# 	&& printf 'load cs none\nexit' | metacall
