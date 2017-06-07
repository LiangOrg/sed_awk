#/bin/bash
#需求:将源文件file1变成file2
#######################
源文件file1
201701-name1
a
b
c
201702-name2
a
b
d
201701-name1
c
d
e
201702-name2
123
456
201703-name3
awk
sed
ls
#######################
目标文件
201701-name1
a
b
c
c
d
e
201702-name2
a
b
d
123
456
201703-name3
awk
sed
ls
######################
代码：

 awk '{for(i=2;i<=NF;i++)a[$1]=a[$1] ORS $i }END{for(i=0;i++<asorti(a,b);)print RS b[i],a[b[i]]}' RS="2017" file1
 
 awk '{(/-name[0-9]+/)?name=$0:(a[name])?a[name]=a[name]ORS$0:a[name]=$0}END{if(!(a[name])){a[name]=""};for(i=0;i++<asorti(a,b);)print b[i] ORS a[b[i]]}' file1