#!/bin/bash

mys="mysql -u me -B -s -e" 

urls="$(${mys} " use tcp; select u.url, min(c.resp) as mini from pairs as p join (SELECT url FROM urls) as u on p.url=u.url join collect as c on p.ip=c.ip group by u.url ORDER by mini limit 3")"

echo -e "\nIP adresses with the shortest response time are: "

p=0
for i in ${urls[@]}; do
	echo -ne $i "\t\t"
	p=$((p+1))
	if [[ $p%2 -eq 0 ]]; then
		echo " "
	fi
done

urlss="$(${mys} " use tcp; select u.url, min(c.resp) as mini from pairs as p join (SELECT url FROM urls) as u on p.url=u.url join collect as c on p.ip=c.ip group by u.url ORDER by mini desc limit 3")"

echo -e "\nIP adresses with the longest response time are: "

pp=0
for i in ${urlss[@]}; do
	echo -ne $i "\t\t"
	pp=$((pp+1))
	if [[ $pp%2 -eq 0 ]]; then
		echo " "
	fi
done


























