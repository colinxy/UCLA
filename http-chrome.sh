#!/bin/sh

if [ -z "$1" ]
then
    echo "Usage: $0 <hostname>"
    exit 1
fi

cat | nc "$1" 80 <<EOF
GET / HTTP/1.1
Host: $1
Connection: keep-alive
Cache-Control: max-age=0
User-Agent: Mozilla/5.0 AppleWebKit/537 Chrome/50 Safari/537
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
EOF

# get rid of Accept-Encoding which contains compressed format gzip
