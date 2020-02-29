#!/bin/bash

export SCRIPTS_DIR=$(cd $(dirname ${BASH_SOURCE[0]});pwd)
[[ -z "${BASH_SOURCE[1]}" ]] && . $SCRIPTS_DIR/env.sh
. $SCRIPTS_DIR/utils.sh

NODE_DATA_DIR="${NODE_DIR}/data"
NODE_CONFIG_DIR="${NODE_DIR}/config"
NODE_CONFIG_FILE="${NODE_CONFIG_DIR}/config.ini"
NODE_LOG_DIR="${NODE_DIR}/log"

# node
run_node() {
	[[ -d "${NODE_DATA_DIR}" ]] || CMD_run_assert mkdir -p "${NODE_DATA_DIR}"
	[[ -d "${NODE_CONFIG_DIR}" ]] || CMD_run_assert mkdir -p "${NODE_CONFIG_DIR}"
	[[ -f "${NODE_CONFIG_FILE}" ]] || CMD_run_assert echo "${NODE_CONFIG}" > "${NODE_CONFIG_FILE}"
	[[ -d "${NODE_LOG_DIR}" ]] || CMD_run_assert mkdir -p "${NODE_LOG_DIR}"
	CMD_run_assert $NODEOS -d "${NODE_DATA_DIR}" -c "${NODE_CONFIG_FILE}" >> "${NODE_LOG_DIR}/nodeos.log" 2>&1 &
	sleep 2s
	$CLEOS get account eosio.token > /dev/null 2>&1 || init_node
}

init_node() {
	# eosio.token
	CMD_run_out_assert $CLEOS create account eosio eosio.token ${NODE_PRODUCER_PUB_KEY} -p eosio@active
	CMD_run_out_assert $CLEOS set contract eosio.token "${CONTRACTS_DIR}/eosio.token/src" eosio.token.wasm eosio.token.abi -p eosio.token@active
	CMD_run_out_assert $CLEOS push action eosio.token create "[\"eosio\", \"1000000000.0000 EOS\"]" -p eosio.token@active
}

stop_node() {
	# CMD_run_out_assert ps -ef | grep $NODEOS | grep -v grep | awk '{print $2}' | xargs kill
	local txt
	txt=`ps -ef | grep $NODEOS | grep -v grep | awk '{print $2}'` && [[ -n "${txt}" ]] && CMD_run_assert kill "${txt}"
}

clear_node() {
	CMD_run_assert rm -rf "${NODE_DIR}"
}

create_account() {
	# cleos create account [OPTIONS] creator name OwnerKey [ActiveKey]
	$CLEOS create account $1 $2 ${3:-$NODE_PRODUCER_PUB_KEY} ${4:-$NODE_PRODUCER_PUB_KEY} -p ${1}@active
	return $?
}

deploy_contract() {
	# cleos set contract [OPTIONS] account [contract-dir] [wasm-file] [abi-file]
	$CLEOS set contract $@ -p ${1}@active
	return $?
}

usage() {
	local help
	if [ -z "${BASH_SOURCE[1]}" ]; then
		help=$(cat << EOF
EOSIO script

USAGE:
    bash ${BASH_SOURCE[0]} [ACTIONS] [OPTIONS]

OPTIONS:
    -m, --mode <all|node|wallet>              Choose a default host triple
EOF
)
	else
		help=$(cat << EOF
EOSIO script

USAGE:
    bash ${BASH_SOURCE[0]} [ACTIONS] [OPTIONS]

SUBCOMMAND:
	run				Run node
	init			Init node, create account eosio.token, deploy eosio.token contract, push EOS token, ...
	stop			Stop node, stop nodeos service: ${NODE_DIR}
	clear			Clear node, remove folder: ${NODE_DIR}
	help			Usage info
EOF
)
	fi
}

if [ -z "${BASH_SOURCE[1]}" ]; then
	
fi

# run_node
# init_node
stop_node