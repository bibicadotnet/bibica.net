#!/bin/bash
while true
bash <(curl -s -L https://gist.githubusercontent.com/Ansen/e45320205faf5786d3282ac880f20bab/raw/onekey-NeverIdle.sh)
# mac dinh 15% CPU, 4Gb RAM, network
 /tmp/NeverIdle -cp 0.15 -m 4 -n 4h
done
