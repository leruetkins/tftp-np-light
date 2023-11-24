# tftp-np - PXE server of dreams!  
## [FAQ](./docs/faq-list.md)
 
### Как использовать на Windows:

### 1.

Скачиваете образ iso, распаковываете просто как архив в любую папку, но желательно без пробелов и русских символов.

### 2.

Далее Вам необходимо выбрать режим, к котором будет работать **TFFT-NP**:

* **Вариант 1** - DHCP PROXY MODE:

    Появилась возможность запускать **TFFT-NP** в режиме DHCP PROXY MODE. По умолчанию после запуска сервер начинает работать именно в этом варианте и в заголовке программы будет надпись **DHCP PROXY MODE**. Если надпись не появилась, то необходимо  включить этот режим в настройках. Для этого после запуска сервера перейдите по адресу http://localhost:5000/config и установите галочку dhcp. Или сделайте это в файле `config.ini` и перезапустите сервер. Обязательно выставьте корректно свой IP адрес и маску подсети, если они неправильно определился автоматически (можно посчитать [тут](https://ip-calculator.ru/)).

* **Вариант 2** - Настройка DHCP сервера:

    1. Если у вас DHCP сервер на Linux, выставляем:

        ```bash
        option space PXE;
        option arch code 93 = unsigned integer 16;
        next-server xxx.xxx.xxx.xxx;
        if option arch = 00:07 {
            filename "boot/efi/bootx64.efi";
        } else {
            filename "boot/bios/undionly.kpxe";
        }
        ```

    2. Если у вас DHCP сервер от Microsoft, пуле ваших IP адресов, в разделе Scope Options добавляем параметры:

       ```bash
       066 Boot Server Host Name "Имя или адрес машины где запущен TFTP-NP, например 192.168.0.2"
       067 Bootfile Name "/boot/efi/bootx64.efi"
       ```

       Более подробно смотрите по [ссылке](https://wtware.ru/win/dhcp2012config.html)
    3. Если у вас DHCP сервер от Mikrotik с версией прошивки `ниже 7.0`, то выставляем только для BIOS или UEFI:
  
        <details>
        <summary>Фото:</summary>
        <img src="https://github.com/leruetkins/tftp-np-light/assets/15270519/026734c3-4a92-453a-ae2d-2c2d8b046961">
        </details>

    4. Если у вас DHCP сервер от Mikrotik с версией прошивки `выше 7.0`, то выставляем разные загрузочные файлы для BIOS и UEFI по [инструкции](./docs/config_mikrotik.md).

### 3.

Запускаете один раз от администратора tftp-np-1.8.3-x64.exe для расшаривания папки с софтом. Если обновляетесь с предыдущих версий, то нужно удалить старую шару, запустить от админа: `net share tftp-np /delete` или запустите от админа `tftp-np\tftp-np\boot\addons\scripts\admin_net_delete_tftp-np.bat`

### 4.

Грузитесь с другой машины по pxe, в настройках биоса укажите загрузку по сети, предварительно отключите `Secureboot`.

### 5.

При выводе запроса `Press secret key to continue...` нажмите сочетание клавиш `CTRL`+`S`

### 6.

Радуетесь)
