FROM alpine:3.17 AS builder
ARG ZABBIX_VERSION=7.0.27
RUN apk add --no-cache \
    build-base \
    pkgconf \
    sqlite-dev \
    pcre2-dev \
    zlib-dev \
    openssl-dev \
    curl-dev \
    libevent-dev \
    net-snmp-dev \
    linux-headers \
    curl \
    tar
ENV LDFLAGS="-Wl,-z,max-page-size=65536 -latomic"
RUN curl -fSL "https://cdn.zabbix.com/zabbix/sources/stable/7.0/zabbix-${ZABBIX_VERSION}.tar.gz" | tar xz && \
    mv zabbix-${ZABBIX_VERSION} /zabbix-src
WORKDIR /zabbix-src
RUN ./configure --prefix=/usr --sysconfdir=/etc/zabbix \
                --enable-proxy --enable-ipv6 \
                --with-sqlite3 \
                --with-openssl --with-libcurl \
                --with-libpcre2 --with-net-snmp && \
    make -j$(nproc) && \
    make install

FROM alpine:3.17
RUN apk add --no-cache \
    sqlite-libs \
    pcre2 \
    zlib \
    libssl3 \
    libcrypto3 \
    libcurl \
    libevent \
    net-snmp-libs \
    fping \
    bash \
    su-exec && \
    addgroup -S zabbix && adduser -S -G zabbix zabbix && \
    mkdir -p /var/lib/zabbix/db_data /run/zabbix /etc/zabbix && \
    chown -R zabbix:zabbix /var/lib/zabbix /run/zabbix /etc/zabbix
COPY --from=builder /usr/sbin/zabbix_proxy /usr/sbin/zabbix_proxy
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
