[root@local_game_server2 test]# cat test 
create table hr_attence_plan (
id bigint(20) ,
dep_id bigint(20) ,
rule_id bigint(20) ,
work_week varchar(100) ,
work_holiday varchar(100) ,
created_time datetime ,
longitude varchar(16) ,
latitude varchar(16) ,
place varchar(100) ,
distance bigint(20) ,
company_id bigint(20) ,
);
xxxxxxxxxxxxxxxxxxxxxxxxxxx
 create table oa_faq_info (
id bigint(20) ,
categoryid bigint(20) ,
sort tinyint(4) ,
title varchar(256) ,
question varchar(1000) ,
answer text ,
ishot tinyint(4) ,
tag varchar(100) ,
read_numbers int ,
help_numbers int ,
unhelp_numbers int ,
created_time datetime ,
updated_time datetime ,
remark varchar(255) ,
);
xxxxxxxxxxxxxxxxxxxxxxxxxxx
oooooooooooooooooooooooooooooooo
[root@local_game_server2 test]# awk -vRS=');' '{print s,$0?gensub("(.*),.*","\\1","g"):""}{s=RT}' test
 create table hr_attence_plan (
id bigint(20) ,
dep_id bigint(20) ,
rule_id bigint(20) ,
work_week varchar(100) ,
work_holiday varchar(100) ,
created_time datetime ,
longitude varchar(16) ,
latitude varchar(16) ,
place varchar(100) ,
distance bigint(20) ,
company_id bigint(20) 
); 
xxxxxxxxxxxxxxxxxxxxxxxxxxx
 create table oa_faq_info (
id bigint(20) ,
categoryid bigint(20) ,
sort tinyint(4) ,
title varchar(256) ,
question varchar(1000) ,
answer text ,
ishot tinyint(4) ,
tag varchar(100) ,
read_numbers int ,
help_numbers int ,
unhelp_numbers int ,
created_time datetime ,
updated_time datetime ,
remark varchar(255) 
); 
xxxxxxxxxxxxxxxxxxxxxxxxxxx
oooooooooooooooooooooooooooooooo

[root@local_game_server2 test]# sed '/,$/N;s#,\n);#\n);#g;P;D' test
create table hr_attence_plan (
id bigint(20) ,
dep_id bigint(20) ,
rule_id bigint(20) ,
work_week varchar(100) ,
work_holiday varchar(100) ,
created_time datetime ,
longitude varchar(16) ,
latitude varchar(16) ,
place varchar(100) ,
distance bigint(20) ,
company_id bigint(20) 
);
xxxxxxxxxxxxxxxxxxxxxxxxxxx
 create table oa_faq_info (
id bigint(20) ,
categoryid bigint(20) ,
sort tinyint(4) ,
title varchar(256) ,
question varchar(1000) ,
answer text ,
ishot tinyint(4) ,
tag varchar(100) ,
read_numbers int ,
help_numbers int ,
unhelp_numbers int ,
created_time datetime ,
updated_time datetime ,
remark varchar(255) 
);
xxxxxxxxxxxxxxxxxxxxxxxxxxx
oooooooooooooooooooooooooooooooo




[root@local_game_server2 test]# sed '/);/{x;s#,##;x;};x' test

create table hr_attence_plan (
id bigint(20) ,
dep_id bigint(20) ,
rule_id bigint(20) ,
work_week varchar(100) ,
work_holiday varchar(100) ,
created_time datetime ,
longitude varchar(16) ,
latitude varchar(16) ,
place varchar(100) ,
distance bigint(20) ,
company_id bigint(20) 
);
xxxxxxxxxxxxxxxxxxxxxxxxxxx
 create table oa_faq_info (
id bigint(20) ,
categoryid bigint(20) ,
sort tinyint(4) ,
title varchar(256) ,
question varchar(1000) ,
answer text ,
ishot tinyint(4) ,
tag varchar(100) ,
read_numbers int ,
help_numbers int ,
unhelp_numbers int ,
created_time datetime ,
updated_time datetime ,
remark varchar(255) 
);
xxxxxxxxxxxxxxxxxxxxxxxxxxx




