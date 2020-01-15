#!/bin/bash

LOG() {
	echo -e "$1"						# black
}
LOG_red() {
	echo -e "\033[31m${1}\033[0m"		# red
}
LOG_green() {
	echo -e "\033[32m${1}\033[0m"		# green
}
LOG_yellow() {
	echo -e "\033[33m${1}\033[0m"		# yellow
}

CMD_run() {
	"$@"
	local code=$?
    [[ $code != 0 ]] && LOG_red "Command: $*" >&2
	return $code
}
CMD_run_assert() {
	"$@"
	CMD_assert "Command: $*"
}
CMD_run_out_assert() {
	local txt
	txt=`$@ 2>&1`
	if [ $? != 0 ]; then
		LOG_red "${txt:-Error: Unknown error}" >&2
		LOG_yellow "Command: $*" >&2
		exit 1
	fi
}
CMD_assert() {
	[ $? != 0 ] && ERROR "${1:-'Error: CMD_assert'}"
}

ERROR() {
    LOG_red "$1" >&2
    exit 1
}

ASSERT_z() {
	[ -z "$1" ] && ERROR "${2:-'Error: ASSERT_z'}"
}

ASSERT_f() {
	[ -f "$1" ] || ERROR "${2:-'Error: ASSERT_f'}"
}