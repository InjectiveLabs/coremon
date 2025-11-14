FROM golang:1.24-bookworm as builder

RUN apt-get update && apt-get install -y \
    git \
    make \
    gcc \
    libc-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
RUN go mod tidy
RUN go install ./cmd/coremon

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*
COPY --from=builder /go/bin/* /usr/local/bin/
WORKDIR /apps/data

ENTRYPOINT [ "coremon" ]
