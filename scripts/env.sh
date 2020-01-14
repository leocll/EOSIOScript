#!/bin/bash

# export SCRIPTS_DIR=$(cd $(dirname ${BASH_SOURCE[0]});pwd)
export ROOT_DIR=$(cd ${SCRIPTS_DIR}/..;pwd)
export CONTRACTS_DIR=${ROOT_DIR}/contracts

export WALLET_DIR=${ROOT_DIR}/wallet
export WALLET_ADDRESS="127.0.0.1:6666"
export WALLET_UNLOOK_TIME=300           # second
export NODE_DIR=${ROOT_DIR}/node
export NODE_ADDRESS="127.0.0.1:8888"

export NODE_CONFIG=$(cat << EOF
http-server-address = ${NODE_ADDRESS}
http-validate-host = false
mongodb-filter-on = *
enable-stale-production = true
max-transaction-time = 3000000
producer-name = eosio
plugin = eosio::producer_plugin
plugin = eosio::chain_api_plugin
plugin = eosio::http_plugin
#plugin = eosio::history_api_plugin
EOF
)

EOSIO_BIN_DIR=/Users/edz/Documents/eosio/2.0.0/opt/eosio/bin
export KEOSD=${EOSIO_BIN_DIR}/keosd #$(command -v keosd)
export NODEOS=${EOSIO_BIN_DIR}/nodeos #$(command -v nodeos)
export CLEOS=${EOSIO_BIN_DIR}/cleos #$(command -v keosd)
