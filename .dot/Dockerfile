FROM alpine:latest

RUN apk add bash curl git vim

ADD script/install .dot/script/install

ENTRYPOINT ["/bin/bash"]
