run_test() {

cd $BASE

if [ ! -f CloudflareST ]; then
  wget -O CloudflareST https://github.com/XIU2/CloudflareSpeedTest/releases/latest/download/CloudflareST_linux_amd64
  chmod +x CloudflareST
fi

./CloudflareST -n $TEST_COUNT -t $TEST_THREADS

# 取第一名
BEST=$(awk -F, 'NR==2{print $1}' result.csv)

echo $BEST

}
