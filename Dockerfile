# Copyright 2016 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM alpine:3.7

RUN set -x \
	&& sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
	&& apk add --no-cache redis sed bash tzdata \
	&& cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del --no-cache tzdata

COPY redis-image/redis-master.conf /redis-master/redis.conf
COPY redis-image/redis-slave.conf /redis-slave/redis.conf
COPY redis-image/run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 6379 26379

CMD [ "/run.sh" ]

ENTRYPOINT [ "bash", "-c" ]
