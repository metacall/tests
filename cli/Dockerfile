#
#	MetaCall Tests by Parra Studios
#	Integration tests for MetaCall Core infrastructure.
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

FROM metacall/tests:base AS cli_test

# Image descriptor
LABEL copyright.name="Vicente Eduardo Ferrer Garcia" \
	copyright.address="vic798@gmail.com" \
	maintainer.name="Vicente Eduardo Ferrer Garcia" \
	maintainer.address="vic798@gmail.com" \
	vendor="MetaCall Inc." \
	version="0.1"

# Copy scripts
COPY scripts/ /

# Invalidate Cache
ARG CACHE_INVALIDATE

# Install MetaCall Core
RUN echo "${CACHE_INVALIDATE}" \
	&& metacall pip3 install metacall \
	&& metacall npm install metacall \
	&& printf 'load py main.py\ninspect\ncall test()\ncall world()\nexit' | metacall \
	| grep \
		-e '12' \
		-e '"Hello asd"' \
	&& printf 'load node main.js\ninspect\ncall hello("efg")\nexit' | metacall \
	| grep \
		-e '"Hello efg"' \
	&& printf 'load rb multiply.rb\ninspect\ncall multiply(5, 5)\nexit' | metacall \
	| grep \
		-e '25'
# \
#	&& printf 'load cs main.cs\ninspect\ncall Say("asd")\nexit' | metacall \
#	| grep \
#		-e 'asd'
