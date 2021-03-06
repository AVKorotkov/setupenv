#!/bin/bash

# Этот скрипт скачивает, устанавливает и настраивает
# IDE Eclipse. Запускается из скрипта preuser.sh

if [[ "$(echo "$0" | sed 's/.*\///g')" != "preuser.sh" ]]
	then
		echo "Этот скрипт вызывается из preuser.sh. Завершаем..."
		exit 0
fi

ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]
	then
		ARCH_URL="http://download.eclipse.org/technology/epp/downloads/release/luna/SR2/eclipse-modeling-luna-SR2-linux-gtk-x86_64.tar.gz"
		DOWNLOAD_FILE="eclipse-modeling-luna-SR2-linux-gtk-x86_64.tar.gz"
	else
		ARCH_URL="http://download.eclipse.org/technology/epp/downloads/release/luna/SR2/eclipse-modeling-luna-SR2-linux-gtk.tar.gz"
		DOWNLOAD_FILE="eclipse-modeling-luna-SR2-linux-gtk.tar.gz"
fi

echo "Скачивание Eclipse..."

wget -c $ARCH_URL -O $DOWNLOAD_FILE

echo "Скачивание Eclipse завершено."

# распаковка в ~/src

tar zxvf $DOWNLOAD_FILE -C ~/src

# настройка

if ! [[ -d ".local/share/applications" ]]
	then
		mkdir .local/share/applications
fi

sed -i -n -e "s/~/\/home\/$USER/" -e "p" eclipse.desktop
mv eclipse.desktop ~/.local/share/applications/
ln -s ~/src/eclipse/eclipse ~/bin/eclipse
cp ~/src/eclipse/eclipse.ini ~/src/eclipse/eclipse.ini.original
sed -i '/--launcher.appendVmargs/i --launcher.GTK_version\n2' ~/src/eclipse/eclipse.ini

echo "Настройка Eclipse завершена."
