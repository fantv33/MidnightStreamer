# MidnightStreamer Panel v5.5.0

## Ubuntu versions
* Tested on **Ubuntu 18/20/22/24**
## Description
Below you can find instructions to install MidnightStreamer v5.5.0 offline. The installation process can be long, so let it run until it's done.
<br><br>The installation is based on the original files and a patched *odbc_db.php*.
<br><br>Do not log in and click **Activate** after installation. First copy **odbc_db.php** and then log in. If you don't follow the instructions you will have to reinstall until you do it right.
## Installation
1. Download the zip file from https://mega.nz/file/mc4FBYyK#GDX8lD_N0gZlJtteeHxScsxwPRgAfuhhEUEneFD8uFw

2. Make sure **ms_install_offline.sh** and **ms_install_5.5.0.tar.gz** are in the same directory

3. **Install the panel**
```
chmod 777 ms_install_offline.sh

./ms_install_offline.sh
```

4. **Copy odbc_db.php in**
```
/home/midnightstreamer/iptv_midnight_streamer/wwwdir/admin/system/database/drivers/odbc/

chmod 777 /home/midnightstreamer/iptv_midnight_streamer/wwwdir/admin/system/database/drivers/odbc/odbc_db.php
```

5. **Run this command in terminal**
```
echo -e "\n127.0.0.1 download.midnightstreamer.com" >> /etc/hosts
echo -e "\n127.0.0.1 download.mdstreamer.com" >> /etc/hosts
```

6. Login to the panel and change the **server IP** address in the server settings

**Enjoy**

<a href="https://github.com/fantv33/MidnightStreamer">Github()</a>
