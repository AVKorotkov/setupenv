#!/bin/bash

function error_msg() {
	local MSG="${1}"
	echo "${MSG}"
	exit 1
}

function check_root() {
	if [ "$(id -u)" != "0" ];
		then
			error_msg "Этот скрипт должен выполняться только с правами root."
	fi
}

function check_debian() {
	DISTRIBUTOR=$(lsb_release -i | cut -f 2)
	CODENAME=$(lsb_release -c | cut -f 2)
	if [ "$DISTRIBUTOR" != "Debian" ]
		then
			error_msg "Это не Debian GNU/Linux."
	elif [ "$CODENAME" != "wheezy" ]
		then
			error_msg "Эта версия Debian GNU/Linux не поддерживается."
	fi
}

function this_is_done() {
cat <<ThisIsDone
==========
| ГОТОВО |
==========
ThisIsDone
}

function ask_for_continue() {
	stty -icanon
	echo -n "Нажмите клавишу Y для продолжения или любую другую для выхода "
	READCHAR=$(dd if=/dev/tty bs=1 count=1 2>/dev/null)
	case "$READCHAR" in
		y|Y)
			echo ""
			;;
		*)
			echo ""
			echo "Прервано."
			exit 0
			;;
	esac
	stty icanon
}

function step_write() {
	echo "# $(echo "$0" | sed 's/.*\///g')" >> system.cfg.sh
}

function description() {
	tail -n +3 $0 |
	while read line && [[ $line != "" ]]
		do echo $line | cut -d " " -f 2-
	done 
}

function check_step() {
	STEP_TO_CHECK=$1
	STEP=$(tail -n1 system.cfg.sh | awk '{print $2}')
	if [ $STEP_TO_CHECK != $STEP ]
		then
			echo "Вначале следует выполнить скрипт $STEP_TO_CHECK"
			exit 0
	fi
}
