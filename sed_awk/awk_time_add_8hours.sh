#awk -vh=8 '{gsub(/[-:]/," ");m=mktime($0)+60^2*h;print strftime("%F %T",m)}'


[root@liudehua test1]# cat file1
2015-10-19 09:25:06 xxxxxxxxxxooooooo
2015-10-19 18:25:06 xxxxxxxxxxooooooo
[root@liudehua test1]# awk -vh=8 '{gsub(/[-:]/," ");m=mktime($0)+60^2*h;print strftime("%F %T",m)}' file1  （将时间在原有的基础上，加上8个小时）
2015-10-19 17:25:06
2015-10-20 02:25:06
#awk -F '[- :]' '{NF+=0;print strftime("%F %T",mktime($0)+3600*8);$3}' file1
2015-10-19 17:25:06
2015-10-20 02:25:06
