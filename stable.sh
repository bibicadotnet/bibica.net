#!/bin/bash
# setup Webinoly php 7.4
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/Oracle-VM-Standard-A1-Flex-Webinoly/main/setup.sh -O setup.sh && sudo chmod +x setup.sh && sudo ./setup.sh

#su dung cau hinh database mới
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/Oracle-VM-Standard-A1-Flex-Webinoly/main/my_new.cnf -O /etc/mysql/my.cnf
sudo service mysql restart

# setup wp-cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

# setup rclone
sudo -v ; curl https://rclone.org/install.sh | sudo bash

# Bypass Oracle VM.Standard.A1.Flex
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/NeverIdle-Oracle/master/VM.Standard.A1.Flex.4GB.RAM.sh -O /usr/local/bin/bypass_oracle.sh
chmod +x /usr/local/bin/bypass_oracle.sh
nohup /usr/local/bin/bypass_oracle.sh >> ./out 2>&1 <&- &
chown -R www-data:www-data /var/www/bibica.net/

# setup crontab cho wp_cron and simply-static
mkdir -p /var/www/bibica.net/static-files-temp
chmod 777 /var/www/bibica.net/static-files-temp
crontab -l > simply-static
echo "0 3 * * * /usr/local/bin/wp --path='/var/www/bibica.net/htdocs' simply-static run --allow-root" >> simply-static
echo "*/1 * * * * curl https://bibica.net/wp-cron.php?doing_wp_cron > /dev/null 2>&1" >> simply-static
echo "@reboot nohup /usr/local/bin/bypass_oracle.sh >> ./out 2>&1 <&- &" >> simply-static
crontab simply-static

# setup wordpress bibica.net and off httpauth
sudo site bibica.net -wp
sudo httpauth bibica.net -wp-admin=off

# setup proxy api.bibica.net
sudo site api.bibica.net -proxy=[https://res.cloudinary.com/xinclub/] -dedicated-reverse-proxy=simple

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

# Monitor and restart php, mysql, nginx
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/monitor-service-status/main/setup_monitor_service_restart.sh -O setup_monitor_service_restart.sh && sudo chmod +x setup_monitor_service_restart.sh && sudo ./setup_monitor_service_restart.sh

sudo apt update && sudo apt upgrade -y
sudo webinoly -verify
sudo webinoly -info

cd /var/www/bibica.net/htdocs
rm -rf *
