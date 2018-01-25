#!/bin/bash

mys="mysql -u me -B -s -e" 

ips="$(${mys} " use tcp; select ip from collect order by resp desc limit 3;")"

echo -e "\nIP adresses with the longest response time are: \n"${ips}

ips2="$(${mys} " use tcp; select ip from collect order by resp asc limit 3;")"

echo -e "\nIP adresses with the shortest response time are: \n"${ips2}




















