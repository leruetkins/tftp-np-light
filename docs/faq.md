# Как добавить свой образ Windows
### 1.  
Закидываете образ в формате `es` или `wim`  в папку:  
tftp-np\boot\soft\windows\sources

Образы можно создать самостоятельно либо извлечь из папки `sources` образа Windows.
### 2.  
Делаете копию папки [tftp-np\boot\soft\windows\configs\jq][] и называете как хотите, например **win11** и получаем такой вот путь: tftp-np\boot\soft\windows\configs\win11 и запоминаете как назвали папку, потом мы вставим этот путь в файл меню.
### 3.  
В файле \tftp-np\boot\soft\windows\configs\win11\install.bat в конце замените **jq** на **win11**, что бы получилось так:
T:\configs\\**win11**\\commands.cmd
### 4.
В файл меню [tftp-np\public\menu.ejs][] добавляете новый пункт загрузки, что бы получилось вот так:  
```bash
item --gap WINDOWS INSTALL MENU  
    item win11 ${space} * Windows 11 Unattend
```  
### 5.
Добавляете конфиг этого пункта меню в тот же файл меню [tftp-np\public\menu.ejs][]  для загрузки файлов, жирным выделена наша созданная папка **win11**:
```bash
:win11
echo Windows 11 Unattend    
echo
set http_path boot/soft/windows
kernel ${server_ip}:${port}/${http_path}/wimboot                              || goto failed
initrd ${server_ip}:${port}/${http_path}/winpeshl.ini        winpeshl.ini     || goto failed
initrd ${server_ip}:${port}/${http_path}/configs/win11/install.bat   install.bat      || goto failed
initrd ${server_ip}:${port}/ip_json ip_json               || goto failed
initrd ${server_ip}:${port}/boot/addons/jq.exe jq.exe               || goto failed
initrd ${server_ip}:${port}/${http_path}/bcd                 BCD              || goto failed
initrd ${server_ip}:${port}/${http_path}/boot.sdi            boot.sdi         || goto failed
initrd ${server_ip}:${port}/${http_path}/sources/boot.wim    boot.wim         || goto failed
boot || goto failed 
```
### 6.
Загружаетесь по PXE и выбираете этот пункт меню для загрузки.

[<- Назад](faq-list.md)

[tftp-np\boot\soft\windows\configs\jq]: ../boot/soft/windows/configs/jq

[tftp-np\public\menu.ejs]: ../public/menu.ejs


# Настройка роутера на примере Mikrotik

## Установите настройки как показано на рисунках:
### 1.
![Screenshot_372](https://github.com/leruetkins/tftp-np-light/assets/15270519/c120b68a-c4d5-4dba-a488-542a6b964987)

### 2.
![Screenshot_373](https://github.com/leruetkins/tftp-np-light/assets/15270519/84876f9b-a4e6-4a82-a2d8-b5b9f82ae88b)

### 3.
![Screenshot_374](https://github.com/leruetkins/tftp-np-light/assets/15270519/f91f1d15-2852-49fe-9e5d-4b4b04e3ad69)

### 4.
![Screenshot_375](https://github.com/leruetkins/tftp-np-light/assets/15270519/9b62141c-c1f6-4f78-9f1b-4983c576473f)

### 5.
![Screenshot_376](https://github.com/leruetkins/tftp-np-light/assets/15270519/3add3bd4-f536-4e16-943d-56b95a01a837)

### 6.
![Screenshot_377](https://github.com/leruetkins/tftp-np-light/assets/15270519/a2d1bb6b-d972-4baf-9464-0f77015a61bb)

`PXEClient:Arch:00007:UNDI:003010`

[<- Назад](faq-list.md)
