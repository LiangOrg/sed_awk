[root@liudehua test1]# cat 1.txt 
[test-admin-web]
1.1.1.1
2.2.2.2
333.333.4.5
2.3.4.5
[test-admin-db]
1.2.3.4
1.2.4.5
1.2.4.4
1.1.1.1
[test-xxxx-db]
333.333.333.333

1£©
[root@liudehua test1]# awk '/admin/{p=1;next};/^\[/&&!/admin/{p=0}p' 1.txt 
1.1.1.1
2.2.2.2
333.333.4.5
2.3.4.5
1.2.3.4
1.2.4.5
1.2.4.4
1.1.1.1
2£©
[root@liudehua test1]# awk -vRS='\\[[^]]+\\]\n' 'p~/admin/;{p=RT}'  1.txt
1.1.1.1
2.2.2.2
333.333.4.5
2.3.4.5

1.2.3.4
1.2.4.5
1.2.4.4
1.1.1.1
