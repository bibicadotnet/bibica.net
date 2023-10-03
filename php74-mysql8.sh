#!/bin/bash

#Update
locale-gen en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
sudo apt update -y
sudo apt install zip -y
sudo apt install unzip -y
sudo apt install htop -y
sudo apt install screen -y

# setup Webinoly php 7.4
wget -qO weby qrok.es/wy && sudo bash weby -clean -ver=1.17.5





sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/webinoly/master/weby -O weby && sudo chmod +x weby && sudo ./weby -clean
sudo rm /opt/webinoly/webinoly.conf
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/Oracle-VM-Standard-A1-Flex-Webinoly/main/vm_standard_a1_flex.conf -O /opt/webinoly/webinoly.conf
sudo stack -lemp -build=light

# Optimization PHP, MariaDB
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/Oracle-VM-Standard-A1-Flex-Webinoly/main/php.ini -O /etc/php/7.4/fpm/php.ini
sudo service php7.4-fpm restart
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/my.cnf -O /etc/mysql/my.cnf
sudo service mysql restart

# off filewall
sudo apt remove iptables-persistent -y
sudo ufw disable
sudo iptables -F

# setup wp-cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

# setup rclone
sudo -v ; curl https://rclone.org/install.sh | sudo bash

# Bypass Oracle VM.Standard.A1.Flex
#sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/NeverIdle-Oracle/master/VM.Standard.A1.Flex.4GB.RAM.sh -O /usr/local/bin/bypass_oracle.sh
#chmod +x /usr/local/bin/bypass_oracle.sh
#nohup /usr/local/bin/bypass_oracle.sh >> ./out 2>&1 <&- &
#chown -R www-data:www-data /var/www/bibica.net/

# setup crontab cho wp_cron and simply-static
mkdir -p /var/www/bibica.net/static-files-temp
chmod 777 /var/www/bibica.net/static-files-temp
crontab -l > simply-static
echo "0 3 * * * /usr/local/bin/wp --path='/var/www/bibica.net/htdocs' simply-static run --allow-root" >> simply-static
echo "*/1 * * * * curl https://bibica.net/wp-cron.php?doing_wp_cron > /dev/null 2>&1" >> simply-static
#echo "@reboot nohup /usr/local/bin/bypass_oracle.sh >> ./out 2>&1 <&- &" >> simply-static
crontab simply-static

# setup wordpress bibica.net and off httpauth
sudo site bibica.net -wp
sudo httpauth bibica.net -wp-admin=off

# setup proxy api.bibica.net, i0.bibica.net, i.bibica.net
sudo webinoly -cache-valid=[100y,100y,100y]
sudo service nginx reload

sudo site api.bibica.net -proxy=[https://i0.wp.com/bibica.net/wp-content/uploads/] -dedicated-reverse-proxy=simple
sudo site api.bibica.net -cache=custom
sudo site i0.bibica.net -proxy=[https://res.cloudinary.com/xinclub/w_500,f_webp,q_auto:best/img/] -dedicated-reverse-proxy=simple
sudo site i0.bibica.net -cache=custom
sudo site i.bibica.net -proxy=[https://res.cloudinary.com/xinclub/f_webp,q_auto:best/img/] -dedicated-reverse-proxy=simple
sudo site i.bibica.net -cache=custom

# setup ssl
mkdir -p /root/ssl
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/bibica.net.pem -O /root/ssl/bibica.net.pem
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/bibica.net.key -O /root/ssl/bibica.net.key
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/bibica.net.crt -O /root/ssl/bibica.net.crt

# setup ssl for bibica.net, api.bibica.net, i0.bibica.net, i.bibica.net
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/bibica.net -O /etc/nginx/sites-available/bibica.net
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/api.bibica.net -O /etc/nginx/sites-available/api.bibica.net
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/proxy-cache/i0.bibica.net -O /etc/nginx/sites-available/i0.bibica.net
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/proxy-cache/i.bibica.net -O /etc/nginx/sites-available/i.bibica.net

#setup proxy cache api.bibica.net, i0.bibica.net, i.bibica.net
mkdir -p /var/www/cache/api_bibica_net
mkdir -p /var/www//cache/i0_bibica_net
mkdir -p /var/www//cache/i_bibica_net
chown -R www-data:www-data /var/www//cache/

sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/proxy-cache/api.bibica.net-proxy.conf -O /etc/nginx/apps.d/api.bibica.net-proxy.conf
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/proxy-cache/i0.bibica.net-proxy.conf -O /etc/nginx/apps.d/i0.bibica.net-proxy.conf
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/proxy-cache/i.bibica.net-proxy.conf -O /etc/nginx/apps.d/i.bibica.net-proxy.conf
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/proxy-cache/webinoly.conf -O /etc/nginx/conf.d/webinoly.conf

# nginx reload
nginx -t
sudo service nginx reload

# Monitor and restart php, mysql, nginx
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/monitor-service-status/main/setup_monitor_service_restart.sh -O setup_monitor_service_restart.sh && sudo chmod +x setup_monitor_service_restart.sh && sudo ./setup_monitor_service_restart.sh

sudo apt update && sudo apt upgrade -y
sudo webinoly -verify
sudo webinoly -info

cd /var/www/bibica.net/htdocs
rm -rf *
