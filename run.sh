#!/bin/bash

sudo tshark -T fields -e ip.addr -e frame.time_epoch -e dns.qry.name -e http.host dst host 10.0.2.15 | tee >(./collectI2.py) >(./collect.py) 


