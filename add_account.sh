#!/bin/bash

# 使用.号来引用console_log.sh 文件，或者 source ./console_log.sh
. ./commom/console_log.sh

set -e 	# 遇错终止，另一种 command || eixt

# $0 第一个参数为脚本本身
account=$1 		

if [[ ! -n $account ]]; then
	console_error_log "缺少账户名参数"
	console_warning_log "在执行脚本时，请在后面加上需添加的账户名，sh xx.sh account_name"
	exit 0
fi

key=`cleos create key --to-console`
private_key=${key:13:51}	# 字符串截取从第13位置往后取51位，即[13,63]
public_key=${key:77}		# 字符串截取从第77位置到最后

key=`cleos wallet import -n default --private-key $private_key`
key=${key:26}

if [[ $key != $public_key ]]; then
	console_error_log "导入私钥错误"
	exit 0
fi

cleos create account eosio $account $public_key

console_success_log "account: $account"
console_success_log "private key: $private_key"
console_success_log "public key: $public_key"

path=$(cd `dirname $0`; pwd)
path="$path/default钱包账户"
echo "\n\naccount: $account \nprivate key: $private_key \npublic key: $public_key" >> $path
console_success_log "账户信息已写入：$path"
