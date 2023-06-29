# Setup cho bibica.net
<ul>
 	<li>Cập nhập OS và khởi động lại hệ thống</li>
</ul>
```shell
sudo apt update &amp;&amp; sudo apt upgrade -y &amp;&amp; sudo reboot
```
<ul>
 	<li>Cài đặt Webinoly và cấu hình cho domain bibica.net</li>
</ul>
```shell
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/setup.sh -O setup_bibica_net.sh &amp;&amp; sudo chmod +x setup_bibica_net.sh &amp;&amp; sudo ./setup_bibica_net.sh
```
<ul>
 	<li>Restore Bằng Duplicator Pro</li>
</ul>
Upload archive.zip và installer.php vào (có thể sử dụng wget cho nhanh)
<pre class="EnlighterJSRAW" data-enlighter-language="generic">/var/www/bibica.net/htdocs</pre>
Đổi 3 Records bên dưới về IP mới
<pre class="EnlighterJSRAW" data-enlighter-language="generic">bibica.net
www.bibica.net
api.bibica.net</pre>
Chạy file installer.php để restore
