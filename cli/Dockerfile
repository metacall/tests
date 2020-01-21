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
	&& echo "inspect" | metacall load node main.js \
	&& cat /root/metacall.log \
	&& metacall install py metacall \
	&& echo "call test()" | metacall load py main.py \
	&& cat /root/metacall.log \
	&& echo "call world()" | metacall load py main.py \
	&& cat /root/metacall.log
