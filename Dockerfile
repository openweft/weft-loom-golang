# weft-loom-golang — Go compile sandbox image for weft-loom.
#
# Consumed by weft-agent when a weft-loom compile job has
# language="go". Default command runs `go build` against the
# project root ; override via job ExtraArgs for tests, race,
# coverage, etc.
#
# Invocation contract (mirrors weft-loom-texlive) :
#
#   docker run --rm \
#     -v <project>:/workspace:ro \
#     -v <scratch>:/workspace/.build:rw \
#     ghcr.io/openweft/weft-loom-golang \
#     go build -trimpath -o /workspace/.build/out ./...

FROM golang:1.26-bookworm

# Non-root build user — defence in depth on top of microVM isolation.
RUN useradd --create-home --shell /bin/bash --uid 1000 build \
 && mkdir -p /workspace \
 && chown build:build /workspace

# Pre-populate the Go module cache directory with the right owner so
# `go mod download` (run on first build) doesn't 13-EACCES on the
# read-only /workspace bind.
RUN mkdir -p /home/build/go/pkg/mod && chown -R build:build /home/build/go

USER build
WORKDIR /workspace
ENV GOMODCACHE=/home/build/go/pkg/mod
ENV CGO_ENABLED=0

CMD ["go", "build", "-trimpath", "-o", "/workspace/.build/out", "./..."]

LABEL org.opencontainers.image.title="weft-loom-golang"
LABEL org.opencontainers.image.description="Go compile sandbox for weft-loom (Go 1.26 + CGO=0 default)"
LABEL org.opencontainers.image.source="https://github.com/openweft/weft-loom-golang"
LABEL org.opencontainers.image.licenses="BSD-3-Clause"
