#!/bin/bash

# Этот скрипт делает предварительную настройку пользовательского
# окружения (создаёт необходимые каталоги, обновляет и копирует
# скрипты конфигурации в домашний каталог. Его нужно выполнить
# первым, до использования других скриптов.

# сделать домашний каталог недоступным для других пользователей

chmod 700 ~

# создать ~/bin, если отсутствует

if ! [[ -d "~/bin" ]]
	then
		mkdir ~/bin
		source ~/.profile
fi

# создать ~/src, если отсутствует

if ! [[ -d "~/src" ]]
	then
		mkdir ~/src
fi

# загрузить setupenv, если отсутствует
# или обновить до последней версии

if [[ -d "setupenv" ]]
	then
		cd setupenv
		git pull
		cd
	else
		git clone https://github.com/AVKorotkov/setupenv
fi

for i in $(ls -A setupenv | egrep '(sh|ini|desktop)$')
	do cp -u $i ~
done

chmod u+x *.sh
cp sysconf.sh /tmp

. user.cfg.sh

check_no_root
check_debian
description
ask_for_continue

. rstudio.sh

step_write

this_is_done
