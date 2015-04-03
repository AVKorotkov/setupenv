#!/bin/bash

# Этот скрипт завершает настройку пользовательского
# окружения Его нужно выполнить последним.

. user.cfg.sh

description
check_no_root
check_debian
check_step "userconf.sh"

# в .bashrc поместить JAVA_HOME

echo 'export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")' >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc

#. ~/.bashrc

step_write

this_is_done

