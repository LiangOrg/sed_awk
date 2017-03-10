#awk 打印逆序矩正
awk -vN=1000 'BEGIN{n = (int(sqrt(N) / 2) - sqrt(N) / 2) ? (int(sqrt(N) / 2) + 1) : (int(sqrt(N) / 2));for(i = 1;i <= 2 * n;i++){for(j = 1;j <= 2 * n;j++){if(j + i - 1 < 2 * n){r = (j >= i) ? (n - i + 1) : (n - j + 1);v = (j >= i) ? (4 * (n - i)^2 - j - i + 2 * n + 1) : (4 * (n - j)^2 - 3 * j + i + 2 * n + 1);} else {r = (j <= i) ? (i - n) : (j - n);v = (j <= i) ? (4 * (i - n - 1)^2 + j + 5 * i - 6 * n - 3) : (4 * (j - n - 1)^2 + 7 * j - i - 6 * n - 3)}srand(r);printf("\033["(30 + int(1 + 9 * rand()))"m%4s\033[m", (v > N) ? "" : v);}print ""}}'

#awk打印 杨辉三角
echo 15|awk '{x=8;for(i=1;i<$0;i++){for(j=1;j<=3*($0-i)-(x>0?x:0);j++)printf" ";for(k=i;k>=1;k--)printf"%d ",k;for(l=2;l<=i;l++)printf"%d ",l;printf"\n";x--};for(i=1;i<=$0;i++){for(j=1;j<=(i<=$0-10+1?3*(i-1):3*(i-1)+2-(i-$0%10-10*int(($0-10)/10)));j++)printf" ";for(k=$0-i+1;k>=1;k--)printf"%d ",k;for(l=2;l<=$0-i+1;l++)printf"%d ",l;printf"\n"}}'
