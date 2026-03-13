detect_proxy() {

if [ -f /etc/init.d/openclash ]; then
  PROXY="openclash"
elif [ -f /etc/init.d/passwall ]; then
  PROXY="passwall"
else
  PROXY=""
fi

}
