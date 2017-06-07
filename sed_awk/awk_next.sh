#!/bin/bash
#打印匹配行的后N行
seq 10|awk '/5/{p=3;next}p-->0'
6
7
8
