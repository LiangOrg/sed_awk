[root@liudehua test1]#export LANG='zh_CN.UTF-8';awk 'BEGIN{a="the UNIX operating system";match(a, /[A-Z]+/);print substr(a,RSTART,RLENGTH)}' 
the
[root@liudehua test1]# export LANG=C;awk 'BEGIN{a="the UNIX operating system";match(a, /[A-Z]+/);print substr(a,RSTART,RLENGTH)}' 
UNIX