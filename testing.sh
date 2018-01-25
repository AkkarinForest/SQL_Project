#!/bin/bash

mys="mysql -u me -B -s -e" 
ips="$(${mys} " use tcp; select ip from collect order by test asc limit 10;")"
#echo $ips


for i in ${ips[@]}; do
#        echo $i 
	avg="$(ping -c 4 $i | tail -1| awk '{print $4}' | cut -d '/' -f 2)"; 
#	echo $avg
	if [ $avg ]; then
		time="$(date +%s)"
#		echo $time
		${mys} "use tcp; update collect set resp=$avg, test=$time where ip='$i'; commit;"
	else
		
		${mys} "use tcp; delete from collect where ip='$i'; commit;"
	fi

done




