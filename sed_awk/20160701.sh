#20160701.sh
#取出两个关键字之间的数据

#源文件#cat file
11
a=1
b=2
c=3

12
a=2
b=3
c=4
d=5
e=6533
f=42423
g=1231213

13
a=4123
b=312
#需求
打印11到第一个c之间的行的c的值，即（3）
[root@localhost]# awk -F= '/\<11\>/,/\<c\>/{if(/\<c\>/)print $NF}' file
3
[root@localhost]# sed -nr '/\<11\>/,/\<c\>/{/c/!d;s/.*=//gp}' file
3
[root@localhost]# grep -Poz '^11(.*\n)+?c.*\K\d+$' file
3
