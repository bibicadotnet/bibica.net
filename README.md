# Oracle 24GB RAM cho bibica.net, api.bibica.net
Cập nhập OS và khởi động lại hệ thống
```shell
sudo apt update && sudo apt upgrade -y && sudo reboot
```
Cài đặt Webinoly và cấu hình cho domain bibica.net
```shell
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/setup_oracle_24gb_no_bypass.sh && sudo chmod +x setup_oracle_24gb_no_bypass.sh && sudo ./setup_oracle_24gb_no_bypass.sh
```
# VPS 1GB RAM cho bibica.net, api.bibica.net
Cập nhập OS và khởi động lại hệ thống
```shell
sudo apt update && sudo apt upgrade -y && sudo reboot
```
Cài đặt Webinoly và cấu hình cho domain bibica.net
```shell
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/setup.sh -O setup_bibica_net.sh && sudo chmod +x setup_bibica_net.sh && sudo ./setup_bibica_net.sh
```
## Restore Bằng Duplicator Pro
Upload archive.zip và installer.php vào (có thể sử dụng wget cho nhanh)
```shell
/var/www/bibica.net/htdocs
```
## Đổi 3 domain bên dưới về IP mới
```shell
bibica.net
www.bibica.net
api.bibica.net
```
Chạy file installer.php để restore

# Webserver + remote + proxy trên 2 VPS Oracle FREE
Trang bibica.net sẽ là trang chính, cài đặt Nginx và PHP (sử dụng cài đặt Webserver)

Trang api.bibica.net là trang proxy ảnh và chứa database, cài đặt Nginx và Mysql (sử dụng cài đặt remote server và proxy)

## Remote server và proxy
Cập nhập OS và khởi động lại hệ thống
```shell
sudo apt update && sudo apt upgrade -y && sudo reboot
```
Cài đặt Nginx cho proxy api.bibica.net cài đặt và Mysql làm remote database cho bibica.net
```shell
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/setup_remote_proxy.sh -O setup_remote_proxy.sh && sudo chmod +x setup_remote_proxy.sh && sudo ./setup_remote_proxy.sh
```
## Webserver
Cập nhập OS và khởi động lại hệ thống
```shell
sudo apt update && sudo apt upgrade -y && sudo reboot
```
Cài đặt Nginx và PHP bibica.net
```shell
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/setup_webserver.sh && sudo chmod +x setup_webserver.sh && sudo ./setup_webserver.sh
```
### Restore Bằng Duplicator Pro
Upload archive.zip và installer.php vào (có thể sử dụng wget cho nhanh)
```shell
/var/www/bibica.net/htdocs
```
### Đổi 3 domain bên dưới về IP mới
```shell
bibica.net -> IP Webserver
www.bibica.net -> IP Webserver
api.bibica.net -> IP Remote server và proxy
```
Chạy file installer.php để restore
