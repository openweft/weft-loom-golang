# weft-loom-golang

Go compile sandbox for weft-loom (Go 1.26 stable + CGO=0 default). Consumed by [weft-loom-server](https://github.com/openweft/weft-loom-server) via weft-agent when a compile job picks this language.

## Invocation contract

```
docker run --rm \
  -v <project>:/workspace:ro \
  -v <scratch>:/workspace/.build:rw \
  ghcr.io/openweft/weft-loom-golang:latest
```

See the [Dockerfile](./Dockerfile) for the default `CMD` ; override
via the weft-loom compile job's `extra_args` for non-default targets.

## Image

- Base : see Dockerfile FROM line
- Arch : `linux/amd64`, `linux/arm64` (built via buildx + QEMU on tag)
- Registry : `ghcr.io/openweft/weft-loom-golang`
- Tag policy : `latest` (rolling main), `vX.Y.Z` (immutable)

## License

BSD 3-Clause — see LICENSE.
