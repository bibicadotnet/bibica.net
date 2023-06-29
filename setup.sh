#!/bin/bash
# setup Webinoly php 7.4
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/Webinoly-Optimization/master/webinoly74.sh -O webinoly_mod.sh && sudo chmod +x webinoly_mod.sh && sudo ./webinoly_mod.sh
# setup wp-cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
# setup rclone
sudo -v ; curl https://rclone.org/install.sh | sudo bash
# setup crontab cho wp_cron and simply-static
mkdir -p /var/www/bibica.net/static-files-temp
chmod 777 /var/www/bibica.net/static-files-temp
crontab -l > simply-static
echo "0 3 * * * /usr/local/bin/wp --path='/var/www/bibica.net/htdocs' simply-static run --allow-root" >> simply-static
echo "*/1 * * * * curl https://bibica.net/wp-cron.php?doing_wp_cron > /dev/null 2>&1" >> simply-static
crontab simply-static
# setup wordpress bibica.net and off httpauth
sudo site bibica.net -wp
sudo httpauth bibica.net -wp-admin=off
# setup proxy api.bibica.net
sudo site api.bibica.net -proxy=[https://i0.wp.com/cdn.bibica.net/wp-content/uploads/] -dedicated-reverse-proxy=simple
# setup ssl
mkdir -p /root/ssl
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/bibica.net.pem -O /root/ssl/bibica.net.pem
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/bibica.net.key -O /root/ssl/bibica.net.key
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/bibica.net.crt -O /root/ssl/bibica.net.crt
# setup ssl for bibica.net and api.bibica.net
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/bibica.net -O /etc/nginx/sites-available/bibica.net
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/api.bibica.net -O //etc/nginx/sites-available/api.bibica.net
# nginx reload
nginx -t
sudo service nginx reload
# mariadb config
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/my.cnf -O /etc/mysql/my.cnf
sudo service mysql restart
# delete all file in foder htdocs
cd /var/www/bibica.net/htdocs
rm -rf *
