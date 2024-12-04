## MidnightStreamer v5.5.0

* **Tested on Ubuntu 22**

* **Download the zip file from https://mega.nz/file/mc4FBYyK#GDX8lD_N0gZlJtteeHxScsxwPRgAfuhhEUEneFD8uFw**

* **Make sure ms_install_offline.sh and ms_install_5.5.0.tar.gz are in the same directory**

1. **Install the panel**
```
chmod 777 ms_install_offline.sh

./ms_install_offline.sh
```

2. **Copy odbc_db.php in**
```
/home/midnightstreamer/iptv_midnight_streamer/wwwdir/admin/system/database/drivers/odbc/

chmod 777 /home/midnightstreamer/iptv_midnight_streamer/wwwdir/admin/system/database/drivers/odbc/odbc_db.php
```

3. **Run this command in terminal**
```
echo -e "\n127.0.0.1 download.midnightstreamer.com" >> /etc/hosts
echo -e "\n127.0.0.1 download.mdstreamer.com" >> /etc/hosts
```

4. **Login to the panel and change the server IP address in the server settings**

**Enjoy**
