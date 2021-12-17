FROM alpine:3.14

RUN apk add --no-cache curl

RUN curl -L https://github.com/btcsuite/btcd/releases/download/v0.22.0-beta/btcd-linux-amd64-v0.22.0-beta.tar.gz | tar xz \
  && mv -v btcd-linux-amd64-v0.22.0-beta/* /usr/bin/ \
  && rm -r btcd-linux-amd64-v0.22.0-beta \
  && btcd -V

ENTRYPOINT [ "btcd" ]