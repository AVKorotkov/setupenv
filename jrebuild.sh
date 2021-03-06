#!/bin/bash

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Этот скрипт скачивает Oracle JRE и собирает deb-пакет.
# Запускается из скрипта userconf.sh
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

echo "Скачивание Oracle JRE..."

if [[ "$(basename $0)" != "userconf.sh" ]]
	then
		echo "Этот скрипт вызывается из userconf.sh. Завершаем..."
		exit 0
fi

JRE_LANG=$(locale | grep LANG= | awk -F= '{print $2}' | awk -F_ '{print $1}')

if	[ $JRE_LANG != "ru" ]
	then
		JRE_LANG="en"
fi

JRE_URL="http://java.com/$JRE_LANG/download/linux_manual.jsp?locale=$JRE_LANG"
JRE_PAGE="/tmp/Linux-JRE-$JRE_LANG.html"

wget $JRE_URL -O $JRE_PAGE

JRE_VERSION=$(egrep -o 'Version[ ]*[0-9]+' $JRE_PAGE | awk '{print $2}')
JRE_UPDATE=$(egrep -o 'Update[ ]*[0-9]+' $JRE_PAGE | awk '{print $2}')

#jre-8u40-linux-x64.tar.gz
#jre-8u40-linux-i586.tar.gz

ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]
	then
		DOWNLOAD_URL=$(grep "Linux x64 $JRE_LANG JRE" $JRE_PAGE | uniq | egrep -o 'http.+BundleId=[0-9]+')
		DOWNLOAD_FILE="jre-$(echo -n $JRE_VERSION)u$JRE_UPDATE-linux-x64.tar.gz"
	else
		DOWNLOAD_URL=$(grep "Linux $JRE_LANG JRE" $JRE_PAGE | uniq | egrep -o 'http.+BundleId=[0-9]+')
		DOWNLOAD_FILE="jre-$(echo -n $JRE_VERSION)u$JRE_UPDATE-linux-i586.tar.gz"
fi

wget --config=.wgetjavarc -O $DOWNLOAD_FILE $DOWNLOAD_URL

echo "Скачивание Oracle JRE завершено."
echo ""
echo "Создание deb-пакета Oracle JRE..."
echo ""

yes | make-jpkg $DOWNLOAD_FILE

echo ""
echo "Создание deb-пакета Oracle JRE завершено."
echo ""
