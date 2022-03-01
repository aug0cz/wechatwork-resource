FROM python:alpine as main

RUN apk update && apk upgrade; \
    apk --no-cache add \
      gnupg \
      ca-certificates ; \
    pip install requests ; \
    rm -rf /root/.cache ; \
    find /usr/lib/ -name '__pycache__' -print0 | xargs -0 -n1 rm -rf; \
    find /usr/lib/ -name '*.pyc' -print0 | xargs -0 -n1 rm -rf

COPY assets/ /opt/resource/

RUN chmod +x /opt/resource/*

FROM main