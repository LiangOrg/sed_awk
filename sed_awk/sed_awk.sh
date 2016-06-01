sed{
	
		# 先读取资料、存入模式空间、对其进行编辑、再输出、再用下一行替换模式空间内容
		# 调试工具sedsed (参数 -d)   http://aurelio.net/sedsed/sedsed-1.0
			
		-n 	 # 输出由编辑指令控制(取消默认的输出,必须与编辑指令一起配合)
		-i   # 直接对文件操作
		-e   # 多重编辑
		-r   # 正则可不转移特殊字符

		b    # 跳过匹配的行
		p    # 打印
		d    # 删除
		s    # 替换
		g    # 配合s全部替换
		i    # 行前插入
		a    # 行后插入
		r    # 读
		y    # 转换
		q    # 退出

		&    # 代表查找的串内容
		*    # 任意多个 前驱字符(前导符)
		?    # 0或1个 最小匹配 没加-r参数需转义 \?
		$    # 最后一行
		.*   # 匹配任意多个字符
		\(a\)   # 保存a作为标签1(\1)

		模式空间{

			# 模式空间(两行两行处理) 模式匹配的范围，一般而言，模式空间是输入文本中某一行，但是可以通过使用N函数把多于一行读入模式空间
			# 暂存空间里默认存储一个空行
			n   # 读入下一行(覆盖上一行)
			h   # 把模式空间里的行拷贝到暂存空间
			H   # 把模式空间里的行追加到暂存空间
			g   # 用暂存空间的内容替换模式空间的行
			G   # 把暂存空间的内容追加到模式空间的行后
			x   # 将暂存空间的内容于模式空间里的当前行互换
			！  # 对其前面的要匹配的范围取反
			D   # 删除当前模式空间中直到并包含第一个换行符的所有字符(/.*/匹配模式空间中所有内容，匹配到就执行D,没匹配到就结束D)
			N   # 追加下一个输入行到模式空间后面并在第二者间嵌入一个换行符，改变当前行号码,模式匹配可以延伸跨域这个内嵌换行
			P   # 打印模式空间中的直到并包含第一个换行的所有字符 

		}

		标签函数{

			: lable # 建立命令标记，配合b，t函数使用跳转
			b lable # 分支到脚本中带有标记的地方，如果分支不存在则分支到脚本的末尾。
			t labe  # 判断分支，从最后一行开始，条件一旦满足或者T,t命令，将导致分支到带有标号的命令出，或者到脚本末尾。与b函数不同在于t在执行跳转前会先检查其前一个替换命令是否成功，如成功，则执行跳转。

			sed -e '{:p1;/A/s/A/AA/;/B/s/B/BB/;/[AB]\{10\}/b;b p1;}'     # 文件内容第一行A第二行B:建立标签p1;两个替换函数(A替换成AA,B替换成BB)当A或者B达到10个以后调用b,返回
			echo 'sd  f   f   [a    b      c    cddd    eee]' | sed ':n;s#\(\[[^ ]*\)  *#\1#;tn'  # 标签函数t使用方法,替换[]里的空格
			echo "198723124.03"|sed -r ':a;s/([0-9]+)([0-9]{3})/\1,\2/;ta'  # 每三个字符加一个逗号

		}

		引用外部变量{

			sed -n ''$a',10p'
			sed -n ""$a",10p"

		}

		sed 10q                                       # 显示文件中的前10行 (模拟"head")
		sed -n '$='                                   # 计算行数(模拟 "wc -l")
		sed -n '5,/^no/p'                             # 打印从第5行到以no开头行之间的所有行
		sed -i "/^$f/d" a     　　                  　# 删除匹配行
		sed -i '/aaa/,$d'                             # 删除匹配行到末尾
		sed -i "s/=/:/" c                             # 直接对文本替换
		sed -i "/^pearls/s/$/j/"                      # 找到pearls开头在行尾加j
		sed '/1/,/3/p' file                           # 打印1和3之间的行
		sed -n '1p' 文件                              # 取出指定行
		sed '5i\aaa' file                             # 在第5行之前插入行
		sed '5a\aaa' file                             # 在第5行之后抽入行
		echo a|sed -e '/a/i\b'                        # 在匹配行前插入一行
		echo a|sed -e '/a/a\b'                        # 在匹配行后插入一行
		echo a|sed 's/a/&\nb/g'                       # 在匹配行后插入一行
		seq 10| sed -e{1,3}'s/./a/'                   # 匹配1和3行替换
		sed -n '/regexp/!p'                           # 只显示不匹配正则表达式的行
		sed '/regexp/d'                               # 只显示不匹配正则表达式的行
		sed '$!N;s/\n//'                              # 将每两行连接成一行
		sed '/baz/s/foo/bar/g'                        # 只在行中出现字串"baz"的情况下将"foo"替换成"bar" 
		sed '/baz/!s/foo/bar/g'                       # 将"foo"替换成"bar"，并且只在行中未出现字串"baz"的情况下替换
		echo a|sed -e 's/a/#&/g'                      # 在a前面加#号
		sed 's/foo/bar/4'                             # 只替换每一行中的第四个字串
		sed 's/\(.*\)foo/\1bar/'                      # 替换每行最后一个字符串
		sed 's/\(.*\)foo\(.*foo\)/\1bar\2/'           # 替换倒数第二个字符串
		sed 's/[0-9][0-9]$/&5/'                        # 在以[0-9][0-9]结尾的行后加5
		sed -n ' /^eth\|em[01][^:]/{n;p;}'            # 匹配多个关键字
		sed -n -r ' /eth|em[01][^:]/{n;p;}'           # 匹配多个关键字
		echo -e "1\n2"|xargs -i -t sed 's/^/1/' {}    # 同时处理多个文件
		sed '/west/,/east/s/$/*VACA*/'                # 修改west和east之间的所有行，在结尾处加*VACA*
		sed  's/[^1-9]*\([0-9]\+\).*/\1/'             # 取出第一组数字，并且忽略掉开头的0
		sed -n '/regexp/{g;1!p;};h'                   # 查找字符串并将匹配行的上一行显示出来，但并不显示匹配行
		sed -n ' /regexp/{n;p;}'                      # 查找字符串并将匹配行的下一行显示出来，但并不显示匹配行
		sed -n 's/\(mar\)got/\1ianne/p'               # 保存\(mar\)作为标签1
		sed -n 's/\([0-9]\+\).*\(t\)/\2\1/p'          # 保存多个标签
		sed -i -e '1,3d' -e 's/1/2/'                  # 多重编辑(先删除1-3行，在将1替换成2)
		sed -e 's/@.*//g' -e '/^$/d'                  # 删除掉@后面所有字符，和空行
		sed -n -e "{s/文本(正则)/替换的内容/p}"       # 替换并打印出替换行
		sed -n -e "{s/^ *[0-9]*//p}"                  # 打印并删除正则表达式的那部分内容
		echo abcd|sed 'y/bd/BE/'                      # 匹配字符替换
		sed '/^#/b;y/y/P/' 2                          # 非#号开头的行替换字符
		sed '/suan/r 读入文件'                        # 找到含suan的行，在后面加上读入的文件内容
		sed -n '/no/w 写入文件'                       # 找到含no的行，写入到指定文件中
		sed '/regex/G'                                # 在匹配式样行之后插入一空行
		sed '/regex/{x;p;x;G;}'                       # 在匹配式样行之前和之后各插入一空行
		sed 'n;d'                                     # 删除所有偶数行
		sed 'G;G'                                     # 在每一行后面增加两空行
		sed '/^$/d;G'                                 # 在输出的文本中每一行后面将有且只有一空行
		sed 'n;n;n;n;G;'                              # 在每5行后增加一空白行
		sed -n '5~5p'                                 # 只打印行号为5的倍数
		seq 1 30|sed  '5~5s/.*/a/'                    # 倍数行执行替换
		sed -n '3,${p;n;n;n;n;n;n;}'                  # 从第3行开始，每7行显示一次
		sed -n 'h;n;G;p'                              # 奇偶调换
		seq 1 10|sed '1!G;h;$!d'                      # 倒叙排列
		ls -l|sed -n '/^.rwx.*/p'                     # 查找属主权限为7的文件
		sed = filename | sed 'N;s/\n/\t/'             # 为文件中的每一行进行编号(简单的左对齐方式)
		sed 's/^[ \t]*//'                             # 将每一行前导的"空白字符"(空格，制表符)删除,使之左对齐 
		sed 's/^[ \t]*//;s/[ \t]*$//'                 # 将每一行中的前导和拖尾的空白字符删除
		sed '/{abc,def\}\/\[111,222]/s/^/00000/'      # 匹配需要转行的字符: } / [
		echo abcd\\nabcde |sed 's/\\n/@/g' |tr '@' '\n'        # 将换行符转换为换行
		cat tmp|awk '{print $1}'|sort -n|sed -n '$p'           # 取一列最大值
		sed -n '{s/^[^\/]*//;s/\:.*//;p}' /etc/passwd          # 取用户家目录(匹配不为/的字符和匹配:到结尾的字符全部删除)
		sed = filename | sed 'N;s/^/      /; s/ *\(.\{6,\}\)\n/\1   /'   # 对文件中的所有行编号(行号在左，文字右端对齐)
		/sbin/ifconfig |sed 's/.*inet addr:\(.*\) Bca.*/\1/g' |sed -n '/eth/{n;p}'   # 取所有IP

		修改keepalive配置剔除后端服务器{

			sed -i '/real_server.*10.0.1.158.*8888/,+8 s/^/#/' keepalived.conf
			sed -i '/real_server.*10.0.1.158.*8888/,+8 s/^#//' keepalived.conf

		}
		
		模仿rev功能{

			echo 123 |sed '/\n/!G;s/\(.\)\(.*\n\)/&\2\1/;//D;s/.//;'
			/\n/!G;         　　　　　　# 没有\n换行符，要执行G,因为保留空间中为空，所以在模式空间追加一空行
			s/\(.\)\(.*\n\)/&\2\1/;     # 标签替换 &\n23\n1$ (关键在于& ,可以让后面//匹配到空行)
			//D;            　　　　　　# D 命令会引起循环删除模式空间中的第一部分，如果删除后，模式空间中还有剩余行，则返回 D 之前的命令，重新执行，如果 D 后，模式空间中没有任何内容，则将退出。  //D 匹配空行执行D,如果上句s没有匹配到,//也无法匹配到空行, "//D;"命令结束
			s/.//;          　　　　　　# D结束后,删除开头的 \n

		}

	}

	xargs{
	
		# 命令替换
		-t 先打印命令，然后再执行
		-i 用每项替换 {}
		find / -perm +7000 | xargs ls -l                    # 将前面的内容，作为后面命令的参数
		seq 1 10 |xargs  -i date -d "{} days " +%Y-%m-%d    # 列出10天日期

	}
	awk{
	
		# 默认是执行打印全部 print $0
		# 1为真 打印$0
		# 0为假 不打印

		-F   # 改变FS值(分隔符)
		~    # 域匹配
		==   # 变量匹配
		!~   # 匹配不包含
		=    # 赋值
		!=   # 不等于
		+=   # 叠加
		
		\b   # 退格
		\f   # 换页
		\n   # 换行
		\r   # 回车
		\t   # 制表符Tab
		\c   # 代表任一其他字符
		
		-F"[ ]+|[%]+"  # 多个空格或多个%为分隔符
		[a-z]+         # 多个小写字母
		[a-Z]          # 代表所有大小写字母(aAbB...zZ)
		[a-z]          # 代表所有大小写字母(ab...z)
		[:alnum:]      # 字母数字字符
		[:alpha:]      # 字母字符
		[:cntrl:]      # 控制字符
		[:digit:]      # 数字字符
		[:graph:]      # 非空白字符(非空格、控制字符等)
		[:lower:]      # 小写字母
		[:print:]      # 与[:graph:]相似，但是包含空格字符
		[:punct:]      # 标点字符
		[:space:]      # 所有的空白字符(换行符、空格、制表符)
		[:upper:]      # 大写字母
		[:xdigit:]     # 十六进制的数字(0-9a-fA-F)
		[[:digit:][:lower:]]    # 数字和小写字母(占一个字符)


		内建变量{
			$n            # 当前记录的第 n 个字段，字段间由 FS 分隔
			$0            # 完整的输入记录
			ARGC          # 命令行参数的数目
			ARGIND        # 命令行中当前文件的位置 ( 从 0 开始算 ) 
			ARGV          # 包含命令行参数的数组
			CONVFMT       # 数字转换格式 ( 默认值为 %.6g)
			ENVIRON       # 环境变量关联数组
			ERRNO         # 最后一个系统错误的描述
			FIELDWIDTHS   # 字段宽度列表 ( 用空格键分隔 ) 
			FILENAME      # 当前文件名
			FNR           # 同 NR ，但相对于当前文件
			FS            # 字段分隔符 ( 默认是任何空格 ) 
			IGNORECASE    # 如果为真（即非 0 值），则进行忽略大小写的匹配
			NF            # 当前记录中的字段数(列)
			NR            # 当前行数
			OFMT          # 数字的输出格式 ( 默认值是 %.6g) 
			OFS           # 输出字段分隔符 ( 默认值是一个空格 ) 
			ORS           # 输出记录分隔符 ( 默认值是一个换行符 ) 
			RLENGTH       # 由 match 函数所匹配的字符串的长度
			RS            # 记录分隔符 ( 默认是一个换行符 ) 
			RSTART        # 由 match 函数所匹配的字符串的第一个位置
			SUBSEP        # 数组下标分隔符 ( 默认值是 /034) 
			BEGIN         # 先处理(可不加文件参数)
			END           # 结束时处理
		}

		内置函数{
			gsub(r,s)          # 在整个$0中用s替代r   相当于 sed 's///g'
			gsub(r,s,t)        # 在整个t中用s替代r 
			index(s,t)         # 返回s中字符串t的第一位置 
			length(s)          # 返回s长度 
			match(s,r)         # 测试s是否包含匹配r的字符串 
			split(s,a,fs)      # 在fs上将s分成序列a 
			sprint(fmt,exp)    # 返回经fmt格式化后的exp 
			sub(r,s)           # 用$0中最左边最长的子串代替s   相当于 sed 's///'
			substr(s,p)        # 返回字符串s中从p开始的后缀部分 
			substr(s,p,n)      # 返回字符串s中从p开始长度为n的后缀部分 
		}

		awk判断{
			awk '{print ($1>$2)?"第一排"$1:"第二排"$2}'      # 条件判断 括号代表if语句判断 "?"代表then ":"代表else
			awk '{max=($1>$2)? $1 : $2; print max}'          # 条件判断 如果$1大于$2,max值为为$1,否则为$2
			awk '{if ( $6 > 50) print $1 " Too high" ;\
			else print "Range is OK"}' file
			awk '{if ( $6 > 50) { count++;print $3 } \
			else { x+5; print $2 } }' file
		}

		awk循环{
			awk '{i = 1; while ( i <= NF ) { print NF, $i ; i++ } }' file
			awk '{ for ( i = 1; i <= NF; i++ ) print NF,$i }' file
		}
		
		awk '/Tom/' file               # 打印匹配到得行
		awk '/^Tom/{print $1}'         # 匹配Tom开头的行 打印第一个字段
		awk '$1 !~ /ly$/'              # 显示所有第一个字段不是以ly结尾的行
		awk '$3 <40'                   # 如果第三个字段值小于40才打印
		awk '$4==90{print $5}'         # 取出第四列等于90的第五列
		awk '/^(no|so)/' test          # 打印所有以模式no或so开头的行
		awk '$3 * $4 > 500'            # 算术运算(第三个字段和第四个字段乘积大于500则显示)
		awk '{print NR" "$0}'          # 加行号
		awk '/tom/,/suz/'              # 打印tom到suz之间的行
		awk '{a+=$1}END{print a}'      # 列求和
		awk 'sum+=$1{print sum}'       # 将$1的值叠加后赋给sum
		awk '{a+=$1}END{print a/NR}'   # 列求平均值
		awk '!s[$1 $3]++' file         # 根据第一列和第三列过滤重复行
		awk -F'[ :\t]' '{print $1,$2}'           # 以空格、:、制表符Tab为分隔符
		awk '{print "'"$a"'","'"$b"'"}'          # 引用外部变量
		awk '{if(NR==52){print;exit}}'           # 显示第52行
		awk '/关键字/{a=NR+2}a==NR {print}'      # 取关键字下第几行
		awk 'gsub(/liu/,"aaaa",$1){print $0}'    # 只打印匹配替换后的行
		ll | awk -F'[ ]+|[ ][ ]+' '/^$/{print $8}'             # 提取时间,空格不固定
		awk '{$1="";$2="";$3="";print}'                        # 去掉前三列
		echo aada:aba|awk '/d/||/b/{print}'                    # 匹配两内容之一
		echo aada:abaa|awk -F: '$1~/d/||$2~/b/{print}'         # 关键列匹配两内容之一
		echo Ma asdas|awk '$1~/^[a-Z][a-Z]$/{print }'          # 第一个域匹配正则
		echo aada:aaba|awk '/d/&&/b/{print}'                   # 同时匹配两条件
		awk 'length($1)=="4"{print $1}'                        # 字符串位数
		awk '{if($2>3){system ("touch "$1)}}'                  # 执行系统命令
		awk '{sub(/Mac/,"Macintosh",$0);print}'                # 用Macintosh替换Mac
		awk '{gsub(/Mac/,"MacIntosh",$1); print}'              # 第一个域内用Macintosh替换Mac
		awk -F '' '{ for(i=1;i<NF+1;i++)a+=$i  ;print a}'      # 多位数算出其每位数的总和.比如 1234， 得到 10
		awk '{ i=$1%10;if ( i == 0 ) {print i}}'               # 判断$1是否整除(awk中定义变量引用时不能带 $ )
		awk 'BEGIN{a=0}{if ($1>a) a=$1 fi}END{print a}'        # 列求最大值  设定一个变量开始为0，遇到比该数大的值，就赋值给该变量，直到结束
		awk 'BEGIN{a=11111}{if ($1<a) a=$1 fi}END{print a}'    # 求最小值
		awk '{if(A)print;A=0}/regexp/{A=1}'                    # 查找字符串并将匹配行的下一行显示出来，但并不显示匹配行
		awk '/regexp/{print A}{A=$0}'                          # 查找字符串并将匹配行的上一行显示出来，但并不显示匹配行
		awk '{if(!/mysql/)gsub(/1/,"a");print $0}'             # 将1替换成a，并且只在行中未出现字串mysql的情况下替换
		awk 'BEGIN{srand();fr=int(100*rand());print fr;}'      # 获取随机数
		awk '{if(NR==3)F=1}{if(F){i++;if(i%7==1)print}}'       # 从第3行开始，每7行显示一次
		awk '{if(NF<1){print i;i=0} else {i++;print $0}}'      # 显示空行分割各段的行数
		echo +null:null  |awk -F: '$1!~"^+"&&$2!="null"{print $0}'       # 关键列同时匹配
		awk -v RS=@ 'NF{for(i=1;i<=NF;i++)if($i) printf $i;print ""}'    # 指定记录分隔符
		awk '{b[$1]=b[$1]$2}END{for(i in b){print i,b[i]}}'              # 列叠加
		awk '{ i=($1%100);if ( $i >= 0 ) {print $0,$i}}'                 # 求余数
		awk '{b=a;a=$1; if(NR>1){print a-b}}'                            # 当前行减上一行
		awk '{a[NR]=$1}END{for (i=1;i<=NR;i++){print a[i]-a[i-1]}}'      # 当前行减上一行
		awk -F: '{name[x++]=$1};END{for(i=0;i<NR;i++)print i,name[i]}'   # END只打印最后的结果,END块里面处理数组内容
		awk '{sum2+=$2;count=count+1}END{print sum2,sum2/count}'         # $2的总和  $2总和除个数(平均值)
		awk -v a=0 -F 'B' '{for (i=1;i<NF;i++){ a=a+length($i)+1;print a  }}'     # 打印所以B的所在位置
		awk 'BEGIN{ "date" | getline d; split(d,mon) ; print mon[2]}' file        # 将date值赋给d，并将d设置为数组mon，打印mon数组中第2个元素
		awk 'BEGIN{info="this is a test2010test!";print substr(info,4,10);}'      # 截取字符串(substr使用)
		awk 'BEGIN{info="this is a test2010test!";print index(info,"test")?"ok":"no found";}'      # 匹配字符串(index使用)
		awk 'BEGIN{info="this is a test2010test!";print match(info,/[0-9]+/)?"ok":"no found";}'    # 正则表达式匹配查找(match使用)
		awk '{for(i=1;i<=4;i++)printf $i""FS; for(y=10;y<=13;y++)  printf $y""FS;print ""}'        # 打印前4列和后4列
		awk 'BEGIN{for(n=0;n++<9;){for(i=0;i++<n;)printf i"x"n"="i*n" ";print ""}}'                # 乘法口诀
		awk 'BEGIN{info="this is a test";split(info,tA," ");print length(tA);for(k in tA){print k,tA[k];}}'             # 字符串分割(split使用)
		awk '{if (system ("grep "$2" tmp/* > /dev/null 2>&1") == 0 ) {print $1,"Y"} else {print $1,"N"} }' a            # 执行系统命令判断返回状态
		awk  '{for(i=1;i<=NF;i++) a[i,NR]=$i}END{for(i=1;i<=NF;i++) {for(j=1;j<=NR;j++) printf a[i,j] " ";print ""}}'   # 将多行转多列
		netstat -an|awk -v A=$IP -v B=$PORT 'BEGIN{print "Clients\tGuest_ip"}$4~A":"B{split($5,ip,":");a[ip[1]]++}END{for(i in a)print a[i]"\t"i|"sort -nr"}'    # 统计IP连接个数
		cat 1.txt|awk -F" # " '{print "insert into user (user,password,email)values(""'\''"$1"'\'\,'""'\''"$2"'\'\,'""'\''"$3"'\'\)\;'"}' >>insert_1.txt     # 处理sql语句
		awk 'BEGIN{printf "what is your name?";getline name < "/dev/tty" } $1 ~name {print "FOUND" name " on line ", NR "."} END{print "see you," name "."}' file  # 两文件匹配
		
		取本机IP{
			/sbin/ifconfig |awk -v RS="Bcast:" '{print $NF}'|awk -F: '/addr/{print $2}'
			/sbin/ifconfig |awk '/inet/&&$2!~"127.0.0.1"{split($2,a,":");print a[2]}'
			/sbin/ifconfig |awk -v RS='inet addr:' '$1!="eth0"&&$1!="127.0.0.1"{print $1}'|awk '{printf"%s|",$0}'
			/sbin/ifconfig |awk  '{printf("line %d,%s\n",NR,$0)}'         # 指定类型(%d数字,%s字符)
		}

		查看磁盘空间{
			df -h|awk -F"[ ]+|%" '$5>14{print $5}'
			df -h|awk 'NR!=1{if ( NF == 6 ) {print $5} else if ( NF == 5) {print $4} }' 
			df -h|awk 'NR!=1 && /%/{sub(/%/,"");print $(NF-1)}'
			df -h|sed '1d;/ /!N;s/\n//;s/ \+/ /;'    #将磁盘分区整理成一行   可直接用 df -P
		}

		排列打印{
			awk 'END{printf "%-10s%-10s\n%-10s%-10s\n%-10s%-10s\n","server","name","123","12345","234","1234"}' txt
			awk 'BEGIN{printf "|%-10s|%-10s|\n|%-10s|%-10s|\n|%-10s|%-10s|\n","server","name","123","12345","234","1234"}'
			awk 'BEGIN{
			print "   *** 开 始 ***   ";
			print "+-----------------+";
			printf "|%-5s|%-5s|%-5s|\n","id","name","ip";
			}
			$1!=1 && NF==4{printf "|%-5s|%-5s|%-5s|\n",$1,$2,$3" "$11}
			END{
			print "+-----------------+";
			print "   *** 结 束 ***   "
			}' txt
		}

		老男孩awk经典题{
			分析图片服务日志，把日志（每个图片访问次数*图片大小的总和）排行，也就是计算每个url的总访问大小
			说明：本题生产环境应用：这个功能可以用于IDC网站流量带宽很高，然后通过分析服务器日志哪些元素占用流量过大，进而进行优化或裁剪该图片，压缩js等措施。
			本题需要输出三个指标： 【被访问次数】    【访问次数*单个被访问文件大小】   【文件名（带URL）】
			测试数据
			59.33.26.105 - - [08/Dec/2010:15:43:56 +0800] "GET /static/images/photos/2.jpg HTTP/1.1" 200 11299 

			awk '{array_num[$7]++;array_size[$7]+=$10}END{for(i in array_num) {print array_num[i]" "array_size[i]" "i}}'
		}

		awk练习题{

			wang     4
			cui      3
			zhao     4
			liu      3
			liu      3
			chang    5
			li       2

			1 通过第一个域找出字符长度为4的
			2 当第二列值大于3时，创建空白文件，文件名为当前行第一个域$1 (touch $1)
			3 将文档中 liu 字符串替换为 hong
			4 求第二列的和
			5 求第二列的平均值
			6 求第二列中的最大值
			7 将第一列过滤重复后，列出每一项，每一项的出现次数，每一项的大小总和

			1、字符串长度
				awk 'length($1)=="4"{print $1}'
			2、执行系统命令
				awk '{if($2>3){system ("touch "$1)}}'
			3、gsub(/r/,"s",域) 在指定域(默认$0)中用s替代r  (sed 's///g')
				awk '{gsub(/liu/,"hong",$1);print $0}' a.txt
			4、列求和
				awk '{a+=$2}END{print a}'
			5、列求平均值
				awk '{a+=$2}END{print a/NR}'
				awk '{a+=$2;b++}END{print a,a/b}' 
			6、列求最大值
				awk 'BEGIN{a=0}{if($2>a) a=$2 }END{print a}'
			7、将第一列过滤重复列出每一项，每一项的出现次数，每一项的大小总和
				awk '{a[$1]++;b[$1]+=$2}END{for(i in a){print i,a[i],b[i]}}'
		}

		awk处理复杂日志{
			6.19： 
			DHB_014_号百总机服务业务日报：广州 到达数异常！
			DHB_023_号百漏话提醒日报：珠海 到达数异常！
			6.20： 
			DHB_014_号百总机服务业务日报：广州 到达数异常！到

			awk -F '[_ ：]+' 'NF>2{print $4,$1"_"$2,b |"sort";next}{b=$1}'
			
			# 当前行NF小于等于2 只针对{print $4,$1"_"$2,b |"sort";next} 有效 即 6.19：行跳过此操作,  {b=$1} 仍然执行
			# 当前行NF大于2 执行到 next 强制跳过本行，即跳过后面的 {b=$1}

			广州 DHB_014 6.19
		}
	}
	
	
	
	