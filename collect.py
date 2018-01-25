#!/usr/bin/python3.5
import pymysql
import sys
import pymysql.cursors

connection = pymysql.connect(host='127.0.0.1', port=3306, user='me', passwd='', db='tcp')

print("started")
cur = connection.cursor()

print("started")
for line in sys.stdin:
    if line:
        print(line.split())
    linesplit=line.split()
    lineip=linesplit[0].split(',')
    print(line)
    ip=lineip[0]
    timee=linesplit[1].split('.')
    time=timee[0]
    print(ip, time)

    with connection.cursor() as cursor:

        sql = "INSERT INTO collect (ip, first, last) VALUES (%s,%s,%s) ON DUPLICATE KEY UPDATE last=%s;"
        print("inserting")
        cursor.execute(sql, (ip, time, time, time))
        connection.commit()

connection.close()






















