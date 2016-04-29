#auth:shashen
#time:20160406154000
#awk打印模式解析：
#awk '{n=x}n-->y' file 或者 awk '{n=x}n--<y' file  


[root@localhost ~]# awk '/^www/{print NR,$0}' passwd
24 www:x:500:500::/home/www:/bin/bash

（匹配行在第24行）

1.
awk '{n=x}n-->y' file (n可以用任意字母代替；x和y可以是任意整数)  

1）当y为非负整数时：（即y是>=0的整数）

它只会打印文本匹配行到匹配行的后（x-y）-1的行

其中（x-y值必须是大于0，才会打印的，否则不打印）}



[root@localhost ~]# awk '/^www/{n=4}n-->2{print NR,$0}' passwd
24 www:x:500:500::/home/www:/bin/bash
25 tomcat:x:501:501::/home/tomcat:/bin/bash

（即打印匹配^www所在行和它的后1行）


2）当y为负整数时：（y是<0的整数）

它会先打印文本的前|y|(y的绝对值)行的值，然后再打印匹配行到匹配行的后（x-y）-1 行
其中（x-y值必须是大于0，才会打印的，否则不打印）

[root@localhost ~]#  awk '/^www/{n=4}n-->-10{print NR,$0}' passwd
1 root:x:0:0:root:/root:/bin/bash
2 bin:x:1:1:bin:/bin:/sbin/localhost
3 daemon:x:2:2:daemon:/sbin:/sbin/localhost
4 adm:x:3:4:adm:/var/adm:/sbin/localhost
5 lp:x:4:7:lp:/var/spool/lpd:/sbin/localhost
6 sync:x:5:0:sync:/sbin:/bin/sync
7 shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
8 halt:x:7:0:halt:/sbin:/sbin/halt
9 mail:x:8:12:mail:/var/spool/mail:/sbin/localhost
10 uucp:x:10:14:uucp:/var/spool/uucp:/sbin/localhost
24 www:x:500:500::/home/www:/bin/bash
25 tomcat:x:501:501::/home/tomcat:/bin/bash
26 nginx:x:502:502::/home/nginx:/bin/bash
27 redis:x:498:503::/home/redis:/bin/bash
28 mysql:x:497:504::/home/mysql:/bin/bash
29 zabbix:x:503:505::/home/zabbix:/sbin/localhost
30 apache:x:48:48:Apache:/var/www:/sbin/localhost


（打印文本的前10行和匹配行到他的后14行，但是文本最多就是30行，打印到文本末尾）

[root@localhost ~]#  awk '/^www/{n=-6}n-->-10{print NR,$0}' passwd
1 root:x:0:0:root:/root:/bin/bash
2 bin:x:1:1:bin:/bin:/sbin/localhost
3 daemon:x:2:2:daemon:/sbin:/sbin/localhost
4 adm:x:3:4:adm:/var/adm:/sbin/localhost
5 lp:x:4:7:lp:/var/spool/lpd:/sbin/localhost
6 sync:x:5:0:sync:/sbin:/bin/sync
7 shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
8 halt:x:7:0:halt:/sbin:/sbin/halt
9 mail:x:8:12:mail:/var/spool/mail:/sbin/localhost
10 uucp:x:10:14:uucp:/var/spool/uucp:/sbin/localhost
24 www:x:500:500::/home/www:/bin/bash
25 tomcat:x:501:501::/home/tomcat:/bin/bash
26 nginx:x:502:502::/home/nginx:/bin/bash
27 redis:x:498:503::/home/redis:/bin/bash

（打印文本的前10行和匹配行到他的后4行）

[root@localhost ~]# awk '/^halt/{p=-9}p-->-10{print NR,$0}' passwd
1 root:x:0:0:root:/root:/bin/bash
2 bin:x:1:1:bin:/bin:/sbin/localhost
3 daemon:x:2:2:daemon:/sbin:/sbin/localhost
4 adm:x:3:4:adm:/var/adm:/sbin/localhost
5 lp:x:4:7:lp:/var/spool/lpd:/sbin/localhost
6 sync:x:5:0:sync:/sbin:/bin/sync
7 shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
8 halt:x:7:0:halt:/sbin:/sbin/halt

（打印文本前10行和匹配行本身，但是匹配行在第8行，在10行内，故最多就能打印到8行）


[root@localhost ~]# awk '/^halt/{p=-8}p-->-10{print NR,$0}' passwd
1 root:x:0:0:root:/root:/bin/bash
2 bin:x:1:1:bin:/bin:/sbin/localhost
3 daemon:x:2:2:daemon:/sbin:/sbin/localhost
4 adm:x:3:4:adm:/var/adm:/sbin/localhost
5 lp:x:4:7:lp:/var/spool/lpd:/sbin/localhost
6 sync:x:5:0:sync:/sbin:/bin/sync
7 shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
8 halt:x:7:0:halt:/sbin:/sbin/halt
9 mail:x:8:12:mail:/var/spool/mail:/sbin/localhost

（打印文本的前10行和匹配行的后1行，但是匹配行在第8行，后1行在9行，所以只能打印到9行）





2.
awk '{n=x}n--<y' file (n可以用任意字母代替；x和y可以是任意整数)

1)当y为正整数（y>0）时：

(会剔除掉匹配行和他的后x-y行，剔除的行共x-y+1行)
其中（x-y值必须是大于等于0，才会生效，否则打印的是整个文本）


[root@localhost ~]#  awk '/^www/{n=6}n--<1{print NR,$0}' passwd
1 root:x:0:0:root:/root:/bin/bash
2 bin:x:1:1:bin:/bin:/sbin/localhost
3 daemon:x:2:2:daemon:/sbin:/sbin/localhost
4 adm:x:3:4:adm:/var/adm:/sbin/localhost
5 lp:x:4:7:lp:/var/spool/lpd:/sbin/localhost
6 sync:x:5:0:sync:/sbin:/bin/sync
7 shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
8 halt:x:7:0:halt:/sbin:/sbin/halt
9 mail:x:8:12:mail:/var/spool/mail:/sbin/localhost
10 uucp:x:10:14:uucp:/var/spool/uucp:/sbin/localhost
11 operator:x:11:0:operator:/root:/sbin/localhost
12 games:x:12:100:games:/usr/games:/sbin/localhost
13 gopher:x:13:30:gopher:/var/gopher:/sbin/localhost
14 ftp:x:14:50:FTP User:/var/ftp:/sbin/localhost
15 nobody:x:99:99:Nobody:/:/sbin/localhost
16 vcsa:x:69:69:virtual console memory owner:/dev:/sbin/localhost
17 saslauth:x:499:76:"Saslauthd user":/var/empty/saslauth:/sbin/localhost
18 postfix:x:89:89::/var/spool/postfix:/sbin/localhost
19 sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/localhost
20 ntp:x:38:38::/etc/ntp:/sbin/localhost
21 tcpdump:x:72:72::/:/sbin/localhost
22 dbus:x:81:81:System message bus:/:/sbin/localhost
23 avahi-autoipd:x:170:170:Avahi IPv4LL Stack:/var/lib/avahi-autoipd:/sbin/localhost
30 apache:x:48:48:Apache:/var/www:/sbin/localhost
（会剔除掉匹配行所在行24行，和他的后5行，所以最后就删除了24-29行的6行）


[root@localhost ~]#  awk '/^www/{n=1}n--<1{print NR,$0}' passwd
1 root:x:0:0:root:/root:/bin/bash
2 bin:x:1:1:bin:/bin:/sbin/localhost
3 daemon:x:2:2:daemon:/sbin:/sbin/localhost
4 adm:x:3:4:adm:/var/adm:/sbin/localhost
5 lp:x:4:7:lp:/var/spool/lpd:/sbin/localhost
6 sync:x:5:0:sync:/sbin:/bin/sync
7 shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
8 halt:x:7:0:halt:/sbin:/sbin/halt
9 mail:x:8:12:mail:/var/spool/mail:/sbin/localhost
10 uucp:x:10:14:uucp:/var/spool/uucp:/sbin/localhost
11 operator:x:11:0:operator:/root:/sbin/localhost
12 games:x:12:100:games:/usr/games:/sbin/localhost
13 gopher:x:13:30:gopher:/var/gopher:/sbin/localhost
14 ftp:x:14:50:FTP User:/var/ftp:/sbin/localhost
15 nobody:x:99:99:Nobody:/:/sbin/localhost
16 vcsa:x:69:69:virtual console memory owner:/dev:/sbin/localhost
17 saslauth:x:499:76:"Saslauthd user":/var/empty/saslauth:/sbin/localhost
18 postfix:x:89:89::/var/spool/postfix:/sbin/localhost
19 sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/localhost
20 ntp:x:38:38::/etc/ntp:/sbin/localhost
21 tcpdump:x:72:72::/:/sbin/localhost
22 dbus:x:81:81:System message bus:/:/sbin/localhost
23 avahi-autoipd:x:170:170:Avahi IPv4LL Stack:/var/lib/avahi-autoipd:/sbin/localhost
25 tomcat:x:501:501::/home/tomcat:/bin/bash
26 nginx:x:502:502::/home/nginx:/bin/bash
27 redis:x:498:503::/home/redis:/bin/bash
28 mysql:x:497:504::/home/mysql:/bin/bash
29 zabbix:x:503:505::/home/zabbix:/sbin/localhost
30 apache:x:48:48:Apache:/var/www:/sbin/localhost

（删除匹配行和后（1-1）行，即只删除了匹配行24行）


2)当y为非正整数（y<=0)并且（x-y>=0）时
剔除文本前（|y|+1）行和匹配行到匹配行的后（x-y）行


[root@localhost ~]#  awk '/^www/{n=0}n--<0{print NR,$0}' passwd
2 bin:x:1:1:bin:/bin:/sbin/localhost
3 daemon:x:2:2:daemon:/sbin:/sbin/localhost
4 adm:x:3:4:adm:/var/adm:/sbin/localhost
5 lp:x:4:7:lp:/var/spool/lpd:/sbin/localhost
6 sync:x:5:0:sync:/sbin:/bin/sync
7 shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
8 halt:x:7:0:halt:/sbin:/sbin/halt
9 mail:x:8:12:mail:/var/spool/mail:/sbin/localhost
10 uucp:x:10:14:uucp:/var/spool/uucp:/sbin/localhost
11 operator:x:11:0:operator:/root:/sbin/localhost
12 games:x:12:100:games:/usr/games:/sbin/localhost
13 gopher:x:13:30:gopher:/var/gopher:/sbin/localhost
14 ftp:x:14:50:FTP User:/var/ftp:/sbin/localhost
15 nobody:x:99:99:Nobody:/:/sbin/localhost
16 vcsa:x:69:69:virtual console memory owner:/dev:/sbin/localhost
17 saslauth:x:499:76:"Saslauthd user":/var/empty/saslauth:/sbin/localhost
18 postfix:x:89:89::/var/spool/postfix:/sbin/localhost
19 sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/localhost
20 ntp:x:38:38::/etc/ntp:/sbin/localhost
21 tcpdump:x:72:72::/:/sbin/localhost
22 dbus:x:81:81:System message bus:/:/sbin/localhost
23 avahi-autoipd:x:170:170:Avahi IPv4LL Stack:/var/lib/avahi-autoipd:/sbin/localhost
25 tomcat:x:501:501::/home/tomcat:/bin/bash
26 nginx:x:502:502::/home/nginx:/bin/bash
27 redis:x:498:503::/home/redis:/bin/bash
28 mysql:x:497:504::/home/mysql:/bin/bash
29 zabbix:x:503:505::/home/zabbix:/sbin/localhost
30 apache:x:48:48:Apache:/var/www:/sbin/localhost
(剔除了文本的前1行和匹配行24行)




[root@localhost ~]#  awk '/^www/{n=-5}n--<-7{print NR,$0}' passwd
9 mail:x:8:12:mail:/var/spool/mail:/sbin/localhost
10 uucp:x:10:14:uucp:/var/spool/uucp:/sbin/localhost
11 operator:x:11:0:operator:/root:/sbin/localhost
12 games:x:12:100:games:/usr/games:/sbin/localhost
13 gopher:x:13:30:gopher:/var/gopher:/sbin/localhost
14 ftp:x:14:50:FTP User:/var/ftp:/sbin/localhost
15 nobody:x:99:99:Nobody:/:/sbin/localhost
16 vcsa:x:69:69:virtual console memory owner:/dev:/sbin/localhost
17 saslauth:x:499:76:"Saslauthd user":/var/empty/saslauth:/sbin/localhost
18 postfix:x:89:89::/var/spool/postfix:/sbin/localhost
19 sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/localhost
20 ntp:x:38:38::/etc/ntp:/sbin/localhost
21 tcpdump:x:72:72::/:/sbin/localhost
22 dbus:x:81:81:System message bus:/:/sbin/localhost
23 avahi-autoipd:x:170:170:Avahi IPv4LL Stack:/var/lib/avahi-autoipd:/sbin/localhost
27 redis:x:498:503::/home/redis:/bin/bash
28 mysql:x:497:504::/home/mysql:/bin/bash
29 zabbix:x:503:505::/home/zabbix:/sbin/localhost
30 apache:x:48:48:Apache:/var/www:/sbin/localhost
（剔除了文本前8行和匹配行24到它的后2行，即24-26共三行被删掉了）



3)当y为非正整数（y<=0)并且（x-y<0）时
只剔除文本前（|y|+1）行

[root@localhost ~]#  awk '/^www/{n=-9}n--<-7{print NR,$0}' passwd
9 mail:x:8:12:mail:/var/spool/mail:/sbin/localhost
10 uucp:x:10:14:uucp:/var/spool/uucp:/sbin/localhost
11 operator:x:11:0:operator:/root:/sbin/localhost
12 games:x:12:100:games:/usr/games:/sbin/localhost
13 gopher:x:13:30:gopher:/var/gopher:/sbin/localhost
14 ftp:x:14:50:FTP User:/var/ftp:/sbin/localhost
15 nobody:x:99:99:Nobody:/:/sbin/localhost
16 vcsa:x:69:69:virtual console memory owner:/dev:/sbin/localhost
17 saslauth:x:499:76:"Saslauthd user":/var/empty/saslauth:/sbin/localhost
18 postfix:x:89:89::/var/spool/postfix:/sbin/localhost
19 sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/localhost
20 ntp:x:38:38::/etc/ntp:/sbin/localhost
21 tcpdump:x:72:72::/:/sbin/localhost
22 dbus:x:81:81:System message bus:/:/sbin/localhost
23 avahi-autoipd:x:170:170:Avahi IPv4LL Stack:/var/lib/avahi-autoipd:/sbin/localhost
24 www:x:500:500::/home/www:/bin/bash
25 tomcat:x:501:501::/home/tomcat:/bin/bash
26 nginx:x:502:502::/home/nginx:/bin/bash
27 redis:x:498:503::/home/redis:/bin/bash
28 mysql:x:497:504::/home/mysql:/bin/bash
29 zabbix:x:503:505::/home/zabbix:/sbin/localhost
30 apache:x:48:48:Apache:/var/www:/sbin/localhost
（只剔除文本前8行）




