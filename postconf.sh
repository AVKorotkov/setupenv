#!/bin/bash

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Этот скрипт завершает настройку системы. Его
# нужно суперпользователю выполнить последним.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

. system.cfg.sh

description
check_root
check_debian
check_step "userconf.sh"
ask_for_continue

# Настройка времени

sed -i 's/Moscow/Samara/' /etc/timezone
dpkg-reconfigure tzdata

# Установка Java

dpkg -i /home/$DEB_USER/oracle*.deb

# настройка Java

JAVA_JDK_ORACLE=$(update-alternatives --list java | egrep 'jdk-[0-9]+-oracle')
JAVAC_JDK_ORACLE=$(update-alternatives --list javac | egrep 'jdk-[0-9]+-oracle')
JAVADOC_JDK_ORACLE=$(update-alternatives --list javadoc | egrep 'jdk-[0-9]+-oracle')
JAVAH_JDK_ORACLE=$(update-alternatives --list javah | egrep 'jdk-[0-9]+-oracle')
JAVAP_JDK_ORACLE=$(update-alternatives --list javap | egrep 'jdk-[0-9]+-oracle')
JAVAWS_JDK_ORACLE=$(update-alternatives --list javaws | egrep 'jdk-[0-9]+-oracle')

JAVA_JRE_ORACLE=$(update-alternatives --list java | egrep 'jre-[0-9]+-oracle')
JAVAWS_JRE_ORACLE=$(update-alternatives --list javaws | egrep 'jre-[0-9]+-oracle')

if [ "$JAVA_JDK_ORACLE" != "" ]
	then
		update-alternatives --set java $JAVA_JDK_ORACLE
		update-alternatives --set javac $JAVAC_JDK_ORACLE
		update-alternatives --set javadoc $JAVADOC_JDK_ORACLE
		update-alternatives --set javah $JAVAH_JDK_ORACLE
		update-alternatives --set javap $JAVAP_JDK_ORACLE
		update-alternatives --set javaws $JAVAWS_JDK_ORACLE
elif [ "$JAVA_JRE_ORACLE" != "" ]
	then
		update-alternatives --set java $JAVA_JRE_ORACLE
		update-alternatives --set javaws $JAVAWS_JRE_ORACLE
fi

# настройка MySQL

DBROOT_PASS=$(grep -A1 'user=root' /home/$DEB_USER/.my.cnf | tail -n 1 | awk -F= '{print $2}')
echo "mysql-server-5.5 mysql-server/root_password select $DBROOT_PASS" | debconf-set-selections
echo "mysql-server-5.5 mysql-server/root_password_again select $DBROOT_PASS" | debconf-set-selections
# dpkg-reconfigure -f noninteractive mysql-server-5.5
mv mode.cnf /etc/mysql/conf.d/
dpkg-reconfigure mysql-server-5.5

# Установка прав на каталог веб-сервера

chgrp -R www-data /var/www
chmod g+w /var/www/

# Перемещение тестового PHP-скрипта в каталог веб-сервера

mv /home/$DEB_USER/info.php /var/www/
chmod 661 /var/www/info.php
chown root:www-data /var/www/info.php

step_write

this_is_done
