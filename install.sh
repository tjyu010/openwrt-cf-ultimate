#!/bin/bash

BASE="/root/cf-ultimate"

mkdir -p $BASE/core
mkdir -p $BASE/data
mkdir -p $BASE/logs

wget -O $BASE/cf-super.sh https://raw.githubusercontent.com/tjyu010/openwrt-cf-ultimate/main/cf-super.sh

wget -O $BASE/config.conf https://raw.githubusercontent.com/tjyu010/openwrt-cf-ultimate/main/config.conf

chmod +x $BASE/cf-super.sh

# 定时任务 每天3点
echo "0 3 * * * bash $BASE/cf-super.sh" >> /etc/crontabs/root

/etc/init.d/cron restart

echo "安装完成"
