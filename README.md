# Setup cho bibica.net
Cập nhập OS và khởi động lại hệ thống
```shell
sudo apt update && sudo apt upgrade -y && sudo reboot
```
Cài đặt Webinoly và cấu hình cho domain bibica.net
```shell
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/setup.sh -O setup_bibica_net.sh && sudo chmod +x setup_bibica_net.sh && sudo ./setup_bibica_net.sh
```
Restore Bằng Duplicator Pro
Upload archive.zip và installer.php vào (có thể sử dụng wget cho nhanh)
```shell
/var/www/bibica.net/htdocs
```
Đổi 3 Records bên dưới về IP mới
```shell
bibica.net
www.bibica.net
api.bibica.net
```
Chạy file installer.php để restore

# Combo remote + webserver trên Oracle (2 VPS FREE)
Trang bibica.net sẽ là trang chính, cài đặt Nginx và PHP (sử dụng cài đặt Webserver) <br>
Trang api.bibica.net là trang proxy ảnh, cài đặt Nginx và Mysql (sử dụng cài đặt Remote server và proxy)

# Remote server và proxy
Cập nhập OS và khởi động lại hệ thống
```shell
sudo apt update && sudo apt upgrade -y && sudo reboot
```
Cài đặt Nginx cho proxy api.bibica.net cài đặt và Mysql làm remote database cho bibica.net
```shell
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/setup_remote_proxy.sh -O setup_remote_proxy.sh && sudo chmod +x setup_remote_proxy.sh && sudo ./setup_remote_proxy.sh
```
# Webserver
Cập nhập OS và khởi động lại hệ thống
```shell
sudo apt update && sudo apt upgrade -y && sudo reboot
```
Cài đặt Nginx và PHP bibica.net
```shell
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/setup_webserver.sh && sudo chmod +x setup_webserver.sh && sudo ./setup_webserver.sh
```
