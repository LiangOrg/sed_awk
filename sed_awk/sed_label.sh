[root@liudehua test1]# cat test
AA
BC
AA
CB
CC
AA

[root@liudehua test1]# sed '/^AA/s/$/ YES/;t;s/$/ NO/' test   £¨t£©
AA YES
BC NO
AA YES
CB NO
CC NO
AA YES
[root@liudehua test1]# sed '/^AA/ba;s/$/ NO/;b;:a;s/$/ YES/' test   £¨b£©
AA YES
BC NO
AA YES
CB NO
CC NO
AA YES
[root@liudehua test1]# sed '/AA/s#$# YES#;/AA/!s#$# NO#g' test    £¨·Ç±êÇ©º¯Êý£©
AA YES
BC NO
AA YES
CB NO
CC NO
AA YES