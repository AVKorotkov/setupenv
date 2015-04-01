#!/bin/bash

# Этот скрипт выполняет основные настройки пользовательского
# окружения. Его нужно выполнить от имени пользователя вторым.

. user.cfg.sh

check_no_root
check_debian
description
ask_for_continue

# в .bashrc поместить JAVA_HOME

echo 'export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")' >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc

. ~/.bashrc

. eclipse.sh

. javabuild.sh

. jrebuild.sh




step_write

this_is_done
