#!/bin/bash
# setup Webinoly php 7.4
locale-gen en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
sudo apt update -y
sudo apt install zip -y
sudo apt install unzip -y
sudo apt install htop -y
sudo apt install screen -y
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/webinoly/master/weby -O weby && sudo chmod +x weby && sudo ./weby -clean
sudo rm /opt/webinoly/webinoly.conf
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/Webinoly-Optimization/master/webinoly_php74.conf -O /opt/webinoly/webinoly.conf
sudo stack -nginx




sudo stack -lemp -build=light
sudo apt remove iptables-persistent -y
sudo ufw disable
sudo iptables -F
sudo apt update && sudo apt upgrade -y
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/Webinoly-Optimization/master/php.ini -O /etc/php/7.4/fpm/php.ini
sudo service php7.4-fpm restart
sudo webinoly -verify
sudo webinoly -info



















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

