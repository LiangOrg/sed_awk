#awk 'BEGIN{for(i=1;i**4<1000000;i++){if((n=split(i**3 i**4,b,""))==10){for(j=0;j++<n;)!a[b[j]]++;if(length(a)==10)print i;delete a}}}'

#awk -F '' '{while(n++<$0){s=n^3n^4;if(length(s)==10){$0=s;for(m=0;m++<NF;)if(!a[$m]++)a[n]+=$m;if(a[n]==45)print n}}}' <<<100

#awk 'BEGIN{for(i=1;i<100;i++){if(length(i^3)==4&&(length(i^4)==6)){print i;break}}}'