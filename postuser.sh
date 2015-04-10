#!/bin/bash

# Этот скрипт завершает настройку пользовательского
# окружения Его нужно выполнить последним.

. user.cfg.sh

description
check_no_root
check_debian
check_step "userconf.sh"

#. ~/.bashrc

step_write

this_is_done
