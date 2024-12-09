#! /bin/bash

PURPLE='\033[0;35m'
OKCYAN='\033[96m'
YELLOW='\033[93m'
NC='\033[0m' # No Color

#rm /root/ms_install_standalone.sh

if [ -d "/home/midnightstreamer/iptv_midnight_streamer/cms" ]; then
  	echo "${PURPLE}Wrong machine. Exiting${NC}"
  	exit 0
fi

pkill -9 nginx_iptv
pkill -9 nginx_rtmp
pkill -9 php-fpm
pkill -9 php
pkill -9 ffmpeg

/sbin/iptables -F midnightstreamer_mysql
/sbin/iptables -t filter -D INPUT -j midnightstreamer_mysql
/sbin/iptables -X midnightstreamer_mysql

p=apt-get

$p install tar -y

useradd -m midnightstreamer
#echo -e "iptv\niptv" | passwd midnightstreamer

echo "" > /tmp/crontab.txt

runuser -l midnightstreamer -c 'crontab /tmp/crontab.txt'

rm -rf /tmp/crontab.txt

if [ $p = "apt-get" ]; then
		service cron restart
else
		service crond restart
fi

current_dir=$PWD

cd /home/midnightstreamer

if [ "$PWD" = "/home/midnightstreamer" ]; then
		umount /home/midnightstreamer/iptv_midnight_streamer/streams
		umount /home/midnightstreamer/iptv_midnight_streamer/tmp

		rm -rf *
else
		echo "${PURPLE}Cannot remove directory /home/midnightstreamer. Exiting${NC}"
		exit 0
fi

cp $current_dir/ms_install_5.5.1.tar.gz /home/midnightstreamer/ms_install.tar.gz

tar -xvzf ms_install.tar.gz

cp ms_install.tar.gz /home/midnightstreamer/iptv_midnight_streamer/install/lb_install.tar.gz

rm -rf ms_install.tar.gz

echo "88767d3d73484f23c553a60cfa87e9f3833b67fb7dd63f7412fa3cca265bcb61fa9ef7e9198d11069fef8d84e438117b9e52fd8a1f722c54e64e73a00987aeab2ecm6OpizUYoZkjMQWqSy0fzYCRokwNS9+QeLGpXmgLyfEVQ7xEgSXVs0OfDSyh7KTwVzkLQeRKaRhKxyDhDGf0lz6YGdV3WpQaMfQw2b4FzBwiWs1mt5WU1l2Lt/zHhvXd3fxyEyk3oVR+obNJQknN8g6Kel5DYoW/VAkKEaPhWdmnubKXAJ0EklYCxfLQR+eLH+RX0HLXUwT97U7h5dD+Bf6dGJWw5By2O9qYeLatcsjpHbtW9Gx5Qb/gsSLy5quDGKheeVg2MknhBXhDLWCRULXzlXRo5/qij3V9Yb1Q4SfdNudTMRZHIn6KxY81SJ9osJ4OMxJLVGMAVqNwXZQ==" > /home/midnightstreamer/iptv_midnight_streamer/config
echo "ivyrIv6Id063SS9Hcwlet3ClDPz4l9Vgg53cmf35TGTVPGBi6f7g/QoJVdKD/S2k9tvKkJF5j8iuKx9Hu4b2cKFO6Z7oB7RUTCHunmM76QtOhVW4dTKVN2um0Yn39ua1rjgMvQK1diDUH/N8yXkxzisHaJlHIBFtHMHUnnOuXi3iDHbHk2pUtmoGl4gDR65NFmZW7eHDum4arfUp4x7IC/qHYgSKtvkEPeH9F500gIffYPErxHdvvizPwe3Vk0HvgsW6Gy0/52Tzs2BSPOvoDveK+ibJPYczQhFNR94zCPINe5L+9EhJ98vxUQTFKXOfClNDSR+0SOq9MEbfy82Z4tABf8oxS4iG17nMnRG0dB9YMppChv8y9m6cGMRs55F1NjxlVZECoP8ukNkpwJmJRb08NGXJhKYaz+vckWXyOSed5cbK+Wml3b9Mc2n3P77H+/3u9b/ua7PoimeEKJsFIVzOd1FIeWTMwHz8lrG6P1+R7ZfCKgp7jboc1FfzL4gfah9XsQ5AGoOX4qhpaWFH3VXGhAIPw2kdVt/eZtQotdoYozUC9FMiQr5BgkeM7dhx/PnbgoCrcNS+XfFnPv0obfWAsCWt6mF1lfznQqLjEcd962heqcEfAmtEo4wqgrQG2pHvjck+kniYviQSPSPXFy12RB+fFUqJVompRLnAq7Q=" > /home/midnightstreamer/iptv_midnight_streamer/license

chown midnightstreamer:midnightstreamer /home/midnightstreamer/iptv_midnight_streamer/config
chown midnightstreamer:midnightstreamer /home/midnightstreamer/iptv_midnight_streamer/license

if [ $p = "apt-get" ]; then
		mv /home/midnightstreamer/iptv_midnight_streamer/start_services_deb.sh /home/midnightstreamer/iptv_midnight_streamer/start_services.sh
		rm -rf /home/midnightstreamer/iptv_midnight_streamer/start_services_rh.sh

		mv /home/midnightstreamer/iptv_midnight_streamer/php/bin/php_deb /home/midnightstreamer/iptv_midnight_streamer/php/bin/php
		mv /home/midnightstreamer/iptv_midnight_streamer/php/sbin/php-fpm_deb /home/midnightstreamer/iptv_midnight_streamer/php/sbin/php-fpm

		rm /home/midnightstreamer/iptv_midnight_streamer/php/bin/php_rh
		rm /home/midnightstreamer/iptv_midnight_streamer/php/sbin/php-fpm_rh
else
		mv /home/midnightstreamer/iptv_midnight_streamer/start_services_rh.sh /home/midnightstreamer/iptv_midnight_streamer/start_services.sh
		rm -rf /home/midnightstreamer/iptv_midnight_streamer/start_services_deb.sh

		mv /home/midnightstreamer/iptv_midnight_streamer/php/bin/php_rh /home/midnightstreamer/iptv_midnight_streamer/php/bin/php
		mv /home/midnightstreamer/iptv_midnight_streamer/php/sbin/php-fpm_rh /home/midnightstreamer/iptv_midnight_streamer/php/sbin/php-fpm

		rm /home/midnightstreamer/iptv_midnight_streamer/php/bin/php_deb
		rm /home/midnightstreamer/iptv_midnight_streamer/php/sbin/php-fpm_deb

		setenforce 0
		sed -i 's/enforcing/disabled/g' /etc/selinux/config
fi

grep -v "midnightstreamer" /etc/security/limits.conf > /tmp/limits.tmp && mv /tmp/limits.tmp /etc/security/limits.conf

echo "midnightstreamer soft nproc 265536" >> /etc/security/limits.conf
echo "midnightstreamer hard nproc 265535" >> /etc/security/limits.conf
echo "midnightstreamer soft nofile 265535" >> /etc/security/limits.conf
echo "midnightstreamer hard nofile 265535" >> /etc/security/limits.conf

sed -i '/net.core.somaxconn = 65535/d' /etc/sysctl.conf
sed -i '/net.ipv4.route.flush=1/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_no_metrics_save=1/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_moderate_rcvbuf = 1/d' /etc/sysctl.conf
sed -i '/fs.file-max = 6815744/d' /etc/sysctl.conf
sed -i '/fs.aio-max-nr = 6815744/d' /etc/sysctl.conf
sed -i '/fs.nr_open = 6815744/d' /etc/sysctl.conf
sed -i '/net.ipv4.ip_local_port_range = 1024 65000/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_sack = 1/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_rmem = 10000000 10000000 10000000/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_wmem = 10000000 10000000 10000000/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_mem = 10000000 10000000 10000000/d' /etc/sysctl.conf
sed -i '/net.core.rmem_max = 524287/d' /etc/sysctl.conf
sed -i '/net.core.wmem_max = 524287/d' /etc/sysctl.conf
sed -i '/net.core.rmem_default = 524287/d' /etc/sysctl.conf
sed -i '/net.core.wmem_default = 524287/d' /etc/sysctl.conf
sed -i '/net.core.netdev_max_backlog = 300000/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_max_syn_backlog = 300000/d' /etc/sysctl.conf
sed -i '/net.netfilter.nf_conntrack_max=1215196608/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_window_scaling = 1/d' /etc/sysctl.conf
sed -i '/vm.max_map_count = 655300/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_max_tw_buckets = 1440000/d' /etc/sysctl.conf
sed -i '/kernel.shmmax=134217728/d' /etc/sysctl.conf
sed -i '/kernel.shmall=134217728/d' /etc/sysctl.conf

echo "net.core.somaxconn = 65535" >> /etc/sysctl.conf
echo "net.ipv4.route.flush=1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_no_metrics_save=1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_moderate_rcvbuf = 1" >> /etc/sysctl.conf
echo "fs.file-max = 6815744" >> /etc/sysctl.conf
echo "fs.aio-max-nr = 6815744" >> /etc/sysctl.conf
echo "fs.nr_open = 6815744" >> /etc/sysctl.conf
echo "net.ipv4.ip_local_port_range = 1024 65000" >> /etc/sysctl.conf
echo "net.ipv4.tcp_sack = 1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_rmem = 10000000 10000000 10000000" >> /etc/sysctl.conf
echo "net.ipv4.tcp_wmem = 10000000 10000000 10000000" >> /etc/sysctl.conf
echo "net.ipv4.tcp_mem = 10000000 10000000 10000000" >> /etc/sysctl.conf
echo "net.core.rmem_max = 524287" >> /etc/sysctl.conf
echo "net.core.wmem_max = 524287" >> /etc/sysctl.conf
echo "net.core.rmem_default = 524287" >> /etc/sysctl.conf
echo "net.core.wmem_default = 524287" >> /etc/sysctl.conf
echo "net.core.optmem_max = 524287" >> /etc/sysctl.conf
echo "net.core.netdev_max_backlog = 300000" >> /etc/sysctl.conf
echo "net.ipv4.tcp_max_syn_backlog = 300000" >> /etc/sysctl.conf
echo "net.netfilter.nf_conntrack_max=1215196608" >> /etc/sysctl.conf
echo "net.ipv4.tcp_window_scaling = 1" >> /etc/sysctl.conf
echo "vm.max_map_count = 655300" >> /etc/sysctl.conf
echo "net.ipv4.tcp_max_tw_buckets = 1440000" >> /etc/sysctl.conf
echo "kernel.shmmax=134217728" >> /etc/sysctl.conf
echo "kernel.shmall=134217728" >> /etc/sysctl.conf

sysctl -p

#echo "/home/midnightstreamer/iptv_midnight_streamer/lib" > /etc/ld.so.conf.d/midnightstreamer.conf

#ldconfig

echo "#!/bin/sh" > /etc/init.d/midnightstreamer_panel
echo "### BEGIN INIT INFO" >> /etc/init.d/midnightstreamer_panel
echo "# Provides:          Midnightstreamer" >> /etc/init.d/midnightstreamer_panel
echo "# Required-Start:" >> /etc/init.d/midnightstreamer_panel
echo "# Required-Stop:" >> /etc/init.d/midnightstreamer_panel
echo "# Default-Start:     2 3 4 5" >> /etc/init.d/midnightstreamer_panel
echo "# Default-Stop:" >> /etc/init.d/midnightstreamer_panel
echo "# Short-Description: Starts Midnightstreamer Panel..." >> /etc/init.d/midnightstreamer_panel
echo "### END INIT INFO" >> /etc/init.d/midnightstreamer_panel
echo "/bin/sh /home/midnightstreamer/iptv_midnight_streamer/start_services.sh" >> /etc/init.d/midnightstreamer_panel

chmod 755 /etc/init.d/midnightstreamer_panel

update-rc.d -f midnightstreamer_panel defaults
systemctl enable midnightstreamer_panel

sed -i 's/{HTTP_PORT}/8000/g' /home/midnightstreamer/iptv_midnight_streamer/nginx/conf/nginx.conf
sed -i 's/{HTTPS}//g' /home/midnightstreamer/iptv_midnight_streamer/nginx/conf/nginx.conf
sed -i 's/{HTTPS_PORT}/8001/g' /home/midnightstreamer/iptv_midnight_streamer/nginx/conf/nginx.conf
sed -i 's/{ADMIN_NGINX}/    location \/admin\/ { try_files $uri $uri\/ \/admin\/index.php?$args; }/g' /home/midnightstreamer/iptv_midnight_streamer/nginx/conf/nginx.conf
sed -i 's/{RTMP_PORT}/8002/g' /home/midnightstreamer/iptv_midnight_streamer/nginx_rtmp/conf/nginx.conf
sed -i 's/{HTTP_PORT}/8000/g' /home/midnightstreamer/iptv_midnight_streamer/nginx_rtmp/conf/nginx.conf

if awk -F= '/^NAME/{print $2}' /etc/os-release | grep -iqF debian; then
   echo "deb [trusted=yes] http://httpredir.debian.org/debian jessie main contrib non-free" > /etc/apt/sources.list.d/midnightstreamer.list
   echo "deb-src [trusted=yes] http://httpredir.debian.org/debian jessie main contrib non-free" >> /etc/apt/sources.list.d/midnightstreamer.list
   echo "deb [trusted=yes] http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list.d/midnightstreamer.list
   echo "deb-src [trusted=yes] http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list.d/midnightstreamer.list
fi

if awk -F= '/^NAME/{print $2}' /etc/os-release | grep -iqF ubuntu; then
   echo "deb [trusted=yes] http://de.archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse" > /etc/apt/sources.list.d/midnightstreamer.list
   echo "deb-src [trusted=yes] http://de.archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse" >> /etc/apt/sources.list.d/midnightstreamer.list
   echo "deb [trusted=yes] http://de.archive.ubuntu.com/ubuntu/ trusty-security main restricted universe multiverse" >> /etc/apt/sources.list.d/midnightstreamer.list
   echo "deb [trusted=yes] http://de.archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list.d/midnightstreamer.list
   echo "deb [trusted=yes] http://de.archive.ubuntu.com/ubuntu/ trusty-proposed main restricted universe multiverse" >> /etc/apt/sources.list.d/midnightstreamer.list
   echo "deb [trusted=yes] http://de.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list.d/midnightstreamer.list
   echo "deb-src [trusted=yes] http://de.archive.ubuntu.com/ubuntu/ trusty-security main restricted universe multiverse" >> /etc/apt/sources.list.d/midnightstreamer.list
   echo "deb-src [trusted=yes] http://de.archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list.d/midnightstreamer.list
   echo "deb-src [trusted=yes] http://de.archive.ubuntu.com/ubuntu/ trusty-proposed main restricted universe multiverse" >> /etc/apt/sources.list.d/midnightstreamer.list
   echo "deb-src [trusted=yes] http://de.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list.d/midnightstreamer.list
fi

if [ $p = "apt-get" ]; then
		sed -i 's/#$nrconf{restart} = '"'"'i'"'"';/$nrconf{restart} = '"'"'a'"'"';/g' /etc/needrestart/needrestart.conf
		sed -i 's/$nrconf{restart} = '"'"'i'"'"';/$nrconf{restart} = '"'"'a'"'"';/g' /etc/needrestart/needrestart.conf

		#apt-get install libxml2-dev libxslt1-dev python-dev libpq5 libmcrypt4 libltdl7 libjpeg62 -y

		apt-get update

		export DEBIAN_FRONTEND=noninteractive

		apt-get install libxslt1.1 -y
		apt-get install libpq5 -y
		apt-get install libmcrypt4 -y
		apt-get install libltdl7 -y
		apt-get install libjpeg62 -y
		apt-get install libpng12-0 -y
		apt-get install libpng16-16 -y
		apt-get install libssl1.0.0 -y
		apt-get install sudo -y
		apt-get install xz-utils -y
		apt-get install libzip4 -y
		apt-get install libzip5 -y
		apt-get install nscd -y
		apt-get install python -y
		apt-get install libcurl3 -y
		apt-get install libssh2-1 -y
		apt-get install openssl -y
		apt-get install certbot -y
		apt-get install ntpdate -y
		apt-get install psmisc -y
		apt-get install dialog -y
		apt-get install jq -y
		apt-get install iptables -y
		apt-get install cron -y

		apt-get install python3-pip -y

		pip install rebulk
		pip install importlib_resources
		pip install python-dateutil
		pip install babelfish

		ln -s /usr/lib/ssl /usr/local/ssl

		ln -s /usr/lib/x86_64-linux-gnu/libzip.so.5 /usr/lib/x86_64-linux-gnu/libzip.so.4

		rm -rf /home/midnightstreamer/iptv_midnight_streamer/php/bin/libzip5-1.5.2-1.el7.remi.x86_64.rpm
else
		yum install epel-release -y
		yum install libxslt.x86_64 -y
		yum install libmcrypt -y
		yum install libjpeg -y
		yum install nscd -y
		yum install python -y
		yum install libssh2 -y
		yum install openssl -y
		yum install certbot -y
		yum install ntpdate -y
		yum install dialog -y
		yum install jq -y
		yum install iptables -y
		yum install cron -y

		yum install python3-pip -y
		pip install rebulk
		pip install importlib_resources
		pip install python-dateutil
		pip install babelfish

		rpm -i /home/midnightstreamer/iptv_midnight_streamer/php/bin/libzip5-1.5.2-1.el7.remi.x86_64.rpm
		rm -rf /home/midnightstreamer/iptv_midnight_streamer/php/bin/libzip5-1.5.2-1.el7.remi.x86_64.rpm
fi

openssl req -x509 -newkey rsa:4096 -sha256 -nodes -keyout /home/midnightstreamer/iptv_midnight_streamer/nginx/conf/server.key -out /home/midnightstreamer/iptv_midnight_streamer/nginx/conf/server.crt -subj "/CN=127.0.0.1" -days 999999

grep -v "midnightstreamer" /etc/sudoers > /tmp/sudoers.tmp && mv /tmp/sudoers.tmp /etc/sudoers

echo "midnightstreamer ALL = (ALL) NOPASSWD:ALL" >> /etc/sudoers

grep -v "midnightstreamer" /etc/fstab > /tmp/fstab.tmp && mv /tmp/fstab.tmp /etc/fstab

echo "tmpfs /home/midnightstreamer/iptv_midnight_streamer/streams tmpfs defaults,noatime,nosuid,nodev,noexec,mode=0777,size=90% 0 0" >> /etc/fstab
echo "tmpfs /home/midnightstreamer/iptv_midnight_streamer/tmp tmpfs defaults,noatime,nosuid,nodev,noexec,mode=0777,size=800M 0 0" >> /etc/fstab

mount -a

mkdir /home/midnightstreamer/iptv_midnight_streamer/streams/tmp
chown midnightstreamer:midnightstreamer /home/midnightstreamer/iptv_midnight_streamer/streams/tmp
chmod 777 /home/midnightstreamer/iptv_midnight_streamer/streams/tmp

if [ $p = "apt-get" ]; then
		apt-get install libharfbuzz0b -y
		apt-get install libgraphite2-3 -y
		apt-get install libva1 -y
		apt-get install libva-drm1 -y
		apt-get install libva2 -y
		apt-get install libva-drm2 -y
		apt-get install libfribidi0 -y

		apt-get install systemd -y
		apt-get install build-essential -y
		apt-get purge nvidia-* -y
		apt-get autoremove -y

		echo "blacklist nouveau" > /etc/modprobe.d/nvidia-installer-disable-nouveau.conf
		echo "options nouveau modeset=0" >> /etc/modprobe.d/nvidia-installer-disable-nouveau.conf
		update-initramfs -u
		
		nvidia-uninstall --silent
		sh /home/midnightstreamer/iptv_midnight_streamer/NVIDIA-Linux-x86_64-440.44.run --silent --install-libglvnd
		rm /home/midnightstreamer/iptv_midnight_streamer/NVIDIA-Linux-x86_64-440.44.run

		if [ -f /usr/lib/x86_64-linux-gnu/libva.so.2 ]; then
    		rm /home/midnightstreamer/iptv_midnight_streamer/bin/ffmpeg
    		rm /home/midnightstreamer/iptv_midnight_streamer/bin/ffprobe
    		mv /home/midnightstreamer/iptv_midnight_streamer/bin/ffmpeg2 /home/midnightstreamer/iptv_midnight_streamer/bin/ffmpeg
    		mv /home/midnightstreamer/iptv_midnight_streamer/bin/ffprobe2 /home/midnightstreamer/iptv_midnight_streamer/bin/ffprobe
		else
				rm /home/midnightstreamer/iptv_midnight_streamer/bin/ffmpeg2
				rm /home/midnightstreamer/iptv_midnight_streamer/bin/ffprobe2
		fi

		apt-mark hold libcurl3
else
		yum install harfbuzz -y
		yum install fribidi -y
		yum install libva -y

		yum groupinstall "Development tools" -y

		echo "blacklist nouveau" > /etc/modprobe.d/nvidia-installer-disable-nouveau.conf
		echo "options nouveau modeset=0" >> /etc/modprobe.d/nvidia-installer-disable-nouveau.conf
		dracut -f

		nvidia-uninstall --silent
		sh /home/midnightstreamer/iptv_midnight_streamer/NVIDIA-Linux-x86_64-440.44.run --silent --install-libglvnd
		rm /home/midnightstreamer/iptv_midnight_streamer/NVIDIA-Linux-x86_64-440.44.run

		if [ -f /usr/lib/x86_64-linux-gnu/libva.so.2 ]; then
    		rm /home/midnightstreamer/iptv_midnight_streamer/bin/ffmpeg
    		rm /home/midnightstreamer/iptv_midnight_streamer/bin/ffprobe
    		mv /home/midnightstreamer/iptv_midnight_streamer/bin/ffmpeg2 /home/midnightstreamer/iptv_midnight_streamer/bin/ffmpeg
    		mv /home/midnightstreamer/iptv_midnight_streamer/bin/ffprobe2 /home/midnightstreamer/iptv_midnight_streamer/bin/ffprobe
		else
				rm /home/midnightstreamer/iptv_midnight_streamer/bin/ffmpeg2
				rm /home/midnightstreamer/iptv_midnight_streamer/bin/ffprobe2
		fi
fi

service mysql stop
																																																									 systemctl stop mysql
																																																									 systemctl disable mysql
																																																									 pkill -9 mysqld_safe
																																																									 pkill -9 mysqld
																																																														sudo debconf-set-selections <<< 'mariadb-server mysql-server/root_password password iptv';
																																																														sudo debconf-set-selections <<< 'mariadb-server mysql-server/root_password_again password iptv';
																																																												 		sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password iptv';
																																																												 		sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password iptv';
																																																												 		sudo debconf-set-selections <<< 'mysql-server-5.6 mysql-server/root_password password iptv';
																																																												 		sudo debconf-set-selections <<< 'mysql-server-5.6 mysql-server/root_password_again password iptv';
																																																												 		sudo debconf-set-selections <<< 'mysql-server-5.7 mysql-server/root_password password iptv';
																																																												 		sudo debconf-set-selections <<< 'mysql-server-5.7 mysql-server/root_password_again password iptv';
																																																												 		sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password iptv';
																																																												 		sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password iptv';
																																																												 		sudo apt-get -y install mariadb-server systemd;
																																																												 rm -rf /etc/mysql/mariadb.cnf; mv /home/midnightstreamer/iptv_midnight_streamer/my_deb.cnf /etc/mysql/mariadb.cnf
																																																												 sed -i 's/{DB_PORT}/7999/g' /etc/mysql/mariadb.cnf
																																																												 chmod 755 /etc/mysql/mariadb.cnf /etc/mysql/mysql.cnf
																																																												 mkdir /etc/systemd/system/mysql.service.d
																																																												 echo "[Service]" > /etc/systemd/system/mysql.service.d/limits.conf
																																																												 echo "LimitNOFILE=infinity" >> /etc/systemd/system/mysql.service.d/limits.conf
																																																												 echo "LimitMEMLOCK=infinity" >> /etc/systemd/system/mysql.service.d/limits.conf

																																																												 mkdir /etc/mysql
																																																												 mkdir /etc/mysql/ssl
																																																												 openssl req -x509 -newkey rsa:4096 -sha256 -nodes -keyout /etc/mysql/ssl/server-key.pem -out /etc/mysql/ssl/server-cert.pem -subj "/CN=db.midnightstreamer.com" -days 999999
																																																												 openssl rsa -in /etc/mysql/ssl/server-key.pem -out /etc/mysql/ssl/server-key.pem
																																																												 chown -R mysql:mysql /etc/mysql/ssl/
																																																												 chmod -R 755 /etc/mysql/ssl/

																																																												 systemctl enable mariadb.service
																																																												 systemctl enable mysql.service
																																																												 systemctl daemon-reload
																																																												 service mariadb restart
																																																												 service mysql restart
																																																												 echo -e "${YELLOW}\nPLEASE WAIT. DON'T INTERRUPT THE INSTALLATION${NC}\n"
																																																												 mysql -u root -p"iptv" -e "DROP DATABASE IF EXISTS midnight_iptv;CREATE DATABASE midnight_iptv CHARACTER SET utf8 COLLATE utf8_general_ci;DROP DATABASE IF EXISTS midnight_migrate;CREATE DATABASE midnight_migrate CHARACTER SET utf8 COLLATE utf8_general_ci;"
																																																									 			 mysql -u root -p"iptv" midnight_iptv < /home/midnightstreamer/iptv_midnight_streamer/fresh_install.sql
																																																									 			 mysql -u root -p"iptv" midnight_iptv -e "INSERT INTO servers (id, name, max_allowed_connections, guaranteed_speed, http_port, https_port, rtmp_port, server_ip, hostname, ssh_password, ssh_port, main, mysql_persistent_connections, fastcgi_services, ca, geoip_lb, isp_lb, do_update, disabled, version) VALUES (1, 'Main Server', 1000, 1000, '8000', '8001', '8002', '127.0.0.1', null, '', 22, 1, 0, 3, '$(cat /home/midnightstreamer/iptv_midnight_streamer/nginx/conf/server.crt)' , 0, 0, 0, 0, '5.2.7');
																																																									 																														 INSERT INTO syncs (server_id, name) VALUES (1, 'cronjobs');
																																																									 																														 INSERT INTO syncs (server_id, name) VALUES (1, 'blocked_ips');
																																																									 																														 INSERT INTO syncs (server_id, hash, name) VALUES (1, 'eyJodHRwX3BvcnQiOjgwMDAsImh0dHBzX3BvcnQiOjgwMDEsInJ0bXBfcG9ydCI6ODAwMiwiYWRkaXRpb25hbF9odHRwX3BvcnRzIjpudWxsLCJhZGRpdGlvbmFsX2h0dHBzX3BvcnRzIjpudWxsLCJwcm94eV9wb3J0IjowLCJwcm94eV9wYXNzd29yZCI6bnVsbCwiZmFzdGNnaV9zZXJ2aWNlcyI6IjMiLCJob3N0bmFtZSI6bnVsbCwiZW5hYmxlX2lwdjYiOmZhbHNlLCJhbGxvd19leHRlcm5hbF9zY3JpcHRzIjpmYWxzZSwibGV0c2VuY3J5cHQiOmZhbHNlLCJ1cHN0cmVhbV9zZXJ2ZXJfaWQiOm51bGwsImh0dHBfcHJveHlfcG9ydCI6bnVsbCwiYWRkaXRpb25hbF9uZ2lueF9jb25mIjpudWxsfQ==', 'settings');
																																																									 																														 INSERT INTO syncs (server_id, hash, name) VALUES (1, '88767d3d73484f23c553a60cfa87e9f3833b67fb7dd63f7412fa3cca265bcb61fa9ef7e9198d11069fef8d84e438117b9e52fd8a1f722c54e64e73a00987aeab2ecm6OpizUYoZkjMQWqSy0fzYCRokwNS9+QeLGpXmgLyfEVQ7xEgSXVs0OfDSyh7KTwVzkLQeRKaRhKxyDhDGf0lz6YGdV3WpQaMfQw2b4FzBwiWs1mt5WU1l2Lt/zHhvXd3fxyEyk3oVR+obNJQknN8g6Kel5DYoW/VAkKEaPhWdmnubKXAJ0EklYCxfLQR+eLH+RX0HLXUwT97U7h5dD+Bf6dGJWw5By2O9qYeLatcsjpHbtW9Gx5Qb/gsSLy5quDGKheeVg2MknhBXhDLWCRULXzlXRo5/qij3V9Yb1Q4SfdNudTMRZHIn6KxY81SJ9osJ4OMxJLVGMAVqNwXZQ==', 'config');
																																																									 																														 INSERT INTO administrators (username, password, email, language) VALUES ('admin', '2cd71063c6a79832cdfeb889f4c072e425067fe2', 'example@domain.com', 'en');
																																																									 																														 UPDATE settings SET admin_paths = '["\"admin\""]', preview_pass = 'hn6SImdyx7', stalker_key = '02230129b6ad71bae0292032450090cd', api_key = 'dtqVa5xwoU';
																																																									 																														 GRANT ALL PRIVILEGES ON midnight_iptv.* TO 'midnightstreamer'@'localhost' IDENTIFIED BY 'pglauD4F0L';
																																																									 																														 GRANT SELECT ON mysql.proc to 'midnightstreamer'@'localhost';
																																																									 																														 GRANT SUPER ON *.* TO 'midnightstreamer'@'localhost' IDENTIFIED BY 'pglauD4F0L';
																																																									 																														 GRANT ALL PRIVILEGES ON midnight_iptv.* TO 'midnightstreamer'@'%' IDENTIFIED BY 'pglauD4F0L';
																																																									 																														 GRANT SELECT ON mysql.proc to 'midnightstreamer'@'%';
																																																									 																														 GRANT SUPER ON *.* TO 'midnightstreamer'@'%' IDENTIFIED BY 'pglauD4F0L';
																																																									 																														 GRANT ALL PRIVILEGES ON midnight_migrate.* TO 'midnightstreamer'@'127.0.0.1' IDENTIFIED BY 'pglauD4F0L' WITH GRANT OPTION;
																																																																																							 GRANT ALL PRIVILEGES ON midnight_migrate.* TO 'midnightstreamer'@'localhost' IDENTIFIED BY 'pglauD4F0L' WITH GRANT OPTION;
																																																																																							 GRANT ALL PRIVILEGES ON midnight_migrate.* TO 'midnightstreamer'@'%' IDENTIFIED BY 'pglauD4F0L' WITH GRANT OPTION;
																																																									 																														 FLUSH PRIVILEGES;"

rm -rf /home/midnightstreamer/iptv_midnight_streamer/my_deb.cnf
rm -rf /home/midnightstreamer/iptv_midnight_streamer/my_rh.cnf
rm -rf /home/midnightstreamer/iptv_midnight_streamer/fresh_install.sql

mv /usr/bin/curl /usr/bin/curl_old
mv /home/midnightstreamer/iptv_midnight_streamer/curl /usr/bin/curl

service rsyslog stop
systemctl disable rsyslog

chown midnightstreamer:midnightstreamer /home/midnightstreamer/iptv_midnight_streamer -R

echo "*/1 * * * * /home/midnightstreamer/iptv_midnight_streamer/php/bin/php /home/midnightstreamer/iptv_midnight_streamer/wwwdir/index.php startup # MidnightStreamer IPTV Panel" > /tmp/crontab.txt
echo "*/1 * * * * /home/midnightstreamer/iptv_midnight_streamer/php/bin/php /home/midnightstreamer/iptv_midnight_streamer/wwwdir/index.php cron_live # MidnightStreamer IPTV Panel" >> /tmp/crontab.txt
echo "*/1 * * * * /home/midnightstreamer/iptv_midnight_streamer/php/bin/php /home/midnightstreamer/iptv_midnight_streamer/wwwdir/index.php cron_prepare # MidnightStreamer IPTV Panel" >> /tmp/crontab.txt
echo "*/5 * * * * /home/midnightstreamer/iptv_midnight_streamer/php/bin/php /home/midnightstreamer/iptv_midnight_streamer/wwwdir/index.php cron_cleanup_ts # MidnightStreamer IPTV Panel" >> /tmp/crontab.txt
echo "*/5 * * * * /home/midnightstreamer/iptv_midnight_streamer/php/bin/php /home/midnightstreamer/iptv_midnight_streamer/wwwdir/index.php cron_sync_server # MidnightStreamer IPTV Panel" >> /tmp/crontab.txt
echo "*/1 * * * * /home/midnightstreamer/iptv_midnight_streamer/php/bin/php /home/midnightstreamer/iptv_midnight_streamer/wwwdir/index.php cron_check_tools # MidnightStreamer IPTV Panel" >> /tmp/crontab.txt
echo "*/1 * * * * /home/midnightstreamer/iptv_midnight_streamer/php/bin/php /home/midnightstreamer/iptv_midnight_streamer/wwwdir/index.php cron_archive # MidnightStreamer IPTV Panel" >> /tmp/crontab.txt
echo "*/1 * * * * /home/midnightstreamer/iptv_midnight_streamer/php/bin/php /home/midnightstreamer/iptv_midnight_streamer/wwwdir/index.php cron_check_server_watchdog # MidnightStreamer IPTV Panel" >> /tmp/crontab.txt
echo "0 0 */1 * * /home/midnightstreamer/iptv_midnight_streamer/php/bin/php /home/midnightstreamer/iptv_midnight_streamer/wwwdir/index.php cron_geoip # MidnightStreamer IPTV Panel" >> /tmp/crontab.txt
echo "0 *5 * * * /home/midnightstreamer/iptv_midnight_streamer/php/bin/php /home/midnightstreamer/iptv_midnight_streamer/wwwdir/index.php cron_epg # MidnightStreamer IPTV Panel" >> /tmp/crontab.txt
echo "*/5 * * * * /home/midnightstreamer/iptv_midnight_streamer/php/bin/php /home/midnightstreamer/iptv_midnight_streamer/wwwdir/index.php cron_cleanup_logs # MidnightStreamer IPTV Panel" >> /tmp/crontab.txt

runuser -l midnightstreamer -c 'crontab /tmp/crontab.txt'

rm -rf /tmp/crontab.txt

#echo "0 */5 * * * sync && echo 3 | sudo tee /proc/sys/vm/drop_caches # MidnightStreamer IPTV Panel" > /tmp/crontab.txt

#crontab /tmp/crontab.txt

if [ $p = "apt-get" ]; then
		service cron restart
else
		service crond restart
fi

#rm -rf /tmp/crontab.txt

sh /home/midnightstreamer/iptv_midnight_streamer/start_services.sh

runuser -l midnightstreamer -c '/home/midnightstreamer/iptv_midnight_streamer/php/bin/php /home/midnightstreamer/iptv_midnight_streamer/wwwdir/index.php cron_sync_server'

ntpdate ntp.ubuntu.com

echo -e "${OKCYAN}\n\nInstallation complete\041\n${NC}"
echo -e "${OKCYAN}You can access your panel visiting:\n${NC}"
echo -e "${OKCYAN} +----------------------------------+"
echo -e "${OKCYAN} | http://your_server_ip:8000/admin |${NC}"
echo -e "${OKCYAN} | Username: admin                  |\n | Password: iptv                   |${NC}"
echo -e "${OKCYAN} +----------------------------------+"
echo -e "${OKCYAN}\n MariaDB root password: iptv\n MariaDB midnightstreamer password: pglauD4F0L${NC}\n"

history -c
