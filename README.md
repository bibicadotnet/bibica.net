# Oracle 24GB RAM cho bibica.net, api.bibica.net
Cập nhập OS và khởi động lại hệ thống
```shell
sudo apt update && sudo apt upgrade -y && sudo reboot
```
Cài đặt Webinoly và cấu hình cho domain bibica.net (bypass Oracle)
```shell
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/stable.sh -O webinoly_oracle.sh && sudo chmod +x webinoly_oracle.sh && sudo ./webinoly_oracle.sh
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
