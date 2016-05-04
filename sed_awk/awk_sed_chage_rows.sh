#需求，将file变成这个格式
原文：
#cat file 
[test]
a
b
c
d
[test2]
1
2
3
4

结果：
[test] a b c d
[test2] 1 2 3 4




[root@local_game_server2 ~]# sed ':1;N;s/\n/ /g;/ \[/s//\n[/g;b1' file
[test] a b c d
[test2] 1 2 3 4
[root@local_game_server2 ~]# sed -nr '/\[/{:1;x;//!{x;h;d;};s#\n# #gp};/\[/!H;$b1' file
[test] a b c d
[test2] 1 2 3 4
[root@local_game_server2 ~]# sed -nr '/\[/{:1;N;/\n\[/b2;s#\n# #;$!t1;:2;P;D}' file
[test] a b c d
[test2] 1 2 3 4
[root@local_game_server2 ~]# awk '/\[/{if(s)print s;s=$0;next}{s=s" "$0}END{print s}' file
[test] a b c d
[test2] 1 2 3 4
