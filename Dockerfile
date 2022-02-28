FROM python:alpine as main

# 国内源
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories; \
    apk update && apk upgrade

RUN apk --no-cache add \
      gnupg \
      ca-certificates \
    pip install requests -i https://mirrors.aliyun.com/pypi/simple/ ; \
    rm -rf /root/.cache; \
    find /usr/lib/ -name '__pycache__' -print0 | xargs -0 -n1 rm -rf; \
    find /usr/lib/ -name '*.pyc' -print0 | xargs -0 -n1 rm -rf

COPY assets/ /opt/resource/

RUN chmod +x /opt/resource/*

FROM main