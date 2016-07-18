[root@local_game_server2 test]# seq 10
1
2
3
4
5
6
7
8
9
10
[root@local_game_server2 test]# seq 10|awk '{i++;print gensub(/[0-9]+/,"num"sprintf("%02d",i),"g")}'
num01
num02
num03
num04
num05
num06
num07
num08
num09
num10
[root@local_game_server2 test]# seq 10|awk '{gsub(/[0-9]+/,sprintf("num%02d",++c))}1'
num01
num02
num03
num04
num05
num06
num07
num08
num09
num10
[root@local_game_server2 test]# seq 10|awk '{c++;gsub(/[0-9]+/,sprintf("num%02d",c),$0)}1'
num01
num02
num03
num04
num05
num06
num07
num08
num09
num10
