#!/bin/bash

# =========================
# 健康检测模块
# =========================

BASE="/root/cf-ultimate"
CONFIG="$BASE/config.conf"

source $CONFIG

# 默认健康阈值（可在config扩展）
MAX_LATENCY=150

check_ping() {

IP=$1

# 发送4个包
RESULT=$(ping -c 4 -W 2 $IP 2>/dev/null)

LOSS=$(echo "$RESULT" | grep -oP '\d+(?=% packet loss)')

LATENCY=$(echo "$RESULT" | tail -1 | awk -F '/' '{print $5}')

if [ -z "$LATENCY" ]; then
  return 1
fi

# 丢包率判断
if [ "$LOSS" -ne 0 ]; then
  return 1
fi

# 延迟判断
LAT_INT=${LATENCY%.*}

if [ "$LAT_INT" -gt "$MAX_LATENCY" ]; then
  return 1
fi

return 0
}

check_https() {

IP=$1

# 使用curl测试HTTPS
curl -s --connect-timeout 5 --max-time 5 https://$IP >/dev/null

if [ $? -ne 0 ]; then
  return 1
fi

return 0
}

# =========================
# 主检测函数
# =========================

health_check() {

IP=$1

check_ping $IP
if [ $? -ne 0 ]; then
  return 1
fi

check_https $IP
if [ $? -ne 0 ]; then
  return 1
fi

# 写入稳定IP
echo $IP > $BASE/data/last_good

return 0
}
