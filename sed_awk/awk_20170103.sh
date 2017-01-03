#!/bin/bash
#需求:根据文件第一行某个列关键字段("c"),打印列.
#cat file
a  b     c    d       e
1  jj   30    xx      1
xx 2    40    oo      2
oo 2o   50    jj      3
1  2l   60    yy      4

#代码1:
#awk -vk=c 'NR==1{for(n=1;n<=NF;n++)if($n==k)next}{print $n}' file
30
40
50
60
#代码1优化:
awk -vk=c 'NR==1{for(n=1;n<=NF;++n)if($n==k)next;if(n>NF){print "DIDNOT match key("k") in first line: "$0;exit}}{print $n}' file

#代码2：
awk 'NR==1{for(i=1;i<=NF;i++){if($i=="c"){a[i]=1}};next}{for(i=1;i<=NF;i++){if(a[i]){printf $i FS}}print FS}' file 
30 
40 
50 
60 

