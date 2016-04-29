echo 'abcd'|awk '{len=split($0,a,"");for(i=1;i<=len;i++)print i,a[i],len}'
1 a 4
2 b 4
3 c 4
4 d 4

#netstat -antlp|awk '/:22\>/{split($5,port,":+");a[port[2]]++}END{for(i in a);(a[i]!="*");print a[i],i,$(NF-1),$NF|"sort -nr"}'
1 63251 LISTEN 1033/rpcbind