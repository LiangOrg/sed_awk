#!/bin/bash
#############################
#需求：awk 删掉某列
#删掉第3至第7列
#源文件:
1 2 3 4 5 6 7 8 9 10 11
a b c d e f g h i j k l
a b c d e f g h i j k l
a b c d e f g h i j k l
a b c d e f g h i j k l
a b c d e f g h i j k l
a b c d e f g h i j k l
#############################
#结果:
1 2 8 9 10 11
a b h i j k l
a b h i j k l
a b h i j k l
a b h i j k l
a b h i j k l
a b h i j k l
#############################
代码:
awk '{for(i=3;i++<7;)$(i-1)=$i="\b"}1' file
