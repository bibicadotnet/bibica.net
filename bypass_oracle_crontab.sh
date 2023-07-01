#!/bin/bash
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/bypass_oracle.sh -O /usr/local/bin/bypass_oracle.sh
chmod +x /usr/local/bin/bypass_oracle.sh
nohup /usr/local/bin/bypass_oracle.sh >> ./out 2>&1 <&- &
