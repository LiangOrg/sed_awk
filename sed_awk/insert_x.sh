[root@local_game_server2 python_learn]# cat 1.txt 
xx 1
xx 1
xx 1
dafdfadf
xx 1
dafdfad
xx 1
sadfadfadfa


[root@local_game_server2 python_learn]# awk '{if($0~/^xx/) {t=NR} a[++i]=$0}END{for(s=1;s<=i;s++) {if(s==t) {print a[s]"\nxxoo"} else {print a[s]}}}' 1.txt
xx 1
xx 1
xx 1
dafdfadf
xx 1
dafdfad
xx 1
xxoo
sadfadfadfa



sed -nr '1h;1!H;${x;s/(.*xx[^\n]*)(.*)/\1\nxxoo\2/p}' 1.txt 
xx 1
xx 1
xx 1
dafdfadf
xx 1
dafdfad
xx 1
xxoo
sadfadfadfa
