FILE SPACING:

# double space a file 

-> sed G

-> awk '$0=$0 ORS'  or awk '1{print ""}' or: awk -vORS="\n\n" '1'


# double space a file which already has blank lines in it. Output file

# should contain no more than one blank line between lines of text.

-> sed '/^$/d;G'

-> awk NF ORS='\n\n'


# triple space a file

-> sed 'G;G'

-> awk '$0=$0 ORS ORS'


# undo double-spacing (assumes even-numbered lines are always blank)

-> sed 'n;d'

-> awk 'i=!i' 
（有很多可以实现这个的awk方法，这里只给出黑哥的码）

# insert a blank line above every line which matches "regex"

-> sed '/regex/{x;p;x;}'

-> awk '/regex/{$0=ORS $0}1' 


# insert a blank line below every line which matches "regex"

-> sed '/regex/G'

-> awk '/regex/{$0=$0 ORS}1' or: awk '{ORS=(/regex/)?"\n\n":"\n"}1'


# insert a blank line above and below every line which matches "regex"

-> sed '/regex/{x;p;x;G;}'

-> awk '/regex/{$0=ORS $0 ORS}1'


NUMBERING:

# number each line of a file (simple left alignment). Using a tab (see

# note on '\t' at end of file) instead of space will preserve margins.

-> sed = filename | sed 'N;s/\n/\t/'

-> awk '{print NR"\t"$0}' filename


# number each line of a file (number on left, right-aligned)

-> sed = filename | sed 'N; s/^/     /; s/ *\(.\{6,\}\)\n/\1  /'

-> awk '{printf "%6s  %s\n", NR,$0}' filename


# number each line of file, but only print numbers if line is not blank

-> sed '/./=' filename | sed '/./N; s/\n/ /'

-> awk '{print NF?NR" "$0:$0}' filename


# count lines (emulates "wc -l")

-> sed -n '$='

-> awk 'END{print NR}'


TEXT CONVERSION AND SUBSTITUTION:

# IN UNIX ENVIRONMENT: convert DOS newlines (CR/LF) to Unix format.

-> sed 's/.$//'               # assumes that all lines end with CR/LF

-> awk '{sub(/.$/,"",$0);print}'

-> sed 's/^M$//'              # in bash/tcsh, press Ctrl-V then Ctrl-M

-> awk '{sub(/^M$/,"",$0);print}'

-> sed 's/\x0D$//'            # works on ssed, gsed 3.02.80 or higher
-> gawk '{sub(/\x0D$/,"",$0);print}' 

# IN UNIX ENVIRONMENT: convert Unix newlines (LF) to DOS format.

-> sed "s/$/`echo -e \\\r`/"            # command line under ksh
-> sed 's/"/`echo \\\r`/"             # command line under bash
-> sed "s/$/`echo \\\r`/"               # command line under zsh
-> sed 's/$/\r/'                        # gsed 3.02.80 or higher
-> gawk '{sub(/$/,"\r",$0);print}'

# delete leading whitespace (spaces, tabs) from front of each line

# aligns all text flush left

-> sed 's/^[ \t]*//'                    # see note on '\t' at end of file

-> awk '{sub(/^[ \t]*/,"",$0);print}'


# delete trailing whitespace (spaces, tabs) from end of each line

-> sed 's/[ \t]*$//'                    # see note on '\t' at end of file

-> awk '{sub(/[ \t]*$/,"",$0);print}' 


# delete BOTH leading and trailing whitespace from each line

-> sed 's/^[ \t]*//;s/[ \t]*$//'

-> awk '{sub(/^[ \t]*/,"",$0);sub(/[ \t]*$/,"",$0);print}'


# insert 5 blank spaces at beginning of each line (make page offset)

-> sed 's/^/     /'

-> awk '{sub(/^/,"     ",$0);print}'


# align all text flush right on a 79-column width

-> sed -e :a -e 's/^.\{1,78\}$/ &/;ta'  # set at 78 plus 1 space

-> awk '{printf "%79s\n",$0}' 


# center all text in the middle of 79-column width. In method 1,

# spaces at the beginning of the line are significant, and trailing

# spaces are appended at the end of the line. In method 2, spaces at

# the beginning of the line are discarded in centering the line, and

# no trailing spaces appear at the end of lines.

-> sed  -e :a -e 's/^.\{1,77\}$/ & /;ta'                     # method 1
-> sed  -e :a -e 's/^.\{1,77\}$/ &/;ta' -e 's/\( *\)\1/\1/'  # method 2

-> awk '{t=(79-length)/2+length;printf "%"t"s%"79-t"s\n",$0," "}' #length=length($0)


# substitute (find and replace) "foo" with "bar" on each line

-> sed 's/foo/bar/'             # replaces only 1st instance in a line

-> awk '{sub(/foo/,"bar");print}'

-> sed 's/foo/bar/4'            # replaces only 4th instance in a line

-> gawk '{$0=gensub(/foo/,"bar",4,$0);print}' 

-> sed 's/foo/bar/g'            # replaces ALL instances in a line

-> awk '{gsub(/foo/,"bar");print}'

-> sed 's/\(.*\)foo\(.*foo\)/\1bar\2/' # replace the next-to-last case

-> gawk '{$0=gensub(/(.*)foo(.*foo)/,"\\1bar\\2","g",$0);print}'

-> sed 's/\(.*\)foo/\1bar/'            # replace only the last case

-> gawk '{$0=gensub(/(.*)foo/,"\\1bar","g",$0);print}'

# substitute "foo" with "bar" ONLY for lines which contain "baz"

-> sed '/baz/s/foo/bar/g'

-> awk '/baz/{gsub(/foo/,"bar")}1'


# substitute "foo" with "bar" EXCEPT for lines which contain "baz"

-> sed '/baz/!s/foo/bar/g'

-> awk '!/baz/{gsub(/foo/,"bar")}1'


# change "scarlet" or "ruby" or "puce" to "red"

-> sed 's/scarlet/red/g;s/ruby/red/g;s/puce/red/g'   # most seds

-> gsed 's/scarlet\|ruby\|puce/red/g'                # GNU sed only

-> gawk '{gsub(/scarlet|ruby|puce/,"red");print}' 

# reverse order of lines (emulates "tac")

# bug/feature in HHsed v1.5 causes blank lines to be deleted

-> sed '1!G;h;$!d'               # method 1
-> sed -n '1!G;h;$p'             # method 2

-> awk '{a[NR]=$0}END{i=NR;while(i>=1) print a[i--]}'


# reverse each character on the line (emulates "rev")

-> sed '/\n/!G;s/\(.\)\(.*\n\)/&\2\1/;//D;s/.//'

-> awk -vFS= '{i=NF;while(i>=1) printf $(i--);print ""}'


# join pairs of lines side-by-side (like "paste")

-> sed '$!N;s/\n/ /'

-> awk 'ORS=NR%2?FS:RS' or: awk '{getline line;print $0 FS line}'


# if a line ends with a backslash, append the next line to it

-> sed -e :a -e '/\\$/N; s/\\\n//; ta'

-> awk '/\\$/{sub(/\\$/,"");printf $0;next}1'


# if a line begins with an equal sign, append it to the previous line

# and replace the "=" with a single space

-> sed -e :a -e '$!N;s/\n=/ /;ta' -e 'P;D'

-> awk -vRS='\n=' -vORS=' ' '{print}'


# add commas to numeric strings, changing "1234567" to "1,234,567"

-> gsed ':a;s/\B[0-9]\{3\}\>/,&/;ta'                     # GNU sed
-> sed -e :a -e 's/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/;ta'  # other seds

-> awk -v FS=OFS= '{for(i=2;i<=NF;i++) $i=(NF-i+1)%3?$i:","$i}1'

  
# add commas to numbers with decimal points and minus signs (GNU sed)

-> gsed -r ':a;s/(^|[^0-9.])([0-9]+)([0-9]{3})/\1\2,\3/g;ta'

-> awk -v FS=OFS= '{for(i=$1=="-"?3:2;i<=NF;i++) if($i==".") break; else {$i=(NF-i+1)%3?$i:","$i}}1'


# add a blank line every 5 lines (after lines 5, 10, 15, 20, etc.)

-> gsed '0~5G'                  # GNU sed only
-> sed 'n;n;n;n;G;'             # other seds

-> awk '{$0=NR%5?$0:$0 ORS}1'


SELECTIVE PRINTING OF CERTAIN LINES:

# print first 10 lines of file (emulates behavior of "head")

-> sed 10q

-> awk 'NR==10{print;exit}1' or:awk '1;NR==10{exit}' (多谢Tim兄)


# print first line of file (emulates "head -1")

-> sed q

-> awk 'NR==1{print;exit}' or: awk '{print;exit}' (多谢Tim兄)


# print the last 10 lines of a file (emulates "tail")

-> sed -e :a -e '$q;N;11,$D;ba'

-> awk '{a[NR]=$0;delete a[NR-10]}END{for(i=NR-9;i<=NR;i++) print a[i]}'


# print the last 2 lines of a file (emulates "tail -2")

-> sed '$!N;$!D'

-> awk '{a=b;b=$0}END{print a ORS b}'


# print the last line of a file (emulates "tail -1")

-> sed '$!d'                    # method 1
-> sed -n '$p'                  # method 2

-> awk 'END{print $0}'


# print the next-to-the-last line of a file

-> sed -e '$!{h;d;}' -e x              # for 1-line files, print blank line

-> awk '{a=b;b=$0}END{print a}'

-> sed -e '1{$q;}' -e '$!{h;d;}' -e x  # for 1-line files, print the line

-> awk '{a=b;b=$0}END{print a?a:b}'

-> sed -e '1{$d;}' -e '$!{h;d;}' -e x  # for 1-line files, print nothing

-> awk '{a=b;b=$0}END{printf a?a ORS:""}'


# print only lines which match regular expression (emulates "grep")

-> sed -n '/regexp/p'           # method 1
-> sed '/regexp/!d'             # method 2

-> awk '/regxp/'


# print only lines which do NOT match regexp (emulates "grep -v")

-> sed -n '/regexp/!p'          # method 1, corresponds to above
-> sed '/regexp/d'              # method 2, simpler syntax

-> awk '!/regxp/'


# print the line immediately before a regexp, but not the line

# containing the regexp

-> sed -n '/regexp/{g;1!p;};h'

-> awk '{a=b;b=$0}/regexp/{print a}'


# print the line immediately after a regexp, but not the line

# containing the regexp

-> sed -n '/regexp/{n;p;}'

-> awk '/regexp/{getline line;print line}'


# print 1 line of context before and after regexp, with line number

# indicating where the regexp occurred (similar to "grep -A1 -B1")

-> sed -n -e '/regexp/{=;x;1!p;g;$!N;p;D;}' -e h

-> awk '{a=b;b=c;c=$0}b~/6/{printf "%s\n%s\n%s\n%s\n",NR-1,a,b,c}'


-> awk '{a=b;b=$0}/6/{getline c;print NR-1"\n"a"\n"b"\n"c}'


# grep for AAA and BBB and CCC (in any order)

-> sed '/AAA/!d; /BBB/!d; /CCC/!d'

-> awk '/AAA/&&/BBB/&&/CCC/'


# grep for AAA and BBB and CCC (in that order)

-> sed '/AAA.*BBB.*CCC/!d'

-> awk '/AAA.*BBB.*CCC/'


# grep for AAA or BBB or CCC (emulates "egrep")

-> sed -e '/AAA/b' -e '/BBB/b' -e '/CCC/b' -e d    # most seds
-> gsed '/AAA\|BBB\|CCC/!d'                        # GNU sed only

-> awk '/AAA|BBB|CCC/'


# print paragraph if it contains AAA (blank lines separate paragraphs)

# HHsed v1.5 must insert a 'G;' after 'x;' in the next 3 scripts below

-> sed -e '/./{H;$!d;}' -e 'x;/AAA/!d;'

-> awk -vRS='\n\n' '/AAA/'


# print paragraph if it contains AAA and BBB and CCC (in any order)

-> sed -e '/./{H;$!d;}' -e 'x;/AAA/!d;/BBB/!d;/CCC/!d'

-> awk -vRS='\n\n' '/AAA/&&/BBB/&&/CCC/'


# print paragraph if it contains AAA or BBB or CCC

-> sed -e '/./{H;$!d;}' -e 'x;/AAA/b' -e '/BBB/b' -e '/CCC/b' -e d
-> gsed '/./{H;$!d;};x;/AAA\|BBB\|CCC/b;d'         # GNU sed only

-> awk -vRS='\n\n' '/AAA|BBB|CCC/'


# print only lines of 65 characters or longer

-> sed -n '/^.\{65\}/p'

-> awk 'length>=65'


# print only lines of less than 65 characters

-> sed -n '/^.\{65\}/!p'        # method 1, corresponds to above
-> sed '/^.\{65\}/d'            # method 2, simpler syntax

-> awk 'length<65' or awk 'NF<65' FS=


# print section of file from regular expression to end of file

-> sed -n '/regexp/,$p'

-> awk '/regexp/,0' or awk '/regexp/,EOF'


# print section of file based on line numbers (lines 8-12, inclusive)

-> sed -n '8,12p'               # method 1
-> sed '8,12!d'                 # method 2

-> awk 'NR==8,NR==12' OR awk 'NR>=8&&NR<=12'


# print line number 52

-> sed -n '52p'                 # method 1
-> sed '52!d'                   # method 2
-> sed '52q;d'                  # method 3, efficient on large files

-> awk 'NR==52{print;exit}'


# beginning at line 3, print every 7th line

-> gsed -n '3~7p'               # GNU sed only
-> sed -n '3,${p;n;n;n;n;n;n;}' # other seds

-> awk 'NR>=3&&!((NR-3)%10)'


# print section of file between two regular expressions (inclusive)

-> sed -n '/Iowa/,/Montana/p'             # case sensitive

-> awk '/Iowa/,/Montana/'


SELECTIVE DELETION OF CERTAIN LINES:

# print all of file EXCEPT section between 2 regular expressions

-> sed '/Iowa/,/Montana/d'

-> awk 'Iowa/,Montana/{next}1'


# delete duplicate, consecutive lines from a file (emulates "uniq").

# First line in a set of duplicate lines is kept, rest are deleted.

-> sed '$!N; /^\(.*\)\n\1$/!P; D'

-> awk '{printf $0==v?"":$0 ORS;v=$0}' or: awk 'a !~ $0; {a=$0}'


# delete duplicate, nonconsecutive lines from a file. Beware not to

# overflow the buffer size of the hold space, or else use GNU sed.

-> sed -n 'G; s/\n/&&/; /^\([ -~]*\n\).*\n\1/d; s/\n//; h; P'

-> awk '!a[$0]++'


# delete all lines except duplicate lines (emulates "uniq -d").

-> sed '$!N; s/^\(.*\)\n\1$/\1/; t; D'

-> awk '!(a[$0]++-1)'


# delete the first 10 lines of a file

-> sed '1,10d'

-> awk '++p>10'


# delete the last line of a file

-> sed '$d'

-> awk '{a=b;b=$0}NR>1{print a}' OR: awk '{a[NR+1]=$0;if(NR>1)print a[NR]}'


# delete the last 2 lines of a file

-> sed 'N;$!P;$!D;$d'

-> awk '{a[NR+2]=$0;if(NR>2)print a[NR]}' OR: awk '{a=b;b=c;c=$0}NR>2{print a}'



# delete the last 10 lines of a file

-> sed -e :a -e '$d;N;2,10ba' -e 'P;D'   # method 1
-> sed -n -e :a -e '1,10!{P;N;D;};N;ba'  # method 2

-> awk '{a[NR+10]=$0;if(NR>10)print a[NR]}' 

（如果文件非常大，内存有限的话，加个delete，如下

-> awk '{a[NR+10]=$0;if(NR>10){print a[NR]
；delete a[NR]}}'）

# delete every 8th line

-> gsed '0~8d'                           # GNU sed only
-> sed 'n;n;n;n;n;n;n;d;'                # other seds

-> awk 'NR%8'


# delete lines matching pattern

-> sed '/pattern/d'

-> awk '/pattern/{next}1'



# delete ALL blank lines from a file (same as "grep '.' ")

-> sed '/^$/d'                           # method 1
-> sed '/./!d'                           # method 2

-> awk NF


# delete all CONSECUTIVE blank lines from file except the first; also

# deletes all blank lines from top and end of file (emulates "cat -s")

-> sed '/./,/^$/!d'          # method 1, allows 0 blanks at top, 1 at EOF

-> awk '{/^$/?p--:p=1}!p>=0'

-> sed '/^$/N;/\n$/D'        # method 2, allows 1 blank at top, 0 at EOF

-> awk -v p=1 '{/^$/?p--:p=1}!p>=0'


# delete all CONSECUTIVE blank lines from file except the first 2:

-> sed '/^$/N;/\n$/N;//D'

-> awk -v p=2 '{/^$/?p--:p=2}!p>=0'


# delete all leading blank lines at top of file

-> sed '/./,$!d'

-> awk '!/^$/{p=1}p' OR: awk '!/^$/,0'


# delete all trailing blank lines at end of file

-> sed -e :a -e '/^\n*$/{$d;N;ba' -e '}'  # works on all seds
-> sed -e :a -e '/^\n*$/N;/\n$/ba'        # ditto, except for gsed 3.02.*

-> awk -vRS='[\n]* '1'


# delete the last line of each paragraph

-> sed -n '/^$/{p;h;};/./{x;/./p;}'

-> awk '{a=b;b=$0}NR>1{printf /^$/?"":a ORS}'