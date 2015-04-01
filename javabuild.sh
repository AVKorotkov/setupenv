#!/bin/bash

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

WGET_OPTS="-c --header='Cookie: oraclelicense=accept-securebackup-cookie' --no-check-certificate --no-cookies"

wget $(echo -n $WGET_OPTS) -O $DOWNLOAD_FILE $DOWNLOAD_URL

#wget -c --header="Cookie: oraclelicense=accept-securebackup-cookie" -O $DOWNLOAD_FILE $DOWNLOAD_URL

make-jpkg $DOWNLOAD_FILE
