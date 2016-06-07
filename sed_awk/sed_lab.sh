#sed标签函数整理：
#datetime：20160603202300
#auth：shashen
#QQ:linux /shell/awk/sed 联盟 219636001
#感谢baby，K神，随意哥等，以及群里其他的大神的帮助
#此文是献给有一定sed基础的伙伴，大神可以无视我。
#我是个新人，如有解释的不当之处，请见谅。



sed 标签函数： 共6种模式   T, t, b, T：label, t：label,  b：lable  (:lable 是可选的，可以是字母，或者数字)




[localhost]#  echo -e "123\n456\n789"
123
456
789



例子：
1.
[localhost]# echo -e "123\n456\n789"|sed 's#123#& ok#;t;s#.*#& xxoo#;'   （t）
123 ok
456 xxoo
789 xxoo

共两个命令：替换"123"为"123 ok";和替换原文为"& xxoo"


分析：
（commad1;t;commad2）

（注释：1)commad1执行替换成功的行,遇到t,并且没有接标签，不会执行后边的commad2;
		2)commad1执行替换失败的行，则会执行command2）

(默认没有替换就是替换失败)





2.
[localhost]# echo -e "123\n456\n789"|sed 's#123#& ok#;T;s#.*#& xxoo#;'     (T)
123 ok xxoo
456
789

分析：
（commad1;T;commad2）

（注释：1)commad1执行替换成功的行,遇到T,并且没有接标签，会继续执行command2;
        2)commad1执行替换失败的行，不会执行command2)

(默认没有替换就是替换失败)






3.
[localhost]#echo -e "123\n456\n789"|sed 's#123#& ok#;b;s#.*#& xxoo#;'   (b)
123 ok
456
789

分析：
（commad1;b;commad2）

（注释：commad1执行替换成功或者失败的行,遇到b,并且没有接标签,会无条件直接跳到脚本末尾，所以command2不会执行)




4.
[localhost]#echo -e "123\n456\n789"|sed '/123/{s##& ok#;ta};s#.*#& xxoo#;b;:a;a\###'    (ta)
123 ok
###
456 xxoo
789 xxoo



分析：{commad1;ta};{command2};b;{:a;commd3}

(注释：1)匹配到/123/的行,command1执行替换成功，会先跳到标签:a处,会继续执行command3,而不会执行command2;
	   2)其他行先执行command2,碰见b就跳到脚本末尾，不会执行command3,如果不接b,它还会继续执行command3.)






5.
[localhost]# echo -e "123\n456\n789"|sed '/123/s##& ok#;ta;s#.*#& xxoo#;b;:a;a\###'     (ta)
123 ok
###
456 xxoo
789 xxoo

分析：{command1};ta;{command2};b;:a;{commad3}

(注释：1)所有行,command1执行替换成功的行，会先跳到标签a处,会继续执行command3,而不会执行command2;
       2)command1执行替换失败的行，不会先跳转标签a去执行command3，而是会先执行command2,碰见b就跳到脚本末尾，不会执行command3,如果不接b,它还会继续执行command3.)

(默认没有替换就是替换失败)






6.
[localhost]# echo -e "123\n456\n789"|sed '/123/{s##& ok#;Ta};s#.*#& xxoo#;b;:a;a\###'     (Ta)
123 ok xxoo
456 xxoo
789 xxoo

分析：{commad1;Ta};{command2};b;{:a;commd3}
(注释：1)匹配到/123/的行，command1执行替换成功，不会先跳到标签a处去执行command3,而是先执行command2,碰到b,跳到脚本末尾,如果不加b,会继续执行command3;
       2)其他行则执行command2,遇到b就跳到脚本末尾，不会执行command3,如果不接b,它还会继续执行command3.)
	  






7.
[localhost]# echo -e "123\n456\n789"|sed '/123/s##& ok#;Ta;s#.*#& xxoo#;b;:a;a\###'       (Ta)
123 ok xxoo
456
###
789
###

分析：{commad1};Ta;{command2};b;{:a;commd3}

(注释：1)所有行，command1执行替换成功的行，不会先跳到标签:a处去执行command3，而是先执行command2,碰到b,跳到脚本末尾,如果不加b,会继续执行command3;
		2)执行command2失败的行,则会跳转到标签a处执行command3,不会执行command2.) 

(默认没有替换就是替换失败)





8.
[localhost]# echo -e "123\n456\n789"|sed '/123/{s##& ok#;ba};s#.*#& xxoo#;b;:a;a\###'     (ba)
123 ok
###
456 xxoo
789 xxoo

分析：{command1;ba};{command2};b;:a;{command3}

(注释：1)匹配到/123/的行,command1执行完毕后,跳转到标签a处执行command3，然后结束;
	   2)其他行则执行command2,碰到b,跳到脚本末尾,如果不加b,会继续执行command3;)




9.
[localhost]# echo -e "123\n456\n789"|sed '/123/s##& ok#;ba;s#.*#& xxoo#;b;:a;a\###'        (ba)
123 ok
###
456
###
789
###

分析:{command1}:ba;{command2}:b;:a;{command3}

(注释:所有行,command1替换成功或者失败的行，都会跳转到command3，然后结束,command2不会执行.)

（注意是替换失败，不是匹配失败）
(默认没有替换就是替换失败)