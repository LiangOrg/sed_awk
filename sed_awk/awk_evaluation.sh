#最大值，最小值，平均值


1.打印1.txt中每一行的最大值

#awk '{split($0,a);len=asort(a,b);print b[len]}'  1.txt

[root@local_game_server2 test]# cat 1.txt
1458219960     1371608893
1426597560     1371526093
1451610435    1451610435  1456794435  1464779235
[root@local_game_server2 test]# awk '{split($0,a);len=asort(a,b);print b[len]}' 1.txt
1458219960
1426597560
1464779235





2.打印最大值最小值

#echo 7 8 9 2 1 | awk '{max=$1;min=$1;for (i=1;i<=NF;i++) {if(max<$i) max=$i;if(min>$i) min=$i;sum+=$i};} END {print max,min,sum}'

#echo 7 8 9 2 1  | awk '{ sum=0; for(i=0;i++<NF;){a[i]=$i ; sum+=$i }; max=asort(a,b);print b[max],b[1],sum }'
9 1 27



#echo 7 8 9 2 1 | awk '{ for(i=0;i++<NF;)a[i]=$i ; max=asort(a,b);print b[max],b[1] }' 

# echo 7 8 9 2 1 |awk '{for(i=0;i++<NF;){if($i>max){max=$i}if(i==1){min=$i}if($i<min){min=$i}sum+=$i}print max,min,sum,NF,sum/NF}'
9 1 27 5 5.4


#echo 7 8 9 2 1|awk '{for(i=1;i<=NF;i++)if($i>max)max=$i;print max}'

#echo 7 8 9 2 1 |xargs -n1 |awk '$1>max{max=$1}  NR==1{min=$1} $1<min{min=$1} {sum+=$1} END {print max,min,sum,NR,sum/NR}'


[root@localhost lw]# cat 3.txt
1 2 3
5 6 7
6 9 0
0 2 43
3 7 3
[root@localhost lw]# awk 'NR==1{a=$1;b=$2;c=$3}$1<a{a=$1}$2<b{b=$2}$3<c{c=$3}END{print a,b,c}' 3.txt
0 2 0




####################################
案例

去掉一个最高分，和一个最低分，然后求各位的平均分。


[root@localhostshare]# cat 1.txt 
zs 58 98 56 23 22

ls 75 23 2

wmz 78 89 56 23

xxoo 0 2 56 45 56 65
[root@localhostshare]# awk 'NF{sum=0;max=$2;min=$2;for(i=2;i<=NF;i++){if(max<$i)max=$i;if(min>$i)min=$i;sum+=$i};print $1,(sum-max-min)/(i-4)}' 1.txt 
zs 45.6667
ls 23
wmz 67
xxoo 39.75
[root@localhostshare]# awk 'NF{min=$2;for(i=1;i++<NF;){if($i>max)max=$i;if($i<min)min=$i;sum+=$i}print $1,(sum-max-min)/(NF-3);max=min=sum=a}' 1.txt 
zs 45.6667
ls 23
wmz 67
xxoo 39.75


####################################
案例
取出max.test，两列中的每列的数的最大数和最小数。

#cat max.test 
-1005944.76 11296845.7
-1007695.86 11296849.07
-1009373.37 11298162.25
-1014534.29 11315985.23
-1013399.39 11319091.15
0.23          -100
[root@localhost test]# awk 'NR==1{max1=min1=$1;max2=min2=$2}$1>max1{max1=$1}$2>max2{max2=$2}$1<min1{min1=$1}$2<min2{min2=$2}END{print max1,min1,max2,min2}' max.test 
0.23 -1014534.29 11319091.15 -100

######
案例
取出ufile，每列中的的最大数，最小数，和，平均数，（各个列数不等）


cat ufile 
1  2  3  4  5  7
7  8  9
4  5  
-1 2  3  4  5  6  8 9
0  0 -1 -2 -33
4
[root@localhost test]# awk 'NF>n{n=NF}{for(i=0;i++<NF;){cont[i]++;if(min[i]=="")min[i]=$i;if(max[i]=="")max[i]=$i;if($i<min[i])min[i]=$i;if($i>max[i])max[i]=$i;sum[i]+=$i}}END{for(i=0;i++<n;)print min[i],max[i],sum[i],sum[i]/cont[i]}' ufile|column -t
-1   7  15   2.5
0    8  17   3.4
-1   9  14   3.5
-2   4  6    2
-33  5  -23  -7.66667
6    7  13   6.5
8    8  8    8
9    9  9    9

#求每一列的最小，最大，和，平均值
awk 'NF>n{n=NF}                    #获取文本中最大列数
{
     for(i=0;i++<NF;){             #从1-NF循环
         cont[i]++;                #列出现的总次数
         if(min[i]=="")min[i]=$i;  #初始最小值
         if(max[i]=="")max[i]=$i;  #初始最大值
         if($i<min[i])min[i]=$i;   #求最小值
         if($i>max[i])max[i]=$i;   #求最大值
         sum[i]+=$i                #求和
     }
}
END{
      for(i=0;i++<n;)              #从1-n (文本中最大列数) 循环取值
      print min[i],                #打印最小值
            max[i],                #打印最大值
            sum[i],                #打印和
            sum[i]/cont[i]         #打印平均值
}' urfile

##############################################
4.需求：将file变成file1
输出规则：
每单独一行的时间字段进行比较，如果时间大，则返回第一个字段加时间字段前一列的460开头的数据；（每行时间列数多少不固定）
[root@local_game_server2 test]# cat file
8613380308589|460110410761112|2016-03-17 21:06:00|460110418680672|2013-06-19 10:28:13
8613380343213|460110410353535|2015-03-17 21:06:00|460110446352525|2013-06-18 11:28:13
8617722833295|460110418713828|2016-01-01 09:07:15|460110418713826|2016-01-01 09:07:15|460110418713821|2016-03-01 09:07:15|4601104184242424|2016-06-01 19:07:15
##############################################
#cat file1
8613380308589|460110410761112|2016-03-17 21:06:00
8613380343213|460110410353535|2015-03-17 21:06:00
8617722833295|4601104184242424|2016-06-01 19:07:15



#代码：



awk --re-interval '{for(i=1;i<=NF;i++){if(match($i,"([0-9]{4}(-[0-9]{2}){2} ([0-9]{2}:){2}[0-9]{2})",a)){a[1]=gensub(":|-"," ","g",a[1]);m=mktime(a[1])};if(m>max){max=m;str=$(i-1)}};print $1,str,strftime("%F %T",max);max=""}' FS="|" OFS="|"  file

awk  '{max=0;for(i=3;i<=NF;i+=2){$i=gensub(":|-"," ","g",$i);m=mktime($i);if(m>max){max=m;str=$(i-1)}};print $1,str,strftime("%F %T",max)}' FS="|" OFS="|"  file








