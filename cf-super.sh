#!/bin/bash

BASE="/root/cf-ultimate"
CONFIG="$BASE/config.conf"
LOG="$BASE/logs/run.log"
DATA="$BASE/data"

mkdir -p $BASE/logs
mkdir -p $DATA

source $CONFIG

LAST_RUN_FILE="$DATA/last_run"

# ===== 防频繁运行 =====
if [ -f "$LAST_RUN_FILE" ]; then
  LAST=$(cat $LAST_RUN_FILE)
  NOW=$(date +%s)
  DIFF=$((NOW-LAST))
  if [ $DIFF -lt $MIN_INTERVAL ]; then
    echo "间隔不足，退出" >> $LOG
    exit 0
  fi
fi

echo $(date +%s) > $LAST_RUN_FILE

# ===== 检测代理 =====
source $BASE/core/detect.sh
detect_proxy

# 停止代理
if [ "$PROXY" != "" ]; then
  /etc/init.d/$PROXY stop
  sleep 5
fi

# ===== 优选IP =====
source $BASE/core/iptest.sh
BEST_IP=$(run_test)

if [ -z "$BEST_IP" ]; then
  echo "优选失败" >> $LOG
  exit 1
fi

# ===== 健康检测 =====
source $BASE/core/health.sh
health_check $BEST_IP

if [ $? -ne 0 ]; then
  echo "健康检测失败，执行回滚" >> $LOG
  source $BASE/core/rollback.sh
  rollback_dns
  exit 1
fi

# ===== 更新DNS =====
source $BASE/core/cfapi.sh
update_dns $BEST_IP

# ===== 启动代理 =====
if [ "$PROXY" != "" ]; then
  /etc/init.d/$PROXY start
fi

# ===== 记录稳定IP =====
echo $BEST_IP > $DATA/last_good

# ===== 日志 =====
echo "更新完成: $BEST_IP" >> $LOG
