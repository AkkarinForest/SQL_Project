#!/usr/bin/python3.5
import pymysql
import sys
import pymysql.cursors

connection = pymysql.connect(host='127.0.0.1', port=3306, user='me', passwd='', db='tcp')

cur = connection.cursor()


for line in sys.stdin:
    linesplit=line.split()

    if len(linesplit)>=3:
        url=linesplit[2]
        lineip = linesplit[0].split(',')

        ip = lineip[0]
        timee = linesplit[1].split('.')
        time = timee[0]

        with connection.cursor() as cursor:

            sql = "INSERT INTO urls(url) VALUES(%s) on duplicate key update url = url"
            cursor.execute(sql, (url))

            sql2 = "INSERT INTO collect (ip, first, last) VALUES (%s,%s,%s) ON DUPLICATE KEY UPDATE last=%s;"
            cursor.execute(sql2, (ip, time, time, time))

            sql3="INSERT INTO pairs(url, ip) VALUES(%s, %s) on duplicate key update url = url, ip = ip"
            cursor.execute(sql3, (url, ip))

            connection.commit()
