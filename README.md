# Oracle 24GB RAM cho bibica.net, api.bibica.net, warp up cache
Cấu hình cụ thể bao gồm 3 VM tại Home Region US West (San Jose), đã set sẵn bypsas các rule của Cloudflare cho phù hợp từng VM riêng
<ul>
 	<li>bibica.net sẽ chạy trên VM.Standard.A1.Flex 4 core 24 GB RAM 100 GB HDD</li>
 	<li>api.bibica.net sẽ chạy trên VM.Standard.E2.1.Micro 2 core 1 GB RAM 50 GB HDD</li>
 	<li>warp-up-cache sẽ chạy trên VM.Standard.E2.1.Micro 2 core 1 GB RAM 50 GB HDD</li>
</ul>
<h2>Setup bibica.net</h2>

```shell
sudo apt update && sudo apt upgrade -y && sudo reboot
```

```shell
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/bibica.net/main/stable.sh -O webinoly_oracle.sh && sudo chmod +x webinoly_oracle.sh && sudo ./webinoly_oracle.sh
```

<p dir="auto" tabindex="-1">Restore bằng Duplicator Pro, upload archive.zip và installer.php vào (có thể sử dụng wget cho nhanh)</p>

<pre class="EnlighterJSRAW" data-enlighter-language="generic">/var/www/bibica.net/htdocs</pre>
<p dir="auto" tabindex="-1">Đổi 2 domain bên dưới về IP mới</p>

<pre class="EnlighterJSRAW" data-enlighter-language="generic">bibica.net
www.bibica.net</pre>
Chạy file installer.php để restore
<h2>Setup api.bibica.net</h2>

```shell
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/Webinoly-Reverse-Proxy/main/setup.sh -O webinoly_reverse_proxy.sh && sudo chmod +x webinoly_reverse_proxy.sh && sudo ./webinoly_reverse_proxy.sh
```

Đổi domain bên dưới về IP mới
<pre class="EnlighterJSRAW" data-enlighter-language="generic">api.bibica.net</pre>
<h2>Setup warp-up-cache</h2>

```shell
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/Warm-Up-Cache/main/setup.sh -O warm_up.sh && sudo chmod +x warm_up.sh && sudo ./warm_up.sh
```

Do phần cứng của combo này quá mạnh, gấp 10-20 lần so với nhu cầu thèng bibica.net cần :D vấn đề hiệu năng không cần bàn tới nữa, chủ yếu nhất là hướng tới tính ổn định, cố gắng đạt uptime tốt nhất có thể (Oracle họ có thông báo về vấn đề bảo trì hệ thống định kì, mỗi cái không rõ họ có tự reboot lại VM không? gặp quả này thì .... chịu vậy :D dù rằng trên vài con VPS khác mình từng dùng trong khoảng 6 tháng qua thì không thấy vụ này)
