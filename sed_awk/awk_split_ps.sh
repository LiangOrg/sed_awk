#来源于cu



大家好，我们在输入 ps -o pid, user, etime  的时候，会得到 诸如：

PID                 USER            ELAPSED
42                  asp               45:26
21                  asp               23               
323                asp               24:12
945                asp               45:34:55
2540              asp               4-03:18:02
.......

的结果。

ELAPSED 其格式为 [[dd-]hh:]mm:ss。

我现在 想 把 上面 第3列的输出 单位 改为 秒，输出如下，该如何实现呢
PID                 USER            ELAPSED
42                  asp               2726
21                  asp               23               
323                asp               1452
945                asp               164095
2540              asp               357482
.......
#ps -eo pid,user,etime




#cat 1.txt
PID                 USER            ELAPSED
42                  asp               45:26
21                  asp               23               
323                asp               24:12
945                asp               45:34:55
2540              asp               4-03:18:02



##
[root@ml_gm_server ~]# awk 'BEGIN{split("1:60:3600:86400",a,":")}NR>1{c=0;n=split($NF,b,":|-");for(i=n;i;i--)c+=b[i]*a[n-i+1];$3=c}1' 1.txt |column -t
PID   USER  ELAPSED
42    asp   2726
21    asp   23
323   asp   1452
945   asp   164095
2540  asp   357482

########
[root@ml_gm_server ~]#  awk 'NR>1{s=0;l=split($3,a,":|-");for(i=1;i<=l;i++){s=l==4&&i==1?24*a[i]*60^2:s+a[i]*60^(l-i);}$3=s}1' 1.txt |column -t
PID   USER  ELAPSED
42    asp   2726
21    asp   23
323   asp   1452
945   asp   164095
2540  asp   357482



##########




#awk '{b=split($3,a,":|-");if(NR==1){c=$3};if(b==1){c=$3};if(b==2){c=a[1]*60+a[2]};if(b==3){c=a[1]*3600+a[2]*60+a[3]};if(b==4){c=a[1]*24*3600+a[2]*3600+a[3]*60+a[4]}}1' 1.txt



###awk '{NR==1;print;next}NR>1{b=split($3,a,":");if(b==1){c=$3};if(b==2){c=a[1]*60+a[2]};if(b==3){c=a[1]*3600+a[2]*60+a[3]};if(b==4){c=a[1]*24*3600+a[2]*3600+a[3]*60+a[4]}print $1,$2,c}' 1.txt 



#awk '{b=split($3,a,":|-");if(NR==1){c=$3};if(b==1){c=$3};if(b==2){c=a[1]*60+a[2]};if(b==3){c=a[1]*3600+a[2]*60+a[3]};if(b==4){c=a[1]*24*3600+a[2]*3600+a[3]*60+a[4]}print $1,$2,c}' 1.txt 
PID USER ELAPSED
42 asp 2726
21 asp 23
323 asp 1452
945 asp 164095
2540 asp 357482
