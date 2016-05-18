[root@liudehua ~]# awk 'FNR==NR{a[NR]=$0;next}{print a[FNR]"\n"$0}' 1.txt 11.txt
1111111
aaaaaaaaaa
222222
bbbbbbbbbbbb
333333333
cccccccccccccc
444444444
dddddddddddddd

eeeeeeeeeeeeeeeee

[root@liudehua ~]#awk '{print;getline<"11.txt";print}' 1.txt
1111111
aaaaaaaaaa
222222
bbbbbbbbbbbb
333333333
cccccccccccccc
444444444
dddddddddddddd



[root@liudehua ~]# sed 'R 11.txt' 1.txt
1111111
aaaaaaaaaa
222222
bbbbbbbbbbbb
333333333
cccccccccccccc
444444444
dddddddddddddd