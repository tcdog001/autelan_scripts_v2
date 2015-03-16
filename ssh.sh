#!/bin/bash

usage() {
	echo "$0 server user pass command"
}

#
#$1:server
#$2:user
#$3:pass
#$4:cmd
#
main() {
	local argc=$#
	local server="$1"
	local user="$2"
	local pass="$3"; shift 3
	local cmd="$*"

	if ((argc<4)); then
		usage

		return 1
	fi

	local err=0;
	sshpass -p ${pass} ssh -o StrictHostKeyChecking=no ${user}@${server} "${cmd}"; err=$?
	if [ "0" != "${err}" ]; then
		echo "ERROR[${err}]:${info}"
	fi

	return ${err}
}

main "$@"

