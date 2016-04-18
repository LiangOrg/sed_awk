[root@liudehua ~]# cat 1.txt
aaaaaaa
bbbbbbbbbb
xx00:8008:kkkkkkk
ccccccccc
dddddddddddd

1111111111
22222222222
xxkk:8007:llslsl
333333333
44444444444
#sed -n 'N;N;/8007/{N;N;d};p' 1.txt
aaaaaaa
bbbbbbbbbb
xx00:8008:kkkkkkk
ccccccccc
dddddddddddd

#sed -n '$!N;$!N;/8007/{N;N;N;d};p;' 1.txt
aaaaaaa
bbbbbbbbbb
xx00:8008:kkkkkkk
ccccccccc
dddddddddddd


#sed -nr '1h;1!H;$b1;/^$/{:1;x;/8008/d;p}'
aaaaaaa
bbbbbbbbbb
xx00:8008:kkkkkkk
ccccccccc
dddddddddddd
