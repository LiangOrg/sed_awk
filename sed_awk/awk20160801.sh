#awk_20160801.sh

(打印第一行关键字"bb"所在列的所有列)
awk -vs="bb" 'BEGIN{l=split(s,a)}NR==1{for(i=1;i<=NF;i++)for(j=1;j<=l;j++)if($i==a[j]){a[j]=i;break}}{for(i=1;i<=l;i++)printf i==l?$a[i]"\n":$a[i]OFS}'  file


awk 'NR==1{for(i=0;i++<NF;)if($i=="bb")s=i}$0=$s' file





(删除匹配行的上一行和下一行,共2行)
#seq 10 |awk '/5/{a="";print;getline;next}{if(a)print a;a=$0}END{if(a)print a}'

#seq 10 |sed -n ':a;$!N;/\n5/{s/.*\n//p;N;d};P;D;ba;'
 
 
 
#awk '/xx/{a[NR-1]=0;a[NR]=$0;getline;next}{a[NR]=$0}END{for(i=1;i<=NR;i++)if(a[i])print a[i]}'
 
#seq 10 |sed -r ':a;$!N;/\n5/{s#.*\n(5.*)#\1#;N;s#(5.*)\n.*#\1#};P;D;ba'


 
(删掉匹配行的上一行和下一行，以及匹配行本身,共3行)
#seq 10 |sed -n ':a;$!N;/\n5/{N;d};P;D;ba;'
#seq 10 |awk '/5/{a[NR]=a[NR-1]=a[NR+1]=0;getline;next}{a[NR]=$0}END{for(i=1;i<=NR;i++)if(a[i])print a[i]}'