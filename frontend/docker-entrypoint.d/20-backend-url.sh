#!/bin/sh
set -e

BACKEND_URL="${BACKEND_URL:-http://127.0.0.1:5001}"
BACKEND_HOST="$(printf '%s' "$BACKEND_URL" | sed -E 's|^[a-zA-Z]+://||; s|/.*$||')"
sed -i "s|BACKEND_URL|${BACKEND_URL}|g" /etc/nginx/conf.d/default.conf
sed -i "s|BACKEND_HOST|${BACKEND_HOST}|g" /etc/nginx/conf.d/default.conf
