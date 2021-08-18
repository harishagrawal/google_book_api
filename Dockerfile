FROM golang:alpine as builder
LABEL maintainer="mgdevstack" \
    vendor="Zettabytes" \
    owner="zbio-harish"
ADD src /go/src/github.com/roost-io/roost-example-latest/googlebookapi/src
WORKDIR /go/src/github.com/roost-io/roost-example-latest/googlebookapi/src
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GOFLAGS=-mod=vendor go build -o googlebookapi

FROM alpine
LABEL maintainer="mgdevstack" \
    vendor="Zettabytes" \
    owner="zbio"
COPY  --from=builder /go/src/github.com/roost-io/roost-example-latest/googlebookapi/src/googlebookapi /app/
EXPOSE 9999
USER nobody
ENTRYPOINT ["/app/googlebookapi"]
