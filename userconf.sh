#!/bin/bash

# Этот скрипт выполняет основные настройки пользовательского
# окружения. Его нужно выполнить от имени пользователя вторым.

. user.cfg.sh

check_no_root
check_debian
description
ask_for_continue

. javabuild.sh

. jrebuild.sh

. eclipse.sh

step_write

this_is_done
