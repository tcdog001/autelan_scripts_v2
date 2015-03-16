#!/bin/bash

usage() {
	echo "$0 src dst user pass"
}

#
#$1:src
#$2:dst
#$3:user
#$4:pass
#$5:[rsync param...]
#
main() {
	local argc=$#
	local src="$1"
	local dst="$2"
	local user="$3"
	local pass="$4";shift 4
	local param="$*"

	if ((argc<4)); then
		usage

		return 1
	fi

	if [ -d "${src}" ]; then
		src=${src%/}/
	elif [ -f "${src}" ]; then
		src=${src%/}
	fi
	local info="${src} ==> ${dst}"
	local err=0;

	echo -e "${info}...\c"
	local sshparam="sshpass -p ${pass} ssh -l ${user} -o StrictHostKeyChecking=no"
	local rsyncparam="-acz --delete --force --stats --partial ${param}"
	rsync --rsh="${sshparam}" ${rsyncparam} ${src} ${dst}; err=$?
	if [ "0" != "${err}" ]; then
		echo "ERROR[${err}]:${info}"
	else
		echo "OK:${info}"
	fi
	echo

	return ${err}
}

main "$@"

