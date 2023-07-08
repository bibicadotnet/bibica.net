#!/bin/bash
bash <(curl -s -L https://gist.githubusercontent.com/Ansen/e45320205faf5786d3282ac880f20bab/raw/onekey-NeverIdle.sh)
# setup bypass Oracle 15% CPU, 4h tự chạy speedtest 1 lần
/tmp/NeverIdle -cp 0.15 -n 4h
