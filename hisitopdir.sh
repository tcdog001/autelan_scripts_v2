#!/bin/bash

main() {
        local file="$1"
        local dir=$(dirname ${file})

        case "${dir:0:1}" in
        ".")    
                echo $(pwd)/..
                ;;      
        "/")
                echo ${dir%/*}
                ;;
        *)
                exit 111
		;;
        esac
}

main "$@"
