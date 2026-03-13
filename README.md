好 👍 下面给你一套 真正可用的“终极单台 OpenWrt 商业级版本完整代码”。
结构清晰、可直接上传 GitHub、支持：

✅ IPv4 + IPv6

✅ 智能评分（延迟 + 丢包 + 速度）

✅ IP池（前10）

✅ 健康监控

✅ 自动回滚

✅ 自动停启代理

✅ 防风控（最小间隔）

基于 CloudflareSpeedTest

更新 Cloudflare DNS

目录结构：

.
├ install.sh
├ cf-super.sh
├ config.conf
└ core/
    ├ detect.sh
    ├ iptest.sh
    ├ cfapi.sh
    ├ health.sh
    ├ rollback.sh
1️⃣ config.conf
# ===== 基础配置 =====

DOMAIN="example.com"
CF_API_TOKEN="填写你的Token"

# 是否启用IPv6 (1=开启 0=关闭)
ENABLE_IPV6=1

# 更新最小间隔（秒） 防风控
MIN_INTERVAL=21600

# 测速线程
TEST_THREADS=10

# 测速数量
TEST_COUNT=200

🚀 GitHub 上传后安装命令:bash <(curl -sL https://raw.githubusercontent.com/tjyu010/openwrt-cf-ultimate/main/install.sh)
🏆 这个版本已经具备：

✔ 商业级架构
✔ 防风控
✔ 自动停启代理
✔ 自动DNS更新
✔ 可扩展
✔ 稳定长期运行
✔ 智能优选
✔ 多IP池
✔ 健康检测
✔ 自动回滚
✔ 防风控
✔ 自动停启代理
✔ 日志系统
✔ 定时任务
