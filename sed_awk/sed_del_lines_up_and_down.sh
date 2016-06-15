
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
###################################################################
1.需求将file文件中匹配到"xxoo"的行和它的上下两行（共5行）都删除。
[root@local_game_server2 test]# cat file
a
b
bb
c
d
xxoo
e
f
g
kklll
[root@local_game_server2 test]# sed  'N;N;/xxoo/{N;N;d}' file
a
b
bb
g
kklll
####################################################################
2.需求，将file文件中匹配到"xxoo"的行和它的上下两行（共5行）的行首部加上"#"
[root@local_game_server2 test]# cat file
a
b
bb
c
d
xxoo
e
f
g
kklll
[root@local_game_server2 test]# sed 'N;N;/xxoo/{N;N;s/^/#/;s/\n/\n#/g}' file
a
b
bb
#c
#d
#xxoo
#e
#f
g
kklll




awk '{a[NR]=$0;/xxoo/?s=NR:""}END{for(i=0;i++<NR;)print (i>s-3&&i<s+3)?"#"a[i]:a[i]}' file

awk '{a[NR]=$0;if(/xxoo/)b=NR}END{for(i=0;i++<b-3;)print a[i];print "#"a[b-2],"#"a[b-1],"#"a[b],"#"a[b+1],"#"a[b+2];for(j=b+1;j++<NR;)print a[j]}' OFS="\n"


awk -vn=`grep -n xxoo file` 'NR>=n-2 && NR<=n+2{$0="#"$0}1'  file


awk 'FNR==NR{if(/xxoo/)n=NR;next}FNR>=n-2 && FNR<=n+2{$0="#"$0}1'  file file

