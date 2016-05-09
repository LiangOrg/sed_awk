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
