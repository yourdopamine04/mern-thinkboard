#!/bin/sh
set -e

BACKEND_URL="${BACKEND_URL:-http://127.0.0.1:5001}"
sed -i "s|BACKEND_URL|${BACKEND_URL}|g" /etc/nginx/conf.d/default.conf
