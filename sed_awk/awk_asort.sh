[root@liudehua test]# cat 1.txt
bb

xx

jj

aa

bb

cc

dd

dd

ee
jj
[root@liudehua test]# awk -vRS='' '{a[$0]++}END{xx=asorti(a);for(i=1;i<=xx;i++)print a[i]}' 1.txt
aa
bb
cc
dd
ee
jj
jj
xx

#awk  'NF{a[$0]++}END{xx=asorti(a,b);for(i=1;i<=xx;i++)print i,b[i],a[b[i]]}' 1.txt
1 aa 1
2 bb 2
3 cc 1
4 dd 2
5 ee 1
6 jj 2
7 xx 1
#
 awk 'NF{a[$0]=$0}END{len=asort(a);for(i=1;i<=len;i++)print i,a[i]}' 1.txt 
1 aa
2 bb
3 cc
4 dd
5 ee
6 jj
7 xx