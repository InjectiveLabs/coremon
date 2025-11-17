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

ADD https://github.com/CosmWasm/wasmvm/releases/download/v2.1.5/libwasmvm.x86_64.so /lib/libwasmvm.x86_64.so
ADD https://github.com/CosmWasm/wasmvm/releases/download/v2.1.5/libwasmvm.aarch64.so /lib/libwasmvm.aarch64.so

COPY --from=builder /go/bin/* /usr/local/bin/
WORKDIR /apps/data

CMD [ "coremon" ]
