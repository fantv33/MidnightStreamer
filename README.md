# MidnightStreamer Panel Pro v5.5.1

## Ubuntu versions
* Tested on **Ubuntu 18/20/22/24**
## Description
Below are the instructions to install MidnightStreamer Pro v5.5.1 offline.
## Installation
1. Git clone this repo or download and extract the zip file https://github.com/fantv33/MidnightStreamer/raw/main/MidnightStreamer_v5.5.1_INSTALL.zip

2. Make sure **ms_install_offline.sh** and **ms_install_5.5.1.tar.gz** are in the same directory

3. **Install the panel**
```
chmod 777 ms_install_offline.sh

./ms_install_offline.sh
```
After installation **DO NOT log in** and click **Activate**. First copy **odbc_db.php** and then log in.

4. **Copy odbc_db.php in**
```
/home/midnightstreamer/iptv_midnight_streamer/wwwdir/admin/system/database/drivers/odbc/

chmod 777 /home/midnightstreamer/iptv_midnight_streamer/wwwdir/admin/system/database/drivers/odbc/odbc_db.php
```

5. **Run this command in terminal**
```
echo -e "\n127.0.0.1 download.midnightstreamer.com" >> /etc/hosts
```

6. Login to the panel and change the **server IP** address in the server settings

**Enjoy**

* <a href="https://midnightstreamer.com">midnightstreamer.com</a>
* <a href="https://t.me/MidnightStreamerSupport">t.me/MidnightStreamerSupport</a>
* <a href="https://discord.com/invite/Qgcynns">Discord</a>
* <a href="https://github.com/fantv33/MidnightStreamer">Github</a>

[![Watch the video](https://img.youtube.com/vi/VkK4x84NpYo/maxresdefault.jpg)](https://youtube.com/watch?v=VkK4x84NpYo)


