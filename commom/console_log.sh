#!/bin/bash

# 函数定义，可带function定义，也可省略，不带参数，参数已$n形式获取，和脚本参数一样，但是函数参数是从$1开始取
console_log() {
	echo $1							#黑字
}

console_error_log() {
	echo "\033[31m${1}\033[0m"		#红字
}

console_success_log() {
	echo "\033[32m${1}\033[0m"		#绿字
}

console_warning_log() {
	echo "\033[33m${1}\033[0m"		#黄字
}

# echo 背景色、文字色
# 形式："\033[41;36m<#内容#>\033[0m"
#其中41的位置代表底色， 36的位置是代表字的颜色 
#注： 
#1、字背景颜色和文字颜色之间是英文的";" 
#2、文字颜色后面有个m 
#3、字符串前后可以没有空格，如果有的话，输出也是同样有空格 
#参考https://www.cnblogs.com/lr-ting/archive/2013/02/28/2936792.html
