#!/bin/bash
#需求:(行转列)
将xx 文件转换为oo 文件,ab中如果一个没有出现，输出相应要输出空格的,不是直接跟上.
[root@braindeath2 tmp]# cat xx
a 1
b 2

b 3
a 4

a 5

b 6
a 7

b 8

a 9
b 10
[root@braindeath2 tmp]#cat oo
a  b
1  2
4  3
5
7  6
   8
9 10
[root@braindeath2 tmp]# awk 'BEGIN{printf "%-2s%2s\n","a","b";i=0}/a|b/{if($1=="a"){a[i]=$2;getline;if($1=="b"){b[i]=$2}else{b[i]="  "}}else{b[i]=$2;getline;if($1=="a"){a[i]=$2}}i++}END{for(x=0;x<i;x++){printf "%-2s%2s\n",a[x],b[x]}}' xx
a  b
1  2
4  3
5   
7  6
   8
9 10
