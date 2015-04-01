#!/bin/bash

# Этот скрипт завершает настройку системы. Его
# нужно суперпользователю выполнить последним.

. system.cfg.sh

description
check_root
check_debian
check_step "sysconf.sh"

# настройка Java

JAVA_JDK_ORACLE=$(update-alternatives --list java | egrep 'jdk-[0-9]+-oracle')
JAVAC_JDK_ORACLE=$(update-alternatives --list javac | egrep 'jdk-[0-9]+-oracle')
JAVADOC_JDK_ORACLE=$(update-alternatives --list javadoc | egrep 'jdk-[0-9]+-oracle')
JAVAH_JDK_ORACLE=$(update-alternatives --list javah | egrep 'jdk-[0-9]+-oracle')
JAVAP_JDK_ORACLE=$(update-alternatives --list javap | egrep 'jdk-[0-9]+-oracle')
JAVAWS_JDK_ORACLE=$(update-alternatives --list javaws | egrep 'jdk-[0-9]+-oracle')

JAVA_JRE_ORACLE=$(update-alternatives --list java | egrep 'jre-[0-9]+-oracle')
JAVAWS_JRE_ORACLE=$(update-alternatives --list javaws | egrep 'jre-[0-9]+-oracle')

if [ "$JAVA_JDK_ORACLE" != "" ]
	then
		update-alternatives --set java $JAVA_JDK_ORACLE
		update-alternatives --set javac $JAVAC_JDK_ORACLE
		update-alternatives --set javadoc $JAVADOC_JDK_ORACLE
		update-alternatives --set javah $JAVAH_JDK_ORACLE
		update-alternatives --set javap $JAVAP_JDK_ORACLE
		update-alternatives --set javaws $JAVAWS_JDK_ORACLE
elif [ "$JAVA_JRE_ORACLE" != "" ]
	then
		update-alternatives --set java $JAVA_JRE_ORACLE
		update-alternatives --set javaws $JAVAWS_JRE_ORACLE
fi



step_write

this_is_done
