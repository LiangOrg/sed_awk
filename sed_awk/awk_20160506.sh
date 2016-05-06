1.
#cat -A file1
PLMN ID-eNB ID 1 :  6402-113002 | PLMN ID-eNB ID 2 :  6402-113005 | PLMN ID-eNB ID 3 :  6402-113040 | PLMN ID-eNB ID 4 :  6402-113042 | PLMN ID-eNB ID 5 :  6402-113043 | PLMN ID-eNB ID 6 : 6402-113059 | PLMN ID-eNB ID 7 :  6402-113101 | PLMN ID-eNB ID 8 :  6402-113033$

(file1 只有一行，要下文这种结果)
结果：
6402-113002
6402-113005
6402-113040
6402-113042
6402-113043
6402-113059
6402-113101
6402-113033
[root@local_game_server2 test]# awk -F ':[ \t]+' '{sub("[\n\t ]","",$2);print $2}' RS='|' file1|cat -A
6402-113002$
6402-113005$
6402-113040$
6402-113042$
6402-113043$
6402-113059$
6402-113101$
6402-113033$


2.
#cat file
merge_access_2016-02-28.log --  merge_access_2016-02-27.log  
merge_access_2016-02-29.log --  merge_access_2016-02-28.log  
merge_access_2016-03-01.log --  merge_access_2016-02-29.log  
merge_access_2016-03-02.log --  merge_access_2016-03-01.log

(将第三列时间减一天)


注释：利用 awk '{"cmd"}' 方式直接修改


[root@local_game_server2 test]# awk -F '[_.]+' '{"date +%F \"-d -1 day\"" $3|getline $3}1' file
merge access 2016-02-27 log --  merge access 2016-02-27 log  
merge access 2016-02-28 log --  merge access 2016-02-28 log  
merge access 2016-02-29 log --  merge access 2016-02-29 log  
merge access 2016-03-01 log --  merge access 2016-03-01 log
