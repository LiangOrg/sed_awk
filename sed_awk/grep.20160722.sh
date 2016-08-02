#auth:linux /shell/awk/sed 联盟 219636001
#type:装逼每日一题：
#filename:grep前后匹配捕获关键内容
#date_time:20160722154300
#version:1.0.0.1
#edit:shashen
#github：https://github.com/shanghaixiaoxiao/sed_awk (实时更新)
##########################################################
#需求:将源文件test1.txt转换为目标文件test2.txt
需求解析：
摘取出":"和","（冒号与逗号）之间的内容，如（":001,"）,需取出来"001";
注意这个区间里边可能有空格或TAB等空白字符,比如(":002  ,")需取出来"002"。



########################################
[root@localhost]# cat test1.txt 
abc :001,123  456:002  ,898;koko: 	good,5678!:   great   ,  789sko/:    		  007 ,xxoo; :10086, xx : 10010 , 789:10000 , ;
[root@localhost]#cat test2.txt
001
002
good
great
007
10086
10010
10000
#########################################
代码：
[root@localhost]# grep -Po '\s*:\s*\K.*?\S+(?=\s*,)' test.txt 
001
002
good
great
007
10086
10010
10000
#########################################
代码分析:


需求提供了：是冒号和逗号之间的内容，则可以通过grep perl正则来用前后固定位置来截取内容。

grep -P  perl正则，支持\d+来表示[0-9]+（数字）,以及支持通过某个位置来前后查找,有的出处也成为"零宽断言"。

grep -o  （only的意识） 只取出匹配的字符而非全行

(?<=) :向后匹配 (?<=) 括号中必须固定长度，比如"\s{2}",或者两个空格，但是不能写成\s*或\s+ （必须固定长度，必需是零宽）
(?=)  :向前匹配  括号中可以不用固定长度，可以写成\s* 或\s+;\s*和\s+的区别就不多说了。

但是需求是逗号和冒号之间可能还有空白符号，所以(?<=)就鸡肋了,\K 装逼神器出场了。

\K与(?<=)的区别：
1)
(?<=)把要捕获的对象"xxoo"放在"?<="的后面,eg:"(?<=xxoo).*"
把要捕获的对象"xxoo"放在"\K"的前面,eg "xxoo\K.*"

2)
\K也是向后匹配,但是他不用固定位置,即（环视）,可以用\s*\K来表示向后匹配

eg:取出456
[root@local_game_server2 python_learn]# echo ":  456,"|grep -Po '(?<=:  ).*(?=,)'
456
[root@local_game_server2 python_learn]# echo ":  456,"|grep -Po '(?<=:\s{2}).*(?=,)'
456
[root@local_game_server2 python_learn]# echo ":  456,"|grep -Po ':\s*\K.*(?=,)'
456
####################################################
"\s"代表空白字符
"\S"代表非空白字符
"."代表任意字符
"*"代表前边字符重复0次或多次
"+"代表前边字符重复1次或多次
"?"代表前边字符重复0次或1次(懒惰匹配)
####################################################
#以上仅仅是我一个人的拙见,如有侵权与其他人无关,请联系群号:219636001(linux /shell/awk/sed)
;如有不正之处请多多包涵与指正;大神请无视我！

