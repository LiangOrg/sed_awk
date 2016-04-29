[root@~]# cat 2.txt
xxoo a
kkkkkkk ll
xxoo b
lllllllll
lllllllll
xxooo c
xxoo  d
lllllllllllllllll



只打印第一次匹配的匹配行（$2)


[root@ ~]# awk '/xxoo/&&!p{print $2;p=1}' 2.txt
a
[root@~]# awk '/xxoo/{print $2;exit}' 2.txt
a




反之，除了第一次匹配行不打印，剩余的匹配行全部打印（$2）

[root@ ~]# awk '/xxoo/&&p{print $2}/xxoo/!p{p=1}' 2.txt
b
c
d
[root@ ~]# awk '/xxoo/&&p{print $2}{p=1}' 2.txt
b
c
d
