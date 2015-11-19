#!/bin/bash

if [ -z "${hisitopdir}" ]; then
	export hisitopdir=$(hisitopdir.sh $0)
fi 


pull() {
	local dir="$1"

	if [[ -d ${dir} ]]; then
		pushd ${dir} &> /dev/null
		echo "pull ${dir}"
		git pull
		popd &> /dev/null
	fi
}

main() {
	local dir="$1"
	local list
	
	if [[ -n "${dir}" ]]; then
		pull ${hisitopdir}/${dir}
		return
	fi

	list="${hisitopdir}/../project_tools ${hisitopdir}/../project/project_tools"
	for dir in ${list}; do
		pull ${dir}
	done

	while read dir; do
		pull ${hisitopdir}/${dir}
	done < ${hisitopdir}/list.in
}

main "$@"
