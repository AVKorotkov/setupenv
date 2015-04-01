#!/bin/bash

source ~/user.cfg.sh

check_no_root
check_debian

ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]
	then
		ARCH_URL="http://download.eclipse.org/technology/epp/downloads/release/luna/SR2/eclipse-modeling-luna-SR2-linux-gtk-x86_64.tar.gz"
		DOWNLOAD_FILE="eclipse-modeling-luna-SR2-linux-gtk-x86_64.tar.gz"
	else
		ARCH_URL="http://download.eclipse.org/technology/epp/downloads/release/luna/SR2/eclipse-modeling-luna-SR2-linux-gtk.tar.gz"
		DOWNLOAD_FILE="eclipse-modeling-luna-SR2-linux-gtk.tar.gz"
fi

wget -c $ARCH_URL -O $DOWNLOAD_FILE

# распаковка в ~/src

tar zxvf $DOWNLOAD_FILE -C ~/src

# настройка
mv eclipse.desktop ~/.local/share/applications/
ln -s ~/src/eclipse/eclipse ~/bin/eclipse
mv ~/src/eclipse/eclipse.ini ~/src/eclipse/eclipse.ini.original
mv eclipse.ini ~/src/eclipse/

this_is_done
