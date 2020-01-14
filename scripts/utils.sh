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
    LOG_red "command failed: $*" >&2
}
CMD_run_ast() {
	"$@"
	CMD_assert "command failed: $*"
}
CMD_assert() {
	[ $? != 0 ] && ERROR "${1:-'error: CMD_assert'}"
}

ERROR() {
    LOG_red "$1" >&2
    exit 1
}

ASSERT_z() {
	[ -z "$1" ] && ERROR "${2:-'error: ASSERT_z'}"
}

ASSERT_f() {
	[ -f "$1" ] || ERROR "${2:-'error: ASSERT_f'}"
}