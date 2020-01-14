#!/bin/bash

export SCRIPTS_DIR=$(cd $(dirname ${BASH_SOURCE[0]});pwd)
. $SCRIPTS_DIR/env.sh
. $SCRIPTS_DIR/utils.sh

# wallet
run_wallet() {
	[[ -d "${WALLET_DIR}" ]] || CMD_run_ast mkdir "${WALLET_DIR}"
	CMD_run_ast $KEOSD --wallet-dir=${WALLET_DIR} --unix-socket-path=${WALLET_DIR}/keosd.sock --http-server-address=${WALLET_ADDRESS} --unlock-timeout=${WALLET_UNLOOK_TIME} >> ${WALLET_DIR}/wallet.log 2>&1 &
}

# node
run_node() {
	local NODE_DATA_DIR="${NODE_DIR}/data"
	local NODE_CONFIG_DIR="${NODE_DIR}/config"
	local NODE_CONFIG_FILE="${NODE_CONFIG_DIR}/config.ini"
	local NODE_LOG_DIR="${NODE_DIR}/log"
	[[ -d "${NODE_DATA_DIR}" ]] || CMD_run_ast mkdir -p "${NODE_DATA_DIR}"
	[[ -d "${NODE_CONFIG_DIR}" ]] || CMD_run_ast mkdir -p "${NODE_CONFIG_DIR}"
	[[ -f "${NODE_CONFIG_FILE}" ]] || CMD_run_ast echo "${NODE_CONFIG}" > "${NODE_CONFIG_FILE}"
	[[ -d "${NODE_LOG_DIR}" ]] || CMD_run_ast mkdir -p "${NODE_LOG_DIR}"
	CMD_run_ast $NODEOS -d ${NODE_DATA_DIR} -c ${NODE_CONFIG_FILE} >> ${NODE_LOG_DIR}/nodeos.log 2>&1 &
}

run_wallet
run_node