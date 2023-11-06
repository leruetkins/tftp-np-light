
[<- Назад](faq-list.md)
# Как добавить свой образ Windows
### 1.  
Закидываете образ в формате `es` или `wim`  в папку:  
tftp-np\boot\soft\windows\sources
### 2.  
Делаете копию папки [tftp-np\boot\soft\windows\configs\jq][] и называете как хотите, например **win11** и получаем такой вот путь: tftp-np\boot\soft\windows\configs\win11 и запоминаете как назвали папку, потом мы вставим этот путь в файл меню.
### 3.  
В файле \tftp-np\boot\soft\windows\configs\win11\install.bat в конце замените **jq** на **win11**, что бы получилось так:
T:\configs\\**win11**\\commands.cmd
### 4.
В файл меню [tftp-np\public\menu.ejs][] добавляете новый пункт загрузки, что бы получилось вот так:  
item --gap WINDOWS INSTALL MENU  
item win11 ${space} * Windows 11 Unattend  
### 5.
Добавляете конфиг этого пункта меню в тот же файл меню [tftp-np\public\menu.ejs][]  для загрузки файлов, жирным выделена наша созданная папка **win11**:
```bash
:win11
echo Windows 11 Unattend    
echo
set http_path boot/soft/windows
kernel ${server_ip}:${port}/${http_path}/wimboot                              goto failed
initrd ${server_ip}:${port}/${http_path}/winpeshl.ini        winpeshl.ini     goto failed
initrd ${server_ip}:${port}/${http_path}/configs/win11/install.bat   install.bat      goto failed
initrd ${server_ip}:${port}/ip_json ip_json               goto failed
initrd ${server_ip}:${port}/boot/addons/jq.exe jq.exe               goto failed
initrd ${server_ip}:${port}/${http_path}/bcd                 BCD              goto failed
initrd ${server_ip}:${port}/${http_path}/boot.sdi            boot.sdi         goto failed
initrd ${server_ip}:${port}/${http_path}/sources/boot.wim    boot.wim         goto failed
boot || goto failed 
```
### 6.
Загружаетесь по PXE и выбираете этот пункт меню для загрузки.

[<- Назад](faq-list.md)

[tftp-np\boot\soft\windows\configs\jq]: ../boot/soft/windows/configs/jq

[tftp-np\public\menu.ejs]: ../public/menu.ejs
