#!/bin/bash

export SCRIPTS_DIR=$(cd $(dirname ${BASH_SOURCE[0]});pwd)
export ROOT_DIR=$(cd ${SCRIPTS_DIR}/..;pwd)
export NODE_DIR=${ROOT_DIR}/node
export CONTRACTS_DIR=${ROOT_DIR}/contracts

export KEOSD_BIN=""
export NODEOS_BIN=""
export CLEOS_BIN=""

export cleos=""