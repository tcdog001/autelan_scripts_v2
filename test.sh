#!/bin/bash


readonly -A app_xinetd=(
        [name]=xinetd
        [type]=git
        [url]=https://github.com/xinetd-org/xinetd
)

main() {
        local app="app_$1"; echo app=$app
        local name=$(eval "echo \${${app}[name]}"); echo name=$name
        local type=$(eval "echo \${${app}[type]}"); echo type=$type
        local url=$(eval "echo \${${app}[url]}");   echo url=$url
}

main xinetd 
