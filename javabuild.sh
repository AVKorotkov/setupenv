#!/bin/bash

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Этот скрипт скачивает Oracle JDK и собирает deb-пакет.
# Запускается из скрипта userconf.sh
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

echo "Скачивание Oracle JDK..."

if [[ "$(basename $0)" != "userconf.sh" ]]
	then
		echo "Этот скрипт вызывается из userconf.sh. Завершаем..."
		exit 0
fi

BASE_URL="http://www.oracle.com"

INDEX="/tmp/JDK-index.html"

if [[ -f "$INDEX" ]]
	then
		rm $INDEX
fi

wget $BASE_URL/technetwork/java/javase/downloads/index.html -O $INDEX

JDK_URL=$(egrep -m1 -o '/technetwork/java/javase/downloads/jdk8-downloads-[0-9]+.html' $INDEX | uniq)
# /technetwork/java/javase/downloads/jdk8-downloads-2133151.html
JDK_HTML=$(echo $JDK_URL | cut -d / -f 6)
# jdk8-downloads-2133151.html
FULL_URL=$BASE_URL$JDK_URL
# http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
FULL_JDK_HTML="/tmp/$JDK_HTML"

if [[ -f "$FULL_JDK_HTML" ]]
	then
		rm $FULL_JDK_HTML
fi

wget $FULL_URL -O $FULL_JDK_HTML

#wget http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html

ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]
	then
		DOWNLOAD_URL=$(egrep -m1 -o 'http.+linux-x64.tar.gz' $FULL_JDK_HTML | uniq)
	else
		DOWNLOAD_URL=$(egrep -m1 -o 'http.+linux-i586.tar.gz' $FULL_JDK_HTML | uniq)
fi
# http://download.oracle.com/otn-pub/java/jdk/8u40-b26/jdk-8u40-linux-i586.tar.gz

DOWNLOAD_FILE=$(echo $DOWNLOAD_URL | cut -d / -f 8)
# jdk-8u40-linux-i586.tar.gz

wget --config=.wgetjavarc -O $DOWNLOAD_FILE $DOWNLOAD_URL
#wget -c --header="Cookie: oraclelicense=accept-securebackup-cookie" -O $DOWNLOAD_FILE $DOWNLOAD_URL

echo "Скачивание Oracle JDK завершено."
echo ""
echo "Создание deb-пакета Oracle JDK..."
echo ""

yes | make-jpkg $DOWNLOAD_FILE

echo ""
echo "Создание deb-пакета Oracle JDK завершено."
echo ""
