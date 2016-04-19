echo "11111" | awk '{print $0=gensub("1","x",4)}'
111x1

echo "11111" | awk '{print $0=gensub("1","x","g")}'
xxxxx


echo "unix linux" | awk '{print gensub(/(.+) (.+)/,"\\2 \\1","g")}'
linux unix

echo "xaax xbx xxx:xaax xbx xxx" | awk -F: -vOFS=":" '{$2=gensub(/x([^x]+)x/,"\\1YY",2,$2)}1'
xaax xbx xxx:xaax bYY xxx


