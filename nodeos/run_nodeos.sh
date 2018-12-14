#!/bin/bash

. ./nodeos_dir.sh

data_dir="$nodeos_dir/data"
config_path="$nodeos_dir/config/config.ini"
rm $config_path
cp ./config.ini $config_path

nodeos -c $config_path -d $data_dir --contracts-console —filter-on='*' >> $nodeos_dir/log/nodeos.log 2>&1 &

# 上面根据配置加载貌似有问题
# cd $nodeos_dir/..
# nodeos -e -p eosio --plugin eosio::producer_plugin --plugin eosio::chain_api_plugin --access-control-allow-origin='*' --contracts-console --http-validate-host=false —filter-on='*' >> $nodeos_dir/log/nodeos.log 2>&1 &
# nodeos -e -p eosio --plugin eosio::producer_plugin --plugin eosio::chain_api_plugin --plugin eosio::http_plugin -d $data_dir --config-dir $config_dir --access-control-allow-origin='*' --contracts-console --http-validate-host=false —filter-on='*' >> $nodeos_dir/log/nodeos.log 2>&1 &
 