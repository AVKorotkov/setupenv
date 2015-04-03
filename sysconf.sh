#!/bin/bash

# Этот скрипт делает настройку системы. Его
# нужно суперпользователю выполнить первым.

DEB_USER=$(grep 1000 /etc/passwd | awk -F: '{print $1}')

cp /home/$DEB_USER/setupenv/system.cfg.sh .
#cp /home/$DEB_USER/setupenv/sysconf.sh .
#cp /home/$DEB_USER/setupenv/setup.sh .
cp /home/$DEB_USER/setupenv/postconf.sh .
cp /home/$DEB_USER/setupenv/softlist.txt .
cp /home/$DEB_USER/setupenv/optsoftlist.txt .

chown root:root system.cfg.sh postconf.sh softlist.txt optsoftlist.txt
#chmod u+x system.cfg.sh postconf.sh

. system.cfg.sh

description
check_root
check_debian

echo "DEB_USER=\"$DEB_USER\"" >> system.cfg.sh

#
#. system.cfg.sh
#
#description
#check_root
#check_debian
#check_step "presys.sh"
#

# настройка репозиториев

echo "deb http://ftp.debian.org/debian/ wheezy-backports main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://ftp.debian.org/debian/ wheezy-backports main contrib non-free" >> /etc/apt/sources.list
echo "" >> /etc/apt/sources.list
echo "deb http://ftp.debian.org/debian/ wheezy-proposed-updates main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://ftp.debian.org/debian/ wheezy-proposed-updates main contrib non-free" >> /etc/apt/sources.list

echo "deb http://debian.neo4j.org/repo stable/" > /etc/apt/sources.list.d/neo4j.list
echo "deb http://deb.opera.com/opera/ stable non-free" > /etc/apt/sources.list.d/opera.list
echo "deb http://mozilla.debian.net/ wheezy-backports iceweasel-release" > /etc/apt/sources.list.d/iceweasel.list
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
echo "deb http://cran.r-project.org/bin/linux/debian wheezy-cran3/" > /etc/apt/sources.list.d/CRAN.list

wget -O - http://debian.neo4j.org/neotechnology.gpg.key| apt-key add - 
wget -O - http://deb.opera.com/archive.key | apt-key add -
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -

wget -O- -q http://mozilla.debian.net/archive.asc | gpg --import
gpg --check-sigs --fingerprint --keyring /usr/share/keyrings/debian-keyring.gpg 06C4AE2A
gpg --export -a 06C4AE2A | apt-key add -

apt-key adv --keyserver keys.gnupg.net --recv-key 381BA480

#wget -c http://mozilla.debian.net/pkg-mozilla-archive-keyring_1.1_all.deb
#dpkg -i pkg-mozilla-archive-keyring_1.1_all.deb

# обновление списка пакетов

aptitude update -y

# обновление системы

aptitude safe-upgrade -y

# установка последнего ядра и пакета заголовков

ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]
	then
		KERNEL=$(aptitude -F %p search linux-image-3.1 | sed -n -e 's/ //gp' | egrep 'amd64$' | tail -n 1)
		HEADERS=$(aptitude -F %p search linux-headers-3.1 | sed -n -e 's/ //gp' | egrep 'amd64$' | tail -n 1)
	else
		KERNEL=$(aptitude -F %p search linux-image-3.1 | sed -n -e 's/ //gp' | egrep 'pae$')
		HEADERS=$(aptitude -F %p search linux-headers-3.1 | sed -n -e 's/ //gp' | egrep 'pae$')
fi

# aptitude -F %p search linux-headers-3.1 | sed -n -e 's/ //gp' | egrep '586$'
# aptitude -F %p search linux-image-3.1 | sed -n -e 's/ //gp' | egrep '586$'

aptitude -t wheezy-backports install $KERNEL $HEADERS -y

# Устаногвка ПО

DEB_LIST=$(cat softlist.txt)

aptitude -t wheezy-backports install $DEB_LIST -y

# добавить
# rsync
# xfce4-xkb-plugin
# gksu
# gedit

# добавить пользователя в нужные группы

GROUP_LIST="cdrom audio fuse plugdev video www-data"

for GROUP in $GROUP_LIST
	do
		CHECK_GROUP=$(grep $DEB_USER /etc/group | grep $GROUP)
		if [[ $CHECK_GROUP = "" ]]
			then adduser $DEB_USER $GROUP
		fi
done

# Установка VirtualBox Guest Additions

mount /media/cdrom
cd /media/cdrom
sh VBoxLinuxAdditions.run
cd

# Устаногвка дополнительного ПО

echo "Установить дополнительное ПО?"

stty -icanon
echo -n "Нажмите клавишу Y для установки или любую другую для выхода "
READCHAR=$(dd if=/dev/tty bs=1 count=1 2>/dev/null)
case "$READCHAR" in
	y|Y)
		echo ""
		DEB_LIST=$(cat optsoftlist.txt)
		aptitude -t wheezy-backports install $DEB_LIST -y
		dpkg -i /home/$DEB_USER/rstudio*.deb
		;;
	*)
		echo ""
		;;
esac
stty icanon

step_write

this_is_done
