FROM lsiobase/ubuntu:arm64v8-bionic

ARG GOLANG_VERSION=1.14

ENV GOPATH="$HOME/go"
ENV PATH="${PATH}:/usr/local/go/bin:$GOPATH/bin"

RUN echo ">>>>>> update dependencies <<<<<<" \
    && apt-get update && apt-get install -y git yarn build-base gcc abuild binutils binutils-doc gcc-doc \
    && echo ">>>>>> install golang <<<<<<" \
    && wget -O golang.tar.gz https://dl.google.com/go/go${GOLANG_VERSION}.linux-arm64.tar.gz \
    && tar -C /usr/local -xzf golang.tar.gz

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]