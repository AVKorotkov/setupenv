#!/bin/bash

BASE_URL="http://www.rstudio.com/products/rstudio/download/"

SOURCE_URL="/tmp/rstudio-download.html"

wget -c $BASE_URL -O $SOURCE_URL

ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]
	then
		DOWNLOAD_URL=$(egrep 'http.+rstudio.+-amd64.deb["]' $SOURCE_URL | sed -n -e 's/"/,/gp' | awk -F, '{print $2}')
	else
		DOWNLOAD_URL=$(egrep 'http.+rstudio.+-i386.deb["]' $SOURCE_URL | sed -n -e 's/"/,/gp' | awk -F, '{print $2}')
fi

wget -c $DOWNLOAD_URL
