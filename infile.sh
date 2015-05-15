#!/bin/bash

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Этот скрипт настраивает MySQL monitor
# для загрузки данных из локальных файлов
# и также делает некоторые другие настройки
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

. user.cfg.sh

description
check_no_root
check_debian
# ask_for_continue

PASS=$(tail -1 .my.cnf)

sed -i "/\[mysql\]/a local-infile" .my.cnf
sed -i "/\[mysqldump\]/a result_file=\/home\/$USER\/dump.sql\nuser=root\n$PASS" .my.cnf

echo "" >> .my.cnf
echo "[mysqlaccess]" >> .my.cnf
echo "user=root" >> .my.cnf
echo "$PASS" >> .my.cnf
echo "" >> .my.cnf
echo "[mysqlimport]" >> .my.cnf
echo "local" >> .my.cnf

this_is_done
# внесено исправление в ..my.cnf. Можно убрать.
