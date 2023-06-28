#!/bin/bash
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/Webinoly-Optimization/master/webinoly_beta.sh -O webinoly_mod.sh && sudo chmod +x webinoly_mod.sh && sudo ./webinoly_mod.sh
sudo site bibica.net -wp
sudo httpauth bibica.net -wp-admin=off
mkdir -p /root/ssl
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/bibica.net.pem -O /root/ssl/bibica.net.pem
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/bibica.net.key -O /root/ssl/bibica.net.key
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/bibica.net.crt -O /root/ssl/bibica.net.crt
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/bibica.net -O /etc/nginx/sites-available/bibica.net
sudo site api.bibica.net -proxy=[https://i0.wp.com/cdn.bibica.net/wp-content/uploads/] -dedicated-reverse-proxy=simple
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/api.bibica.net -O //etc/nginx/sites-available/api.bibica.net
nginx -t
service nginx reload
cd /var/www/bibica.net/htdocs
rm -rf *
