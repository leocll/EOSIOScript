#!/bin/bash

# export SCRIPTS_DIR=$(cd $(dirname ${BASH_SOURCE[0]});pwd)
export ROOT_DIR=$(cd ${SCRIPTS_DIR}/..;pwd)
export CONTRACTS_DIR=${ROOT_DIR}/contracts

export WALLET_DIR=${ROOT_DIR}/wallet
export WALLET_ADDRESS="127.0.0.1:6666"
export WALLET_UNLOOK_TIME=30000           # second
export WALLET_NAME="default"
export NODE_DIR=${ROOT_DIR}/node
export NODE_ADDRESS="127.0.0.1:8888"
export NODE_PRODUCER_PRI_KEY="5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3"
export NODE_PRODUCER_PUB_KEY="EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV"

export NODE_CONFIG=$(cat << EOF
plugin = eosio::http_plugin
http-server-address = ${NODE_ADDRESS}
http-validate-host = false

plugin = eosio::producer_plugin
producer-name = eosio
#signature-provider = ${NODE_PRODUCER_PUB_KEY}=KEY:${NODE_PRODUCER_PRI_KEY}
enable-stale-production = true
max-transaction-time = 3000000

plugin = eosio::chain_api_plugin
#plugin = eosio::history_api_plugin
#filter-on = '*'
EOF
)

EOSIO_BIN_DIR=/Users/edz/Documents/eosio/2.0.0/opt/eosio/bin
export KEOSD=${EOSIO_BIN_DIR}/keosd #$(command -v keosd)
export NODEOS=${EOSIO_BIN_DIR}/nodeos #$(command -v nodeos)
CLEOS=${EOSIO_BIN_DIR}/cleos #$(command -v keosd)
export CLEOS="${EOSIO_BIN_DIR}/cleos -u http://${NODE_ADDRESS} --wallet-url http://${WALLET_ADDRESS}" 
