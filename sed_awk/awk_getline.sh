[root@local_game_server2 ~]# cat file1
111
222
333
[root@local_game_server2 ~]# cat file2
aa
bb
cc
[root@local_game_server2 ~]# echo -e 'file1 file2\nfile1 file2\nfile1 file2'
file1 file2
file1 file2
file1 file2
[root@local_game_server2 ~]# echo -e 'file1 file2\nfile1 file2\nfile1 file2'|awk '{for(i=1;i<=NF;i++)"cat " $i|getline $i}1'
111 aa
222 bb
333 cc


