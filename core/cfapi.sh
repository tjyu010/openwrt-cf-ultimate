update_dns() {

IP=$1

# 获取ZoneID
ZONE_ID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=$DOMAIN" \
-H "Authorization: Bearer $CF_API_TOKEN" \
-H "Content-Type: application/json" | grep -o '"id":"[^"]*"' | head -1 | cut -d':' -f2 | tr -d '"')

# 获取RecordID
RECORD_ID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records?name=$DOMAIN" \
-H "Authorization: Bearer $CF_API_TOKEN" \
-H "Content-Type: application/json" | grep -o '"id":"[^"]*"' | head -1 | tr -d '"')

# 更新
curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
-H "Authorization: Bearer $CF_API_TOKEN" \
-H "Content-Type: application/json" \
--data "{\"type\":\"A\",\"name\":\"$DOMAIN\",\"content\":\"$IP\",\"ttl\":120,\"proxied\":false}"

}
