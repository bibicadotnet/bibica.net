#!/bin/bash
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/Webinoly-Optimization/master/webinoly74.sh -O webinoly_mod.sh && sudo chmod +x webinoly_mod.sh && sudo ./webinoly_mod.sh
sudo site bibica.net -wp
sudo httpauth bibica.net -wp-admin=off
mkdir -p /root/ssl
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/bibica.net.pem -O /root/ssl
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/bibica.net.key -O /root/ssl
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/bibica.net -O /etc/nginx/sites-available/bibica.net
sudo site api.bibica.net -proxy=[https://i0.wp.com/cdn.bibica.net/wp-content/uploads/] -dedicated-reverse-proxy=simple
nginx -t
service nginx reload
cd /var/www/bibica.net/htdocs
rm -rf *
