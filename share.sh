#!/bin/bash

md_install() {
	local src=../share
	local dst=../custom
	
	rm -fr ${dst}/etc/jsock/*
	rm -fr ${dst}/etc/utils/*
	rm -fr ${dst}/etc/xinetd.d/*
	rm -fr ${dst}/etc/upgrade/*

	cp -fpR ${src}/etc/* ${dst}/etc/
	cp -fpR ${src}/usr/sbin/* ${dst}/usr/sbin/

}

ap_install() {
	local src=../custom
	local dst=../ap_project/qsdk/package/autelan-shell/src/jsock/etc
 
	rm -fr ${dst}/jsock
	rm -fr ${dst}/utils
	rm -fr ${dst}/xinetd.d
	rm -fr ${dst}/stimer
	rm -fr ${dst}/fagent

	echo "copy files from ${src}/etc to ${dst}"
	cp -fpR ${src}/etc/jsock ${dst}
	cp -fpR ${src}/etc/utils ${dst}
	cp -fpR ${src}/etc/xinetd.d ${dst}
	#cp -fpR ${src}/etc/stimer ${dst}
	#cp -fpR ${src}/etc/fagent ${dst}
	#cp -fpR ${src}/usr/sbin/sysalarm ${dst}/../usr/sbin
}

main() {
	local action=$1

	case "${action}" in
	"md")
		#md_install
		;;
	"ap")
		ap_install
		;;
	*)
		echo "warning: olny support \"share.sh ap\" or \"share.sh md\"!"
		;;
	esac
}

main $@

