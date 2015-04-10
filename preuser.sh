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
fi

# создать ~/src, если отсутствует

if ! [[ -d "~/src" ]]
	then
		mkdir ~/src
fi

# загрузить setupenv, если отсутствует
# или обновить до последней версии

echo "Обновление репозитория..."

if [[ -d "setupenv" ]]
	then
		cd setupenv
		git pull
	else
		git clone https://github.com/AVKorotkov/setupenv
		cd setupenv
fi

echo "Обновление репозитория завершено."

for i in $(ls -A . | egrep '(sh|desktop|cnf)$')
	do cp -u $i ~
done

cd

. user.cfg.sh

description
check_no_root
check_debian
ask_for_continue

# Установка IDE Eclipse

. eclipse.sh

# Получение RStudio

. rstudio.sh

cp sysconf.sh /tmp

step_write

this_is_done
