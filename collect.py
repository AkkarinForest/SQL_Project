#!/usr/bin/python3.5
import pymysql
import sys
import pymysql.cursors

connection = pymysql.connect(host='127.0.0.1', port=3306, user='me', passwd='', db='tcp')
cur = connection.cursor()

for line in sys.stdin:

    linesplit=line.split()
    lineip=linesplit[0].split(',')
    ip=lineip[0]

    timee=linesplit[1].split('.')
    time=timee[0]

    with connection.cursor() as cursor:

        sql = "INSERT INTO collect (ip, first, last) VALUES (%s,%s,%s) ON DUPLICATE KEY UPDATE last=%s;"
        cursor.execute(sql, (ip, time, time, time))
        connection.commit()

connection.close()






















