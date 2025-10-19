# syntax=docker/dockerfile:1.7

FROM emscripten/emsdk:4.0.17 AS builder
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  cmake \
  curl \
  git \
  python3 \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

RUN make clean \
  && make wasm

FROM scratch AS artifacts
COPY --from=builder /app/dist /dist
