#!/bin/bash

mys="mysql -u me -B -s -e" 
ips="$(${mys} " use tcp; select url from urls order by test asc limit 10;")"
# echo $ips "url list"

for i in ${ips[@]}; do

	digging="$(dig ${i} +noall +answer | grep [[:space:]]A[[:space:]] | awk '{print $5}')" 

	for j in ${digging[@]}; do

	time="$(date +%s)"	

#	echo "digging"	
	${mys} "use tcp; INSERT INTO collect (ip, first, last) VALUES (\"$j\", $time, $time) on duplicate key update ip=ip; commit;"
	
	${mys} "use tcp; INSERT INTO pairs (url, ip) VALUES (\"$i\", \"$j\") on duplicate key update url=url, ip=ip"	

	${mys} "use tcp; update urls set test=$time where url='$i'"	
	done
done



