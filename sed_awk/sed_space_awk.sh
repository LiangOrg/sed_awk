#sed空间模式

（一）
只打印匹配行的上一行

#cat empnametitle.txt 
KLSLAL
XXXXXXXXXXO
Doe
CEO
Jason Smith
IT Manager
Raj Reddy
Sysadmin
Anand Ram
Developer
Jane Miller
Sales Manager


需求：打印经理的名字

分析：即匹配关键字"Manager",打印他的上一行



1.
[root@localhost]# sed  -n '/Manager/!h;/Manager/{x;p}' empnametitle.txt 
Jason Smith
Jane Miller


2.
[root@localhost]# sed   '/Manager/!{h;d};x' empnametitle.txt 
Jason Smith
Jane Miller


3.
[root@localhost]# sed -n 'x;n;/Manager/{x;p}' empnametitle.txt 
Jason Smith
Jane Miller



注意：方法三有bug（当文件是奇数行是，无效），最好的方法是第一种，简介明了，易懂！





awk:方法也是简单明了



[root@localhost]# awk '/Manager/{print s}{s=$0}' empnametitle.txt 
Jason Smith
Jane Miller

解析：s=$0就是指的是上一行，直接打印s即可。






打印passwd中/^bin/ 的上一行

[root@localhost]# sed '3q' passwd
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin



1.
[root@localhost]# sed '/^bin/!{h;d};x' passwd
root:x:0:0:root:/root:/bin/bash

2.
[root@localhost]# sed -n '/^bin/!h;/^bin/{x;p}' passwd
root:x:0:0:root:/root:/bin/bash





（二）
打印匹配行和匹配行的上一行



需求：打印职务（经理）和姓名，并以冒号隔开。

#cat empnametitle.txt 
KLSLAL
XXXXXXXXXXO
Doe
CEO
Jason Smith
IT Manager
Raj Reddy
Sysadmin
Anand Ram
Developer
Jane Miller
Sales Manager


分析：即打印匹配到"Manager"和他的上一行。



1.
[root@localhost]# sed  -n '/Manager/!h;/Manager/{G;s/\n/\t:/gp}' empnametitle.txt 
IT Manager	:Jason Smith
Sales Manager	:Jane Miller


2.
[root@localhost]# sed   '/Manager/!{h;d};/Manager/{G;s/\n/\t:/g}' empnametitle.txt 
IT Manager	:Jason Smith
Sales Manager	:Jane Miller

3.
[root@localhost]# sed  -n '{x;n};/Manager/{G;s/\n/\t:/gp}' empnametitle.txt 
IT Manager	:Jason Smith
Sales Manager	:Jane Miller



注意：方法三有bug（当文件是奇数行是，无效），最好的方法是第一种，简介明了，易懂！



awk

[root@localhost]# awk '/Manager/{print $0 "\t:" s}{s=$0}' empnametitle.txt 
IT Manager	:Jason Smith
Sales Manager	:Jane Miller


解析：s=$0就是指的是上一行,打印$0,s即可。



（三）
打印匹配行的上一行和匹配行



打印关键字"3"的上一行和匹配行



[root@localhost]# seq 5|sed -n '/3/!{h};/3/{H;x;p}'
2
3
[root@localhost]# seq 5|sed '/3/!{h;d};/3/{H;x}'
2
3
[root@localhost]# seq 5|sed -n '/3/!{h};/3/{x;p;x;p}'
2
3


awk

[root@localhost]# seq 5|awk '/3/{print s RS $0}{s=$0}'
2
3



（四）
打印匹配行和匹配行的下一行
1.
#seq 5|sed  -n '/3/{N;p}'
3
4




2.
#seq 5|sed -n '/3/{p;n;p}'
3
4


awk

seq 5|awk 's~/3/{print s RS $0}{s=$0}'
3
4



(五)
打印匹配行的下一行和匹配行
1.
#[root@localhost]# seq 5|sed -n '/3/{h;n;p;x;p}'
4
3


2.
#[root@localhost]# seq 5|sed -n '/3/{h;n;G;p}'
4
3


awk

[root@localhost]# seq 5|awk 's~/3/{print $0 RS s}{s=$0}'
4
3






(六)
打印匹配行的上一行和匹配行的下一行



打印passwd中/^bin/ 的上一行和下一行


[root@localhost]# sed '3q' passwd
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin




1.
[root@localhost]# sed -n  '/^bin/!h;/^bin/{x;p;n;p}'  passwd
root:x:0:0:root:/root:/bin/bash
daemon:x:2:2:daemon:/sbin:/sbin/nologin

2.
[root@localhost]# sed   '/^bin/!{h;d};/^bin/{x;n}'  passwd
root:x:0:0:root:/root:/bin/bash
daemon:x:2:2:daemon:/sbin:/sbin/nologin


(七)

打印匹配行的下一行和上一行


[root@localhost]# seq 5|sed -n -e  '/3/!{h;d};/3/{x;h;n;p;x;p}' 
4
2
[root@localhost]# seq 5|sed -n -e  '/3/!h;/3/{x;h;n;p;x;p}' 
4
2
[root@localhost]# seq 5|sed -n -e  '/3/!h;/3/{n;p;x;p}' 
4
2
[root@localhost]# 
[root@localhost]# seq 5|sed -n -e  '/3/!h;/3/{n;p;g;p}' 
4
2

awk

[root@localhost]# seq 5|awk 'b~/3/{print $0 RS a}{a=b;b=$0}'
4
2





（八）

倒叙（tac）的效果
[root@localhost]# seq 10|tac
10
9
8
7
6
5
4
3
2
1
[root@localhost]# seq 10|sed '1!G;h;$!d'
10
9
8
7
6
5
4
3
2
1
[root@localhost]# seq 10|sed -n '1!G;h;$p'
10
9
8
7
6
5
4
3
2
1
[root@localhost]# seq 10|sed -n -e '1{h;d}' -e 'G;h;$p'
10
9
8
7
6
5
4
3
2
1
[root@localhost]# seq 10|sed -n '1{h;d};G;h;$p'
10
9
8
7
6
5
4
3
2
1
[root@localhost]# seq 10|sed '1{h;d};G;h;$!d'
10
9
8
7
6
5
4
3
2
1
（九）
去掉最后两行
[root@localhost]# seq 11|sed -n 'N;$!P;D'
1
2
3
4
5
6
7
8
9
[root@localhost]# seq 10|sed -n 'N;$!P;D'
1
2
3
4
5
6
7
8
[root@localhost]# seq 10|sed 'N;$!P;$!D;$d'
1
2
3
4
5
6
7
8
[root@localhost]# seq 11|sed 'N;$!P;$!D;$d'
1
2
3
4
5
6
7
8
9
[root@localhost]# seq 11|sed 'N;$!{P;D};$d'
1
2
3
4
5
6
7
8
9
（十）
只要最后两行
[root@localhost]# seq 10|sed '$!{h;d};H;x'
9
10
[root@localhost]# seq 11|sed '$!{h;d};H;x'
10
11
[root@localhost]# seq 10|sed 'N;$!D'
9
10
[root@localhost]# seq 11|sed 'N;$!D'
10
11
（十一）
不要最后10行
（head -n -10）
[root@localhost]# seq 30|head -n -10
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
[root@localhost]# seq 30|sed -n -e :a -e '1,10!{P;N;D;};N;ba' 
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
(十二)
打印最后10行
（tail -10）
[root@localhost]# seq 30|sed ':t;$q;N;11,$D;bt'
21
22
23
24
25
26
27
28
29
30
打印最后num行
（tail -num）
seq 30|sed ':t;$q;N;(num+1),$D;bt'















