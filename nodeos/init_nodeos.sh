#!/bin/bash

. ../commom/console_log.sh
. ./nodeos_dir.sh

# 初始化nodeos
temp=`mkdir $nodeos_dir`
temp=`mkdir $nodeos_dir/log`

config_dir="$nodeos_dir/config"
data_dir="$nodeos_dir/data"

nodeos -e -p eosio --plugin eosio::producer_plugin --plugin eosio::chain_api_plugin --plugin eosio::http_plugin -d $data_dir --config-dir $config_dir --access-control-allow-origin='*' --contracts-console --http-validate-host=false —filter-on='*' >> $nodeos_dir/log/nodeos.log 2>&1 &
