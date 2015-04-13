#!/bin/bash

if [ -z "${hisitopdir}" ]; then
	export hisitopdir=$(hisitopdir.sh $0)
fi 

main() {
	local dir

	while read dir; do
		pushd ${hisitopdir}/${dir} &> /dev/null
		echo "pull ${dir}"
		git pull
		popd &> /dev/null
	done < ${hisitopdir}/list.in
}

main "$@"
