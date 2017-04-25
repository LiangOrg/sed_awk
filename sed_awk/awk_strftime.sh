#!/bin/bash
#awk内置函数：strftime

#awk 'BEGIN{split(strftime("%Y%m%d %H:%M:%S %s",systime()),a," ");for(i=0;i++<3;)printf a[i] OFS;print ""}'

#strftime函数是格式化输出文本，systime())获取系统时间，split将strftime()切成一个数组a,"%Y%m%d %H:%M:%S %s"是输出格式.a[i]是获取数组a中存放的值

#awk 'BEGIN{"date -d  \"2020-11-11 20:00:00\" +%s"|getline a;print a}' #将"2020-11-11 20:00:00" 格式化成时间戳.
1605096000
#awk 'BEGIN{split(strftime("%Y-%m-%d %H:%M:%S %s",1605096000),a," ");for(i=0;i++<3;)printf a[i] OFS;print ""}'2020-11-11 20:00:00 1605096000 

#用strftime函数将时间戳格式化输出.

#实战应用:打印当时系统时间前十分钟的日志.

#cat file
[9:6:27] Send wait cond timewait return 0:Enter(4):TIMEOUT(78)
[9:10:8] Send wait cond timewait return 0:Enter(4):TIMEOUT(78)
[9:15:8] Send wait cond timewait return 0:Enter(4):TIMEOUT(78)
[9:19:8] Send wait cond timewait return 0:Enter(4):TIMEOUT(78)
[9:20:10] Send wait cond timewait return 0:Enter(4):TIMEOUT(78)
[9:21:8] Send wait cond timewait return 0:Enter(4):TIMEOUT(78)
[9:21:11] Send wait cond timewait return 0:Enter(4):TIMEOUT(78)
[9:22:8] Send wait cond timewait return 0:Enter(4):TIMEOUT(78)
[9:23:8] Send wait cond timewait return 0:Enter(4):TIMEOUT(78)
[9:40:8] Send wait cond timewait return 0:Enter(4):TIMEOUT(78)
[12:40:8] Send wait cond timewait return 0:Enter(4):TIMEOUT(78)
[12:40:8] Send wait cond timewait return 0:Enter(4):TIMEOUT(78)
[12:40:8] Send wait cond timewait return 0:Enter(4):TIMEOUT(78)
[12:40:8] Send wait cond timewait return 0:Enter(4):TIMEOUT(78)
[12:40:8] Send wait cond timewait return 0:Enter(4):TIMEOUT(78)
[12:40:8] Send wait cond timewait return 0:Enter(4):TIMEOUT(78)
[13:20:8] Send wait cond timewait return 0:Enter(4):TIMEOUT(78)
[13:32:8] Send wait cond timewait return 0:Enter(4):TIMEOUT(78)
[13:33:8] Send wait cond timewait return 0:Enter(4):TIMEOUT(78)
#代码:
#awk -F'[:[]' 'BEGIN{split(strftime("%H %M", systime()-600),a," ");}$2==a[1]&&$3>=a[2]' file
