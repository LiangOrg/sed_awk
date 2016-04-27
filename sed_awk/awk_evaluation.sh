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
