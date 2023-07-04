# Oracle 24GB RAM cho bibica.net, api.bibica.net
Cập nhập OS và khởi động lại hệ thống
```shell
sudo apt update && sudo apt upgrade -y && sudo reboot
```
Cài đặt Webinoly và cấu hình cho domain bibica.net
```shell
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/setup_oracle_24gb.sh && sudo chmod +x setup_oracle_24gb.sh && sudo ./setup_oracle_24gb.sh
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
