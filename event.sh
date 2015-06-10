#!/bin/bash

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Этот скрипт настраивает MySQL для 
# использования Event Scheduler.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DEB_USER=$(who -m | awk '{print $1}')
SETUPENV="/home/$DEB_USER/setupenv"

cp $SETUPENV/event.cnf .

chown root:root event.cnf

. system.cfg.sh

description
check_root
check_debian
ask_for_continue

# настройка MySQL на использование Event Scheduler

mv event.cnf /etc/mysql/conf.d/
service mysql stop
service mysql start
