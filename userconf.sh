#!/bin/bash

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Этот скрипт выполняет основные настройки пользовательского
# окружения. Его нужно выполнить от имени пользователя вторым.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

. user.cfg.sh

description
check_no_root
check_debian
check_step "sysconf.sh"
ask_for_continue

# Сборка Oracle JDK

. javabuild.sh

# Сборка Oracle JRE

#. jrebuild.sh

# в .bashrc поместить JAVA_HOME

echo 'export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")' >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc

# Настройка MySQL

chmod 600 .my.cnf

DBUSER_PASS="$(makepasswd --chars=8)"
DBROOT_PASS="$(makepasswd --chars=8)"

sed -i -n -e "s/password=c/password=$DBUSER_PASS/" -e "s/password=a/password=$DBROOT_PASS/" -e "p" .my.cnf
sed -i "/\[mysqldump\]/a result_file=\/home\/$USER\/dump.sql" .my.cnf

echo "GRANT ALL ON \`db%\`.* TO 'dbuser'@'localhost' IDENTIFIED BY '$DBUSER_PASS';" | mysql --user=root --password=""
echo "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$DBROOT_PASS');" | mysql --user=root --password=""

echo ""
echo "Пользовательские настройки MySQL:"
echo "Для клиента MySQL:"
echo "логин: dbuser"
echo "пароль: $DBUSER_PASS"
echo ""
echo "Для администрирования MySQL:"
echo "логин: root"
echo "пароль: $DBROOT_PASS"
echo ""

step_write

this_is_done
