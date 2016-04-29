






例文：
zhangsan    80
lisi            81.5
wangwu      93
zhangsan    85
lisi        88
wangwu      97
zhangsan    90
lisi              92
wangwu      88

（求每人的平均值）




awk '{a[$1]+=$2;b[$1]++}END{for(i in a)print i,a[i]/b[i]}'