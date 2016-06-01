需求，如果file文件中的IP出现在ip.txt，那么就在这个IP前加上"#" (file文件），否则就不处理。

源文件：
[root@localhost]# cat file
192.168.12.53
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

192.168.2.10

192.168.2.12
10.10.10.10

8.8.8.8
[root@localhost]# cat ip.txt 
192.168.0.1
192.168.0.11
192.168.1.2
192.168.12.234
192.168.12.53
192.168.2.10
192.168.2.12
127.0.0.1
结果文件：
[root@localhost]# cat file.txt 
#192.168.12.53
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

#192.168.2.10

#192.168.2.12
10.10.10.10

8.8.8.8





#####################################
1）
[root@localhost]# awk 'NR==FNR{a[$0]=$0;next}{print $0 in a?"#"$0:$0}'  ip.txt file|md5sum
eac86aedebe420e7d41a66e41fcb2520  -
2）
[root@localhost]# awk 'NR==FNR{a[$0]=$0;next}{print $0=a[$0]?"#"$0:$0}'  ip.txt file|md5sum
eac86aedebe420e7d41a66e41fcb2520  -
[root@localhost]# md5sum file.txt 
eac86aedebe420e7d41a66e41fcb2520  -
#####################################
