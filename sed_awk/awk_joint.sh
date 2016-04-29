[root@ ~]# echo 'aa bb cc'|awk -vd='"'  '{c="1,"NF;l=split(c,a,",");for(i=1;i<=l;i++)$a[i]=d $a[i] d}1'
"aa" bb "cc"


总结：$a[i]=d $a[i] d （其实就是强行赋值，加拼接）
相当于$1="XX" $1 "JJ"  (但是这里d='"',所以引号可以省略) 
# echo "aa  bb"|awk '{$1="kk" $1 "ll"}1'
kkaall bb

# echo "aa  bb"|awk '{c="\"";$1=c $1 c;print $1}'
"aa"
# echo "aa  bb"|awk '{c="'\''";$1=c $1 c;print $1}'
'aa'



$a[i]=d  (当i=1，a[i]就等于1,$a[i]就是$1,  $1=d $1 d,等价于$1=d$1d ,d='"';所以$1的值是"$1","aa")
同理（当i=2时，a[2]="NF",NF=3，所以是a[2]=3,$a[2]就是$3,就是$3=d $3 d,d='"',所以$3的值是"cc"）


所以结果就是 "aa" bb "cc" (bb 没有变，变得是$1,$3,就是aa，cc变了，前后加上了双引号)


"aa" bb "cc"