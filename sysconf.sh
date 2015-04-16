#!/bin/bash

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Этот скрипт делает настройку системы. Его
# нужно суперпользователю выполнить первым.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DEB_USER=$(who -m | awk '{print $1}')
SETUPENV="/home/$DEB_USER/setupenv"

cp $SETUPENV/system.cfg.sh .
cp $SETUPENV/postconf.sh .
cp $SETUPENV/softlist.txt .
cp $SETUPENV/optsoftlist.txt .
cp $SETUPENV/utf.cnf .

chown root:root system.cfg.sh postconf.sh softlist.txt optsoftlist.txt utf.cnf
#chmod u+x system.cfg.sh postconf.sh

. system.cfg.sh

description
check_root
check_debian
check_step "preuser.sh"
ask_for_continue

echo "DEB_USER=\"$DEB_USER\"" >> system.cfg.sh
echo "SETUPENV=\"$SETUPENV\"" >> system.cfg.sh

# настройка репозиториев

echo "" >> /etc/apt/sources.list
echo "deb http://mirror.yandex.ru/debian/ wheezy-backports main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://mirror.yandex.ru/debian/ wheezy-backports main contrib non-free" >> /etc/apt/sources.list
echo "" >> /etc/apt/sources.list
echo "deb http://mirror.yandex.ru/debian/ wheezy-proposed-updates main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://mirror.yandex.ru/debian/ wheezy-proposed-updates main contrib non-free" >> /etc/apt/sources.list

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

# обновление списка пакетов

echo "Обновление списка пакетов..."
aptitude update -yq
echo "Обновление списка пакетов завершено."

# обновление системы

echo "Обновление системы..."
aptitude safe-upgrade -yq
echo "Обновление системы завершено."

# установка последнего ядра и пакетов заголовков

echo "Установка последнего ядра и пакетов заголовков..."

ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]
	then
		KERNEL=$(aptitude -F %p search linux-image-3.1 | sed -n -e 's/ //gp' | egrep 'amd64$' | tail -n 1)
		HEADERS=$(aptitude -F %p search linux-headers-3.1 | sed -n -e 's/ //gp' | egrep 'amd64$' | tail -n 1)
	else
		KERNEL=$(aptitude -F %p search linux-image-3.1 | sed -n -e 's/ //gp' | egrep 'pae$')
		HEADERS=$(aptitude -F %p search linux-headers-3.1 | sed -n -e 's/ //gp' | egrep 'pae$')
fi

CURRENT_HEADERS=$(aptitude -F %p search linux-headers | grep $(uname -a | awk '{print $3}'))

aptitude -t wheezy-backports install $KERNEL $HEADERS $CURRENT_HEADERS -yq
echo "Установка последнего ядра и пакета заголовков завершена."

# Установка ПО

echo "Начало установки ПО..."
DEB_LIST=$(cat softlist.txt)
aptitude -t wheezy-backports install $DEB_LIST -yq
echo "Установка ПО завершена."

# настройка MySQL на использование UTF-8

mv utf.cnf /etc/mysql/conf.d/
service mysql stop
service mysql start

# Установка дополнительного ПО

echo "Установить дополнительное ПО?"

stty -icanon
echo -n "Нажмите клавишу Y для установки или любую другую для выхода "
READCHAR=$(dd if=/dev/tty bs=1 count=1 2>/dev/null)
case "$READCHAR" in
	y|Y)
		echo ""
		echo "Начало установки дополнительного ПО..."
		DEB_LIST=$(cat optsoftlist.txt)
		aptitude -t wheezy-backports install $DEB_LIST -yq
		dpkg -i /home/$DEB_USER/rstudio*.deb
		echo "Установка дополнительного ПО завершена."
		;;
	*)
		echo ""
		;;
esac
stty icanon

# Добавить пользователя в нужные группы

GROUP_LIST="cdrom audio fuse plugdev video www-data"

for GROUP in $GROUP_LIST
	do
		CHECK_GROUP=$(grep $DEB_USER /etc/group | grep $GROUP)
		if [[ $CHECK_GROUP = "" ]]
			then adduser $DEB_USER $GROUP
		fi
done

# Установка VirtualBox Guest Additions

echo "Начало установки VirtualBox Guest Additions..."
mount -o ro /media/cdrom
cd /media/cdrom
IS_CD_VBGA=$(ls -lA | awk '{print $9}' | grep 'VBoxLinuxAdditions.run')
while [[ $IS_CD_VBGA = "" ]]
	do
		cd
		umount /media/cdrom
		echo "VBoxGuestAdditions не находится в виртуальном приводе."
		echo "В нижней панели виртуальной машины выберите образ"
		echo "оптического диска VBoxGuestAdditions и повторите попытку."
		echo -n "Повторить (Y/N)? "
		read ANSWER
		if [[ ${ANSWER^^} = "Y" ]]
			then
				mount -o ro /media/cdrom
			else
				echo "Установка VirtualBox Guest Additions не выполнена."
				exit 1
		fi
		cd /media/cdrom
		IS_CD_VBGA=$(ls -lA | awk '{print $9}' | grep 'VBoxLinuxAdditions.run')
done

sh VBoxLinuxAdditions.run
cd

echo "Установка VirtualBox Guest Additions завершена."
echo "Перезагрузите компьютер для того, чтобы"
echo "виртуальная машина начала их использовать."
echo ""

step_write

this_is_done
