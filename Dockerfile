FROM rust:slim-buster AS build
WORKDIR /opt
COPY . .
RUN cargo build
EXPOSE 8080

FROM debian:stretch-slim
#FROM busybox
COPY --from=build /opt/target/debug/rust /app1/rust
CMD "/app1/rust"