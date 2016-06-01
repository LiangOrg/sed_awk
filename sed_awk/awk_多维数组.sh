#awk处理两个文件，用数组处理的方式
#datetime:201605191617
#auth：R神，郁金胸,baby，
#edit:杀神
#QQ: linux /shell/awk/sed 联盟 219636001


需求：有两个文件1.txt,2.txt 输出结果要用2.txt的$1与1.txt的$1对比,2.txt的$3与1.txt的$3对比，如果都相同则输出2.txt行全部结果。
##################################################
源文件：
[root@localhost]# cat 1.txt 
1111 something1 something2 
2222 something3 something13
3333 something5 something6 
4444 something7 something11 
[root@localhost]# cat 2.txt 
4444 something10 something11 
2222 something12 something13 
9999 something14 something15
################################################
结果文件：
4444 something10 something11 
2222 something12 something13 
#################################################
代码：1  （baby)
awk 'ARGIND==1{a[$1]=$1;b[$3]=$3;next}{if($1==a[$1]&&$3==b[$3])print}' 1.txt  2.txt 

awk 'ARGIND==1{a[$1]=$1;b[$3]=$3;next}$1==a[$1]&&$3==b[$3]' 1.txt  2.txt

(注释：两个一维数组，通过 row == arry[item] 方式)


代码：2 （杀神)
awk 'ARGIND==1{a[$1]=$1;b[$3]=$3;next}{if($1 in a && $3 in b)print}' 1.txt  2.txt 

awk 'ARGIND==1{a[$1]=$1;b[$3]=$3;next}$1 in a && $3 in b' 1.txt  2.txt

(两个一维数组，通过 item in  arry 方式)



代码：3  （郁金胸)
awk 'ARGIND==1{a[$1$3]++;next}{if(a[$1$3]==1)print}' 1.txt  2.txt
 
awk 'ARGIND==1{a[$1$3]++;next}a[$1$3]==1' 1.txt  2.txt  （注释：不能把"++" 换成 "=$0" )
 
（多维数组)
 
(这条代码支持 "++" 不支持 "=$0")
#注意：	awk 'ARGIND==1{a[$1$3]=$0;next}a[$1$3]==1' 1.txt  2.txt （这种写法错误）
 
 
 
 
 
代码：4 （R神)
awk 'ARGIND==1{a[$1$3]++;next}{if(a[$1$3])print}' 1.txt  2.txt

awk 'ARGIND==1{a[$1$3]=$0;next}{if(a[$1$3])print}' 1.txt  2.txt

awk 'ARGIND==1{a[$1$3]++;next}a[$1$3]' 1.txt  2.txt

awk 'ARGIND==1{a[$1$3]=$0;next}a[$1$3]' 1.txt  2.txt

(多维数组)
(注解：这条代码支持 "++" 和 "=$0" )
###################################################