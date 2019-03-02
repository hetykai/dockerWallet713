FROM alpine as builder
ARG VERSION=v1.1.0
ENV CLONE_URL https://github.com/vault713/wallet713
WORKDIR /src
RUN apk update && apk --no-cache add git cargo rust ncurses-dev zlib-dev llvm-dev libressl-dev linux-headers pkgconfig clang-dev && git clone $CLONE_URL -b $VERSION . && cargo build --release

FROM hety/alpine
RUN apk --no-cache add ncurses libgcc libressl-dev
COPY --from=builder /src/target/release/wallet713 /usr/local/bin/wallet713
ENTRYPOINT ["wallet713"]
