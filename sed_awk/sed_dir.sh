sed取目录（dirname功能）sed -r 's#(/[^/]+)/[^/]+/?$#\1#g'
sed取尾部（basename功能）sed -r 's#/.*/([^/]+)/?$#\1#g'