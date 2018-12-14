#!/bin/bash

# 使用.号来引用console_log.sh 文件，或者 source ./console_log.sh
. ./console_log.sh

set -e 	# 遇错终止，另一种 command || eixt

path=$(cd `dirname $0`; pwd)

add_account() {
	add_account_sh="$path/add_account.sh"
	console_warning_log "add_account.sh路径：$add_account_sh"
	sh $add_account_sh $1
}
# if [[ cleos ]]; then
	#statements
# fi
# # 创建eosio.token账户
# add_account leocll5
# # 部署合约
# cleos set contract eosio.token /Users/color/EOSIO_contracts/eos/contracts/eosio.token
# # 创建代币
# cleos push action eosio.token create '[ "eosio", "1000000000.0000 EOS", 0, 0, 0]' -p eosio.token
# # 
# cleos push action eosio.token issue '[ "<#账户名#>", "1000.0000 EOS", "" ]' -p eosio