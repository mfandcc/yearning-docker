FROM alpine:latest

LABEL maintainer="HenryYee-2019/08/13"

RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2; \
    echo "http://mirrors.ustc.edu.cn/alpine/latest-stable//main/" > /etc/apk/repositories; \
    apk add --no-cache tzdata; \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime; \
    echo "Asia/Shanghai" >> /etc/timezone; \
    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

EXPOSE 8000

ARG YEARNING_VER="2.3.5"
ARG YEARNING_REL_NAME="-linux-amd64.zip"
ARG YEARNING_URL="https://github.com/cookieY/Yearning/releases/download/${YEARNING_VER}/Yearning-${YEARNING_VER}${YEARNING_REL_NAME}"
RUN wget -cqO yearning.zip $YEARNING_URL; \
    unzip yearning.zip -d /opt; \
    rm -f yearning.zip

WORKDIR /opt/

ENTRYPOINT  ["/opt/Yearning"]

CMD ["run"]
