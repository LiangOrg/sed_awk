#Ò»Î¬Êý×é

[root@local_game_server2 test]# cat 1.txt 
a 1 2 3
b 2 3 4
c 7 8 9
[root@local_game_server2 test]# cat 2.txt 
xx a
xxx b
oo c
ooo d
[root@local_game_server2 test]# awk 'ARGIND==1{a[$1]=$0;next}{print (a[$1]=a[$2])?a[$2]" "$1:$0}' 1.txt 2.txt
a 1 2 3 xx
b 2 3 4 xxx
c 7 8 9 oo
ooo d
[root@local_game_server2 test]# awk 'ARGIND==1{a[$1]=$0;next}{print ($2 in a)?a[$2]" "$1:$0}' 1.txt 2.txt
a 1 2 3 xx
b 2 3 4 xxx
c 7 8 9 oo
ooo d
[root@local_game_server2 test]# awk 'ARGIND==1{a[$1]=$0;next}{if($2 in a)print a[$2],$1;else print $0}' 1.txt 2.txt
a 1 2 3 xx
b 2 3 4 xxx
c 7 8 9 oo
ooo d
[root@local_game_server2 test]# awk 'ARGIND==1{a[$2]=$1;next}{print $0,a[$1];delete a[$1]}END{for(i in a)print a[i],i}' 2.txt 1.txt
a 1 2 3 xx
b 2 3 4 xxx
c 7 8 9 oo
ooo d
