rollback_dns() {

OLD_IP=$(cat $BASE/data/last_good 2>/dev/null)

if [ ! -z "$OLD_IP" ]; then
  update_dns $OLD_IP
fi

}
