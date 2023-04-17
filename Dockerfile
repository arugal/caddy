FROM golang:1.19-buster as builder

ENV GOPROXY=https://goproxy.cn

WORKDIR /app
COPY . /app
RUN go mod download && \
    cd cmd/caddy && \
    go build

FROM buildpack-deps:buster-scm
COPY --from=builder /app/cmd/caddy/caddy /usr/bin/
WORKDIR /usr/bin