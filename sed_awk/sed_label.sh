标签函数{

			: lable # 建立命令标记，配合b，t函数使用跳转
			b lable # 分支到脚本中带有标记的地方，如果分支不存在则分支到脚本的末尾。
			t labe  # 判断分支，从最后一行开始，条件一旦满足或者T,t命令，将导致分支到带有标号的命令出，或者到脚本末尾。与b函数不同在于t在执行跳转前会先检查其前一个替换命令是否成功，如成功，则执行跳转。

			sed -e '{:p1;/A/s/A/AA/;/B/s/B/BB/;/[AB]\{10\}/b;b p1;}'     # 文件内容第一行A第二行B:建立标签p1;两个替换函数(A替换成AA,B替换成BB)当A或者B达到10个以后调用b,返回
			echo 'sd  f   f   [a    b      c    cddd    eee]' | sed ':n;s#\(\[[^ ]*\)  *#\1#;tn'  # 标签函数t使用方法,替换[]里的空格
			echo "198723124.03"|sed -r ':a;s/([0-9]+)([0-9]{3})/\1,\2/;ta'  # 每三个字符加一个逗号

		}


# add commas to numeric strings, changing "1234567" to "1,234,567"

-> gsed ':a;s/\B[0-9]\{3\}\>/,&/;ta'                     # GNU sed

-> sed -e :a -e 's/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/;ta'  # other seds

-> awk -v FS=OFS= '{for(i=2;i<=NF;i++) $i=(NF-i+1)%3?$i:","$i}1'
		
		
		
[root@liudehua test1]# cat test
AA
BC
AA
CB
CC
AA

[root@liudehua test1]# sed '/^AA/s/$/ YES/;t;s/$/ NO/' test   （t）
AA YES
BC NO
AA YES
CB NO
CC NO
AA YES
[root@liudehua test1]# sed '/^AA/ba;s/$/ NO/;b;:a;s/$/ YES/' test   （b）
AA YES
BC NO
AA YES
CB NO
CC NO
AA YES
[root@liudehua test1]# sed '/AA/s#$# YES#;/AA/!s#$# NO#g' test    （非标签函数）
AA YES
BC NO
AA YES
CB NO
CC NO
AA YES