#sed_awk_上下行拼接匹配关键字（http://bbs.chinaunix.net/thread-4250909-1-1.html）

需求：将源文件file1转换为目标文件file2
解析：1）凡是file1中本行有omega，直接输出；
        2）如果本行和，下一行或者下N行中，首尾能拼接成omega，则输出这些有效行。
        3)无效行不输出。（不符合前两条规则的视为无效行）
      （特别注意：循环，如果line2和line3匹配，line3和line4匹配，则输出line2line3，line3lin4,而不是输出line2line3line4.）
	  
	  
	  
[localhost]# cat file1
omega ,omega
cding .cd dzzz erg omeg
a bc dde ome
ga zerg ome
bbb cc dde omega zz
omega zzz ome
bb

cc ome
ga
dd
om
ega,cc

bb

dd
[localhost]#cat file2
omega ,omega
cding .cd dzzz erg omega bc dde ome
a bc dde ome
a bc dde omega zerg ome
bbb cc dde omega zz
omega zzz ome
cc omega
omega,cc




#####################################
代码：

1.
[localhost]# sed -nr '/omega/p;N;/o\nmega|om\nega|ome\nga|omeg\na/{h;s#\n##;p;x;};D' file1
omega ,omega
cding .cd dzzz erg omega bc dde ome
a bc dde omega zerg ome
bbb cc dde omega zz
omega zzz ome
cc omega
omega,cc

2.
[localhost]#  sed -r '/omega/{p;d};$!N;/o\s*\nmega|om\s*\nega|ome\s*\nga|omeg\s*\na/!D;h;s/\s*\n//;/omega/p;g;D' file1
omega ,omega
cding .cd dzzz erg omega bc dde ome
a bc dde omega zerg ome
bbb cc dde omega zz
omega zzz ome
cc omega
omega,cc


3.
[localhost]# awk '/omega/{print;next}last$0~/omega/{print last$0}{last=$0}' file1
omega ,omega
cding .cd dzzz erg omega bc dde ome
a bc dde omega zerg ome
bbb cc dde omega zz
omega zzz ome
cc omega
omega,cc



4.（将需求改为多line2lin3匹配,line3line4匹配，则输出line2line3,line3,line3line4)

[localhost]# awk '/omega/{print;append=0;next}last$0~/omega/{if(append==1)print last;print last$0;append=1}last$0!~/omega/{append=0}{last=$0}' file1
omega ,omega
cding .cd dzzz erg omega bc dde ome
a bc dde ome
a bc dde omega zerg ome
bbb cc dde omega zz
omega zzz ome
cc omega
omega,cc
