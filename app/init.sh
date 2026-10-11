#!/bin/sh
set -e

OS_DESCRIPTION="$( cat /etc/os-release | grep 'PRETTY_NAME' | cut -d'"' -sf2 | xargs )"
OS_ARCHITECTURE="$(uname -m )"
echo "$(date +'%Y'-'%m'-'%d %H':'%M':'%S') INFO  Init: $OS_DESCRIPTION ($OS_ARCHITECTURE)"

HTTP_PORT=$( jq -r '.http_port // 80' /data/options.json 2>/dev/null || echo 80 )
HTTPS_PORT=$( jq -r '.https_port // 443' /data/options.json 2>/dev/null || echo 443 )
STATUS_CODE=$( jq -r '.status_code // 307' /data/options.json 2>/dev/null || echo 307 )

if [ "$HTTPS_PORT" != "443" ]; then HTTPS_SUFFIX=":$HTTPS_PORT"; fi

cat << 'EOF' > /etc/nginx/http.d/default.conf
map $time_iso8601 $time_simple {
    '~^(\d{4}-\d{2}-\d{2})T(\d{2}:\d{2}:\d{2})' "$1 $2";
    default                                     "";
}
EOF

cat << EOF >> /etc/nginx/http.d/default.conf
log_format custom_simple '\$time_simple DEBUG Nginx: \$server_protocol \$request_method http://\$host\$request_uri [\$status] https://\$host$HTTPS_SUFFIX\$request_uri';
server {
  listen $HTTP_PORT;
  return $STATUS_CODE https://\$host$HTTPS_SUFFIX\$request_uri;
  access_log /var/log/nginx/access.log custom_simple;
}
EOF

ln -sf /dev/stdout /var/log/nginx/access.log

NGINX_VERSION="$( nginx -v 2>&1 | cut -d'/' -sf2 | xargs )"
echo "$(date +'%Y'-'%m'-'%d %H':'%M':'%S') INFO  Init: Nginx $NGINX_VERSION redirecting :$HTTP_PORT to :$HTTPS_PORT (HTTP status $STATUS_CODE)"

exec nginx -g "daemon off;"
