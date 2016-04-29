[root@liudehua ~]# awk 'BEGIN{print PROCINFO["pid"]}'     （查看pid）
16332

[root@liudehua ~]# awk 'BEGIN { print ENVIRON["USER"] }'   （查看执行用户）
root
[root@liudehua ~]# cat nima
xxoo;121;8989
jbjb;456;789
[root@liudehua ~]# awk '/xxoo/{IGNORECASE=1;print}' nima   （大小写不敏感）
xxoo;121;8989