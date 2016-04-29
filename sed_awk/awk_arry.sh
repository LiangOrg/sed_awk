#awk
#file_name:awk_a[$1,$2]_array.sh
#Datetime:20160418150500
#version:1.0.0.1
#auth:shashen,R大,K神

#source：linux /shell/awk/sed 联盟 群  QQ:219636001




#awk ，如果文件1.txt中每一行的第一列和第二列相同，那么将其余的列一次叠加在该行后边（注：每一行的列不固定）


源文件：
[root@local_game_server2 test]# cat 1.txt 
20160411|600104|号码相同IMSI相同|2
20160411|600104|号码相同IMSI不同|1
20160411|600105|不同号码|64
20160411|600105|CRM独有号码|64
20160411|600104|不同号码|931
20160411|600104|号码相同|3
20160411|600104|CRM独有号码|433
20160411|600104|HSS独有号码|498
20160411|600104|号码相同IMSI相同号码状态相同|1
20160411|600104|号码相同IMSI相同号码状态不同|1


结果范文：
20160411|600104号码相同IMSI相同|2|号码相同IMSI不同|1|不同号码|931|号码相同|3|CRM独有号码|433|HSS独有号码|498|号码相同IMSI相同号码状态相同|1|号码相同IMSI相同号码状态不同|1
20160411|600105不同号码|64|CRM独有号码|64





#分析1：可以将第一列和第二列作为下标  ：即a[$1 分隔符 $2] $3 $4 ......

#分析2，列比较多，而且不固定，就想到要用for循环，将第三例开始一次循环即 for（i=3;i<=NF;i++）

#雏形
     SUBSEP="|"           a[$1,$2]=a[$1,$2] OFS $i 
（数组下标分隔符）

fun 1: 


数组分割符号：使用的"SUBSEP="XXoo" a[$1,$a]=a[$1,$2] 方式



[root@local_game_server2 test]# awk 'BEGIN{FS=OFS=SUBSEP="|"}{for(i=3;i<=NF;i++)a[$1,$2]=a[$1,$2] OFS $i}END{for(i in a)print i,a[i]}' 1.txt
20160411|600104||号码相同IMSI相同|2|号码相同IMSI不同|1|不同号码|931|号码相同|3|CRM独有号码|433|HSS独有号码|498|号码相同IMSI相同号码状态相同|1|号码相同IMSI相同号码状态不同|1
20160411|600105||不同号码|64|CRM独有号码|64



增强版：
[root@local_game_server2 test]# awk 'BEGIN{FS=OFS=SUBSEP="|"}{for(i=3;i<=NF;i++)a[$1,$2]=a[$1,$2] OFS $i}END{for(i in a)print i "" a[i]}' 1.txt
20160411|600104|号码相同IMSI相同|2|号码相同IMSI不同|1|不同号码|931|号码相同|3|CRM独有号码|433|HSS独有号码|498|号码相同IMSI相同号码状态相同|1|号码相同IMSI相同号码状态不同|1
20160411|600105|不同号码|64|CRM独有号码|64



注意：
END{print i "" a[i]}这一步，加上引号
OFS 和 列之间的 "|" 就不会重复，否则会多一个 "|"




fun 2:  （R大）
	  数组之间的分割符号：a[$1FS$2FS]=a[$1FS$2FS]
	  
	  
[root@local_game_server2 test]# awk -F '|'  '{for (i=3;i<=NF;i++)a[$1FS$2]=a[$1FS$2] FS $i}END{for (i in a)print i""a[i]}' 1.txt 
20160411|600104|号码相同IMSI相同|2|号码相同IMSI不同|1|不同号码|931|号码相同|3|CRM独有号码|433|HSS独有号码|498|号码相同IMSI相同号码状态相同|1|号码相同IMSI相同号码状态不同|1
20160411|600105|不同号码|64|CRM独有号码|64
	  
[root@local_game_server2 test]# awk -F '|'  '{for (i=3;i<=NF;i++)a[$1FS$2FS]=a[$1FS$2FS]?a[$1FS$2FS]FS$i:$i}END{for (i in a)print i""a[i]}' 1.txt 
20160411|600104|号码相同IMSI相同|2|号码相同IMSI不同|1|不同号码|931|号码相同|3|CRM独有号码|433|HSS独有号码|498|号码相同IMSI相同号码状态相同|1|号码相同IMSI相同号码状态不同|1
20160411|600105|不同号码|64|CRM独有号码|64




fun 3: （K神）


三目

[root@local_game_server2 test]# awk 'BEGIN{FS=OFS=SUBSEP="|"}{for(i=3;i<=NF;i++)a[$1,$2]=a[$1,$2]?a[$1,$2]=a[$1,$2] OFS $i:$i}END{for(i in a)print i "" a[i]}' 1.txt
20160411|600104号码相同IMSI相同|2|号码相同IMSI不同|1|不同号码|931|号码相同|3|CRM独有号码|433|HSS独有号码|498|号码相同IMSI相同号码状态相同|1|号码相同IMSI相同号码状态不同|1
20160411|600105不同号码|64|CRM独有号码|64






