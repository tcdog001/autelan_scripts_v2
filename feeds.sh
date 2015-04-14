#!/bin/bash

if [ -z "${hisitopdir}" ]; then export hisitopdir=$(hisitopdir.sh $0); fi

. ${hisitopdir}/autelan_scripts/autelan.apps

download_app() {
	local app="$1"
	local name=$(get_app_name ${app})
	local type=$(get_app_type ${app})
	local url=$(get_app_url ${app})
	local tag=$(get_app_tag ${app})
	local rootfs=${hisitopdir}/rootfs
	local file

	if [ -d "${rootfs}/${name}" ]; then
		if [ -d "${rootfs}/${name}/.git" ]; then
			rm -fr ${rootfs}/${name}/.git
		fi

                return
        fi

	echo "${rootfs}/${name} not exist"

	pushd ${rootfs} &> /dev/null
	case ${type} in
	file)
		file=$(basename ${url})
		if [ ! -f "${file}" ]; then
			wget ${url}
	        fi

		case ${file} in
	        *.tar.gz)
	                tar zxvf ${file}
	                ;;
	        *.tar.bz2)
	                tar jxvf ${file}
	                ;;
	        *.tar.xz)
	                tar -Jxvf ${file}
	                ;;
	        *)
	                echo "unknow file"
	                exit 1
	                ;;
	        esac
		;;
	git)
		git clone ${url} ${name}
		pushd ${name} &> /dev/null
#		git checkout ${tag}
		rm -fr .git
		popd &> /dev/null
		;;
	*)
		echo "bad app type:${type}"
		exit 1
		;;
	esac
	popd &> /dev/null
}

apps_download() {
	local name

	for name in ${auteapps}; do
		download_app ${name}
	done
}

#
#$1:dir_src
#$2:dir_dst
#
apps_copy() {
        local dir_src=$1
        local dir_dst=$2
        local app
        local name

        for app in ${auteapps}; do
		name=$(get_app_name ${app})

                mkdir -p ${dir_dst}/{name}
                CP ${dir_src}/${name}/autelan* ${dir_dst}/${name}/
        done
}

apps_patch() {
	apps_copy ${autepackage} ${auterootfs}
}

apps_backup() {
	apps_copy ${auterootfs} ${autepackage}
}

usage() {
	echo "$0 download"
	echo "	download apps"
	echo "$0 patch"
	echo "	patch apps(package==>rootfs)"
	echo "$0 backup"
	echo "	backup apps(rootfs==>package)"
}

main() {
	local action="$1"

	case ${action} in
	download|patch|backup)
		apps_${action}
		;;
	*)
		usage
		;;
	esac
}

main "$@"
