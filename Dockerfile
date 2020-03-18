FROM lsiobase/alpine:3.11

ARG GOLANG_VERSION=1.14

ENV GOPATH="$HOME/go"
ENV PATH="${PATH}:/usr/local/go/bin:$GOPATH/bin"

RUN echo ">>>>>> update dependencies <<<<<<" \
    && apk update && apk add git yarn build-base gcc abuild binutils binutils-doc gcc-doc \
    && echo ">>>>>> install golang <<<<<<" \
    && wget -O golang.tar.gz https://dl.google.com/go/go${GOLANG_VERSION}.linux-amd64.tar.gz \
    && mkdir /lib64 \
    && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 \
    && tar -C /usr/local -xzf golang.tar.gz

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]