#!/usr/bin/env bash

# SPDX-License-Identifier: MIT AND AGPL-3.0-only

getchar() {
	read -rN1 ch
	#echo -n "${BASH_LINENO[0]}: ${#ch}: |" >&2
	#echo -n "$ch" | xxd >&2
	[[ -z $ch ]] && exit
}

putchar() {
	echo -n "$ch"
}

# needs to be global, otherwise \n is treated as empty for some reason :(
ch=initial
while [[ -n $ch ]]; do
	getchar

	while [[ $ch == $'\r' ]]; do
		getchar
		[[ $ch != $'\n' ]] && putchar
	done

	if [[ $ch == $'\x1b' ]]; then
		getchar
		case "$ch" in
		"[")
			getchar
			while [[ $ch =~ ['0-9;?'] ]]; do
				getchar
			done
			;;
		"]")
			getchar
			if [[ $ch =~ [0-9] ]]; then
				while true; do
					getchar
					if [[ $ch == $'\x7' ]]; then
						break
					elif [[ $ch == $'\x1b' ]]; then
						getchar
						break
					fi
				done
			fi
			;;
		"%")
			getchar
			;;
		*) ;;
		esac
	else
		putchar
	fi
done
