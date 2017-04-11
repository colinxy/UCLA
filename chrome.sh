#!/bin/sh

help=$(cat <<EOF
Usage: ${0##*/} [-hvsk] [-p PATH] [-m MATHDO] DOMAIN/IP
Make http requests as if you were chrome. Requires 'ncat' from nmap package.
    -h         show this help
    -v         be verbose (show the request sent)
    -p PATH    specify path name, default /
    -m METHOD  specify http method, default GET
    -s         secure, use https
    -k         maintain http connection
EOF
)


verbose=0
path=/
method=GET
secure=0
keepalive=0

while getopts hvp:m:sk opt; do
    case $opt in
        h) echo "$help"; exit 0;;
        v) verbose=1;;
        p) path=$OPTARG;;
        m) method=$OPTARG;;
        s) secure=1;;
        k) keepalive=1;;
        *) echo "$help" >&2; exit 1;;
    esac
done
shift "$((OPTIND-1))"

if [ -z "$1" ]
then
    echo "$help" >&2
    exit 1
fi
host="$1"

# echo "$host" $verbose $keepalive

# a bash way of doing this would be $'\r', but we want to be posix compliant
# CR=$(printf '\r')
request=$(cat <<EOF
$method $path HTTP/1.1
Host: $host
Connection: keep-alive
Cache-Control: max-age=0
User-Agent: Mozilla/5.0 AppleWebKit/537 Chrome/50 Safari/537
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
EOF
)

[ "$verbose" = 1 ] && echo "$request" && echo

{
    echo "$request"
    echo
    [ "$keepalive" = 1 ] && cat /dev/stdin
} | {
    if [ $secure = 1 ]; then
        ncat --ssl "$host" 443
    else
        ncat "$host" 80
    fi
}
