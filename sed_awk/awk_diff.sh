#
file1
abc
cde


file2
abc
bce

#如何拉出file1中有，而file2中没有的行？

#root@liudehua test1]# comm -2 -3 file1 file2  (comm)
cde

#[root@liudehua test1]# diff  file1 file2|grep -Po '(?<=\< ).*'  (diff)
cde

#grep -vxFf file2 file1                          (grep)
cde


                                                   (awk)
#[root@liudehua test1]# awk 'NR==FNR{a[$1]=$1}NR>FNR{if(!($1 in a)){print $1}}' file1 file2     
bce
[root@liudehua test1]# awk '{if(FILENAME=="file1")a[$0]=1;else{if(a[$0]!=1)print $0}}' file1 file2
bce
[root@liudehua test1]# awk 'NR==FNR{a[$1]=$1}NR>FNR{if(!($1 in a)){print $1}}' file1 file2
bce
[root@liudehua test1]# awk 'ARGIND==1{a[$0]}ARGIND>1&&!($0 in a){print $0}' file1 file2
bce
[root@liudehua test1]# awk 'NR==FNR{a[$1]=1;next}!a[$1]++{print $1}' file1 file2
bce