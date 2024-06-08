#!/usr/bin/env bash

URL=https://diabetes.dotdoing.com

echo "Getting https://diabetes.dotdoing.com"
curl -A "Mozilla/5.0 (iPhone; CPU iPhone OS 17_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/126.0.6478.35 Mobile/15E148 Safari/604.1" $URL >> /dev/null
echo "Got https://diabetes.dotdoing.com"

