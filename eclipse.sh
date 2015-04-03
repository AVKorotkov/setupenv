#!/bin/bash

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

$ cat eclipse.ini 
-startup
plugins/org.eclipse.equinox.launcher_1.3.0.v20140415-2008.jar
--launcher.library
plugins/org.eclipse.equinox.launcher.gtk.linux.x86_64_1.1.200.v20140603-1326
-product
org.eclipse.epp.package.cpp.product
--launcher.defaultAction
openFile
-showsplash
org.eclipse.platform
--launcher.XXMaxPermSize
256m
--launcher.defaultAction
openFile
--launcher.GTK_version
2
--launcher.appendVmargs
-vmargs
-Dosgi.requiredJavaVersion=1.7
-XX:MaxPermSize=256m
-Xms40m
-Xmx1536m
