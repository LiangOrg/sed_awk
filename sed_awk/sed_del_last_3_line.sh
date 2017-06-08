#!/bin/bash
#sed删掉文本的最后三行,文本行数未知.
seq 100|sed -r '1h;1!H;${g;s/(\n[^\n]+){3}$//p};d'
seq 100|sed -zr 's/([^\n]+\n){3}$//g'
seq 100|sed  ':a;$d;N;2,3ba;P;D'
seq 100|head -n -3


