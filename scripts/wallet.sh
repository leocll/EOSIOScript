#!/bin/bash

export SCRIPTS_DIR=$(cd $(dirname ${BASH_SOURCE[0]});pwd)
[[ -z "${BASH_SOURCE[1]}" ]] && . $SCRIPTS_DIR/env.sh
. $SCRIPTS_DIR/utils.sh

# wallet
run_wallet() {
	[[ -d "${WALLET_DIR}" ]] || CMD_run_assert mkdir "${WALLET_DIR}"
	CMD_run_assert $KEOSD --wallet-dir=${WALLET_DIR} --unix-socket-path=${WALLET_DIR}/keosd.sock --http-server-address=${WALLET_ADDRESS} --unlock-timeout=${WALLET_UNLOOK_TIME} >> ${WALLET_DIR}/wallet.log 2>&1 &
	[[ -f "${WALLET_DIR}/${WALLET_NAME}.txt" ]] || init_wallet
}

init_wallet() {
	CMD_run_out_assert $CLEOS wallet create -n ${WALLET_NAME} -f ${WALLET_DIR}/${WALLET_NAME}.txt
	CMD_run_out_assert $CLEOS wallet import -n ${WALLET_NAME} --private-key ${NODE_PRODUCER_PRI_KEY}
}

unlock_wallet() {
	CMD_run_out_assert $CLEOS wallet create -n ${WALLET_NAME} -f ${WALLET_DIR}/${WALLET_NAME}.txt
}

run_wallet