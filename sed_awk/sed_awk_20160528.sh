需求：对file文件如果出现IP的行，它的下一行或者下多行是出现字母的行，将IP和他的下多行取出来（sed,awk，grep）
源文件：
# cat file
192.168.1.1
aaaaa
192.168.1.2
192.168.1.3
192.168.1.5
bbbb
cccc
192.168.1.5
192.168.1.6
想要的结果：
192.168.1.1
aaaaa
192.168.1.5
bbbb
cccc



grep：

grep -Pzo '(\d+\.){3}\d+(\n[a-z]+)+' file

grep -Pzo '.*(\n[a-z]+)+' file


sed :

sed -r '/[0-9]/{$!N;/\n[^0-9]+/P;D}' file

sed -n '/[0-9]/{x;/\n/p;x;h};/^[a-z]/H' file

sed -n '/[0-9]/{x;/\n/p;d};/[a-z]/H' file

sed -r '/[0-9]/{x;/\n/p;x;h;d};/[a-z]+/H;${g;q};d' file

sed -n ':a;/[0-9]/{:1;h;n;//b1;:2;H;$!n;${//!H;g;p;b};//!b2;x;p;g;ba}' file

####sed -n ':a;/[0-9]/{h;:1;n;//b1;:2;H;$!n;${//!H;g;p;b};//!b2;x;p;g;ba}' file (bug,还得修复)
awk:

awk 'f&&/^[0-9]/&&c>=1{print s;s="";c=0}/^[0-9]/{f=1;s=$0}f&&/^[a-z]/{c++;s=s"\n"$0}' file

awk '/[0-9]/{a=$0;next}a{print a;a=""}1' file

awk -vRS='[0-9.]+' '$1{printf "%s%s",s,$0}{s=RT}' file


perl：

perl -nle 'if(/\./){$k="$_\n";next}print "$k$_";$k=""' file





