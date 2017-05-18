#!/bin/bash
#需求:取出"="后边的数据.
源文件：
####################################
[root@braindeath2 tmp]# cat file
[root@braindeath2 tmp]# cat file
key1=50, key2=6,   key3=7,              key4=, key5=8,               key6=, key7=,   key8=1, key9=1, key10=165200, platformId=集团, recordId=0a023ecefc7c41fd9a56e43dbe26cf52, storageData={"a":"1","b":"1","c":"1"}, timestamp=1493803242365

xxoo

JJKK

#####################################
目标文件:
50 6 7 8 1 1 165200 集团 0a023ecefc7c41fd9a56e43dbe26cf52 {a:1,b:1,c:1} 1493803242365
#####################################
#代码:
[root@braindeath2 tmp]# grep -Po '=(?!,)\K.*?\S+(?<!,)' file
50
6
7
8
1
1
165200
集团
0a023ecefc7c41fd9a56e43dbe26cf52
{"a":"1","b":"1","c":"1"}
1493803242365
#grep -Po '=(?!,)\K.*?\S+(?<!,)' file|xargs
50 6 7 8 1 1 165200 集团 0a023ecefc7c41fd9a56e43dbe26cf52 {a:1,b:1,c:1} 1493803242365
