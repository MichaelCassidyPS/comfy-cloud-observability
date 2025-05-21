#!/usr/bin/env bash
# Usage: ./load_test.sh <URL>
URL=$1

# Prefer "hey" for realistic concurrent load; fall back to curl if it's not installed.
if command -v hey >/dev/null 2>&1; then
  hey -z 30s -q 25 "$URL"          # 25 requests / sec for 30 s
else
  for i in {1..750}; do            # ~25 RPS equivalent with curl
    curl -s "$URL" > /dev/null &
    sleep 0.04                     # throttle to 25 requests / sec
  done
  wait
fi
