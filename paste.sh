#!/bin/bash
set -x
read -p "从多少id开始：" id
read -p "关键词文件名称：" file_name
num=`cat $file_name | wc -l`
for ((i=`expr $id + 1`;i<=`expr $id + $num`;i++))
do
	echo "($i" >> id.txt
	echo "0,1,0,0,0,0,0,0)" >> last.txt
done
paste -d "," id.txt $file_name last.txt > a
awk -v ORS="," '{print $0}' a | sed -e "s|\(.*\),|REPLACE INTO \`t_keywords\` VALUES \1;|" > b
rm -rf id.txt last.txt a
