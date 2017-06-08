#!/bin/bash
#1.awk打印匹配行的到最后一行 <==>  sed -n '/3/,$p'
[root@braindeath2 ~]# seq 10|awk '{if(A)print}/3/{print;A=666}'
3
4
5
6
7
8
9
10
#2.awk打印匹配行之后的所有行 <==>  sed -n '/3/,${/3/n;p}'
[root@braindeath2 ~]# seq 10|awk '{if(A)print}/3/{A=666}'
4
5
6
7
8
9
10
