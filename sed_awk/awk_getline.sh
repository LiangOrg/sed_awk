[root@localhost ~]# awk 'BEGIN{"date"|getline a;print a}' 
2016年 05月 09日 星期一 11:28:53 CST



[root@localhost ~]# cat file1
111
222
333
[root@localhost ~]# cat file2
aa
bb
cc
[root@localhost ~]# echo -e 'file1 file2\nfile1 file2\nfile1 file2'
file1 file2
file1 file2
file1 file2
[root@localhost ~]# echo -e 'file1 file2\nfile1 file2\nfile1 file2'|awk '{for(i=1;i<=NF;i++)"cat " $i|getline $i}1'
111 aa
222 bb
333 cc


[root@localhost ~]# seq 10|awk '{print ;getline a}'
1
3
5
7
9
[root@localhost ~]# seq 10|awk '{print;getline a}'
1
3
5
7
9
[root@localhost ~]# seq 10|awk '{getline;print}'
2
4
6
8
10
[root@localhost ~]# seq 10|awk '{getline a;print}'
1
3
5
7
9
[root@localhost ~]# seq 10|awk '{getline a;print a}'
2
4
6
8
10



[root@localhost ~]# cat file
nnd
nnd
nnd
nnd
[root@localhost ~]# cat file1
111
222
333
[root@localhost ~]# awk '{print;getline <"file";print}' file1
111
nnd
222
nnd
333
nnd







