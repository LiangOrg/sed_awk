#将文件2.txt行列互换
[root@liudehua ~]# cat 2.txt
1 2 3 4 5 6
a b c d e f g h
5 5 5 5 5 5 5 5 5 5  5  5
22 22 22 



# for i in `seq $(awk '{print NF|"sort -nr|head -1"}' 2.txt)`;do awk "{print \$$i}" 2.txt;done|sed 's#^$#xxoo#g'|xargs -n`sed -n '$=' 2.txt`|sed  's#xxoo# #g'

#awk 'NF>max{max=NF}{for (i=1;i<=max;i++)a[i]=a[i]$i"\t"}END{for (i=1;i<=max;i++)print a[i]}' 2.txt


#awk '{max=max<NF?NF:max;for(i=1;i<=NF;i++)a[NR,i]=$i}END{for(i=1;i<=max;i++){for(j=1;j<=NR;j++)printf a[j,i]" ";print ""}}' 2.txt


#awk -vORS=' ' '{max=max>NF?max:NF;for(i=1;i<=max;i++)a[NR,i]=$i}END{ for (i=1;i<=max;i++){for(j=1;j<=NR;j++){printf "%d\t",a[j,i]==""?" ":a[j,i]}printf "\n"}}' 2.txt


