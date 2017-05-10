#!/bin/bash
#需求：打印匹配行的前十行,含匹配行共11行.
[root@braindeath2 ~]# seq 100|sed -rz 's/.*\n((([^\n]*\n){10})90\n).*/\1/'  
80
81
82
83
84
85
86
87
88
89
90
[root@braindeath2 ~]# seq 100|sed -n '1h;1!H;12,${x;s/[^\n]\+\n//;x};/90/{g;p}'
80
81
82
83
84
85
86
87
88
89
90
[root@braindeath2 ~]# seq 100|sed -n '/\n/{x;bb};1h;1!H;12,${x;D};:b;/90/{g;p}'
80
81
82
83
84
85
86
87
88
89
90
