cat file1
111
222
333
[root@localhost ~]# cat file2
aa
bb
cc
[root@localhost ~]# awk '{print;if(/2/)nextfile}' file1 file2
111
222
aa
bb
cc


注释：匹配到'2',就开始读入下一个文件，所以file1不会打印333，打印到222就直接跳到下一个文件了。