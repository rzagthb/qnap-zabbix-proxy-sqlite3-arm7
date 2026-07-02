#!/bin/sh
set -e

: "${ZBX_SERVER_HOST:?Переменная ZBX_SERVER_HOST не задана!}"
: "${ZBX_HOSTNAME:?Переменная ZBX_HOSTNAME не задана!}"

chown -R zabbix:zabbix /var/lib/zabbix/db_data /run/zabbix /etc/zabbix

FPING_PATH=$(which fping)
if [ -z "$FPING_PATH" ]; then
    echo "ОШИБКА: fping не найден!" >&2
    exit 1
fi

cat <<EOF > /etc/zabbix/zabbix_proxy.conf
Server=${ZBX_SERVER_HOST}
Hostname=${ZBX_HOSTNAME}
ProxyMode=${ZBX_PROXYMODE:-0}
DBName=/var/lib/zabbix/db_data/proxy.db
LogType=console
PidFile=/run/zabbix/zabbix_proxy.pid
SocketDir=/run/zabbix
FpingLocation=${FPING_PATH}
EOF

echo "=========================================="
echo "Запуск Zabbix Proxy 7.0"
echo "Server: ${ZBX_SERVER_HOST}"
echo "Hostname: ${ZBX_HOSTNAME}"
echo "Mode: ${ZBX_PROXYMODE:-0}"
echo "=========================================="

exec su-exec zabbix:zabbix /usr/sbin/zabbix_proxy -f -c /etc/zabbix/zabbix_proxy.conf
