#需求，将第一行的内容与第四行的内容互相。

[root@localhost ~]# cat 1.txt
aa bb
cc dd
 cc ll
  ll kk
1 2
#lk
lllll
[root@localhost ~]# awk 'NR==FNR{if(NR==1)a=$0;if(NR==4){b=$0}next}FNR==1{$0=b}FNR==4{$0=a}1' 1.txt 1.txt
  ll kk
cc dd
 cc ll
aa bb
1 2
#lk
lllll
[root@localhost ~]# sed -r ':a;H;4bb;d;ba;:b;g;s/\n([^\n]+)\n(.+)\n([^\n]+)/\3\n\2\n\1/;:c;n;bc' 1.txt
  ll kk
cc dd
 cc ll
aa bb
1 2
#lk
lllll
[root@localhost ~]# sed -r ':a;H;4bb;d;ba;:b;g;s/\n([^\n]+)\n(.+)\n([^\n]+)/\3\n\2\n\1/;:c;n;bc' 1.txt|md5sum
90b61d3f4af9c3a066d262e29f89d1f0  -
[root@localhost ~]# awk 'NR==FNR{if(NR==1)a=$0;if(NR==4){b=$0}next}FNR==1{$0=b}FNR==4{$0=a}1' 1.txt 1.txt|md5sum
90b61d3f4af9c3a066d262e29f89d1f0  -


#seq 10|sed -nr '{N;N;N;s/^([^\n]+)(.*\n)([^\n]+$)/\3\2\1/gp};:c;n;p;bc'
4
2
3
1
5
6
7
8
9
10

#
seq 10|sed -r '1{h;d};:a;H;4bb;d;ba;:b;g;s/^([^\n]+)(.*\n)([^\n]+$)/\3\2\1/;:c;n;bc'
4
2
3
1
5
6
7
8
9
10


#将第5行内容和第15行内容互换

[root@localhost]# seq 20|sed -r '5{h;d};6,14{H;d};15{H;g;s#^([^\n]+)(.*\n)([^\n]+)$#\3\2\1#g}'
1
2
3
4
15
6
7
8
9
10
11
12
13
14
5
16
17
18
19
20

注释：核心思想是让保持空间的值储存为：
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
然后将第一行和最后一行互换位置（eg： s#^([^\n]+)(.*\n)([^\n]+)$#\3\2\1#g ）

只处理5,15行，其他行不管它就行，他会自己打印出来

awk 'BEGIN{while((getline<ARGV[1])>0){i++;(i==5)?a=$0:(i==15)?b=$0:""}}NR==5{$0=b}NR==15{$0=a}1' file
