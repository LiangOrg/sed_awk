#awk 打印两个pattern之间的行（重复次数有要求）
http://bbs.chinaunix.net/thread-4251010-1-1.html
1)
需求：源文件将1.txt转换为目标文件2.txt
需求解析：打印1.txt第3次patter "xx"至"oo"之间的行（文件中有多个xx，oo，打印第3次出现xx,oo之间的行）
############################################
[root@localhost ~]# cat 1.txt
xx
1 2 3
a b c d
ef
eg
235
oo
xx
1111
2222
33
4
oo
45678
xx
aaa
bbbb
ccc
ddd
oo
abhdl
xx
12345678
jjool
oo
[root@localhost ~]#cat 2.txt
xx
aaa
bbbb
ccc
ddd
oo
#########################################
代码：

awk '/xx/{a++}a==3;/oo/&&a==3{exit}' 1.txt



awk '/xx/,/oo/{if(!f){f=!f;c++};if(/oo/)f=!f;if(c==3){print;if(/oo/)exit}}' 1.txt



perl -0777 -nle 'print $2 if(/(.*?(xx.*?)oo){3}/s)' 1.txt



#############################################################
2)（需求变为：打印第3次出现xx，到第2次出现oo，之间的行，全文中出现了4次xx，3次oo。）
##############################################################
#cat 1.txt.new
xx
1 2 3
a b c d
ef
eg
235
oo
xx
1111
2222
33
4
45678
xx
aaa
bbbb
ccc
ddd
oo
abhdl
xx
12345678
jjool
oo
#cat 2.txt.new
xx
aaa
bbbb
ccc
ddd
oo
#################################################################

代码：

awk '/oo/{b++;}/xx/{c++;if(c<3)next}c==3;b==2{exit}' 1.txt.new


awk '/xx/{a++}a==3;/oo/&&a==3{exit}' 1.txt.new


awk -vm=3 -vn=2 '/xx/{a++;i=NR}/oo/{b++;j=NR}{if(a==m)f=1;if(f&&i<=NR)c=c?c"\n"$0:$0;if(b==n&&i<=j){print c;exit}}' 1.txt.new


sed -r '/^xx$/{x;s/^/./;/.{3}/{x;:a;N;/\noo$/!ba;q};x};d' 1.txt.new





