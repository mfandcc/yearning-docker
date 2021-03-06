FROM alpine:latest

LABEL maintainer="HenryYee-2019/08/13"

RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2; \
    echo "http://mirrors.ustc.edu.cn/alpine/v3.3/main/" > /etc/apk/repositories; \
    apk add --no-cache tzdata; \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime; \
    echo "Asia/Shanghai" >> /etc/timezone; \
    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

EXPOSE 8000

ARG YEARNING_VER="2.2.2"
ARG YEARNING_REL_NAME="-4kstars.linux-amd64-patch-1.zip"
ARG YEARNING_URL="https://github.com/cookieY/Yearning/releases/download/v${YEARNING_VER}/Yearning-${YEARNING_VER}${YEARNING_REL_NAME}"
RUN wget -cqO yearning.zip $YEARNING_URL; \
    unzip yearning.zip -d /opt; \
    rm -f yearning.zip; \
    rm -rf /opt/__MACOSX

WORKDIR /opt/Yearning-go/

ENTRYPOINT  ["/opt/Yearning-go/Yearning"]

CMD ["-m", "-s"]
