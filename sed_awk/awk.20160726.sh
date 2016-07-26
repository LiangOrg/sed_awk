需求:将源文件file1变成目标文件file2
解析：将以">"开头的行中第3列不为AA的行到下一个">"之间的行剔除
源文件：
###############################################
# cat file1
>H1_22 ASDSF AA BB 1111
ASDSJFKJKDJF
DSJFKDJFDJDFDFD
>F2_44_3 SDKS BB DF 2323
DFDSFDDGJFGLJFLDL
xxxxxxxxxxxx
ooooooooooooooo

>SDS_22 DFD AA FDD 1111
FDSFDSFDGDG
FDFDSFDGFDGTHTYU
FDGRFHHHHHHHHHH
##################################################
目标文件：# cat file2
>H1_22 ASDSF AA BB 1111
ASDSJFKJKDJF
DSJFKDJFDJDFDFD
>SDS_22 DFD AA FDD 1111
FDSFDSFDGDG
FDFDSFDGFDGTHTYU
FDGRFHHHHHHHHHH
##########################################
代码：

# awk '/^>/&&$3!="AA"{a=1;next}/^>/{a=0}!a' file1
>H1_22 ASDSF AA BB 1111
ASDSJFKJKDJF
DSJFKDJFDJDFDFD
>SDS_22 DFD AA FDD 1111
FDSFDSFDGDG
FDFDSFDGFDGTHTYU
FDGRFHHHHHHHHHH