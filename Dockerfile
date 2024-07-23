FROM alpine:3.20

# 定义变量，在创建时指定变量值
ARG VERSION
ARG ARCH

# 如果创建镜像时未指定版本，则默认为 1.27
ENV WS_VERSION=${VERSION:-1.27}

# 系统架构，例如：amd64 或 arm64
ENV CPU_ARCH=$ARCH

RUN apk add --no-cache curl libc6-compat tzdata gcompat \
    && curl -L "https://github.com/Jrohy/webssh/releases/download/v${WS_VERSION}/webssh_linux_${CPU_ARCH}" -o /webssh-go \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* \
    && apk del curl

RUN chmod +x /webssh-go
CMD ["/webssh-go"]