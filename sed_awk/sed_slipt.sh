[root@local_game_server2 test]# cat file
A 2 3 5 0 1 2 3 4 5 6
B 2 3 6 0 1 2 3 4 5 6
C 2 3 6 0 1 2 3 4 5 6

sed -nr 's/(\S+)(\s+\S+)/\1\2\n\1/;T;P;D' file
sed -nr 's/(\S+)(\s+\S+)/\1\2\n\1/;ta;b;:a;P;D' file




[root@local_game_server2 test]# sed -nr 's/(\S+)(\s+\S+)/\1\2\n\1/;ta;b;:a;P;D' file
A 2
A 3
A 5
A 0
A 1
A 2
A 3
A 4
A 5
A 6
B 2
B 3
B 6
B 0
B 1
B 2
B 3
B 4
B 5
B 6
C 2
C 3
C 6
C 0
C 1
C 2
C 3
C 4
C 5
C 6
[root@local_game_server2 test]# sed -nr 's/(\S+)(\s+\S+)/\1\2\n\1/;T;P;D' file
A 2
A 3
A 5
A 0
A 1
A 2
A 3
A 4
A 5
A 6
B 2
B 3
B 6
B 0
B 1
B 2
B 3
B 4
B 5
B 6
C 2
C 3
C 6
C 0
C 1
C 2
C 3
C 4
C 5
C 6
