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



[root@localhost test]# sed ':a;N;/[0-9a-z]$/s/\n/ /g;ta;P;D' file
[test] a b c d
[test2] 1 2 3 4
[root@localhost ~]# sed ':1;N;s/\n/ /g;/ \[/s//\n[/g;b1' file
[test] a b c d
[test2] 1 2 3 4
[root@localhost ~]# sed -nr '/\[/{:1;x;//!{x;h;d;};s#\n# #gp};/\[/!H;$b1' file
[test] a b c d
[test2] 1 2 3 4
[root@localhost ~]# sed -nr '/\[/{:1;N;/\n\[/b2;s#\n# #;$!t1;:2;P;D}' file
[test] a b c d
[test2] 1 2 3 4
[root@localhost ~]# awk '/\[/{if(s)print s;s=$0;next}{s=s" "$0}END{print s}' file
[test] a b c d
[test2] 1 2 3 4


[root@localhost test]# cat 1.txt
114.113.144.2:
19ms
19ms
19ms
36ms
22ms
19ms
18ms
218.61.204.73:
0ms
0ms
0ms
0ms
0ms
0ms
0ms
[root@localhost test]# sed ':a;N;/ms$/s/\n/ /g;ta;P;D' 1.txt
114.113.144.2: 19ms 19ms 19ms 36ms 22ms 19ms 18ms
218.61.204.73: 0ms 0ms 0ms 0ms 0ms 0ms 0ms



