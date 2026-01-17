#!/bin/bash

generate_password() {
	local COUNT
	local REGEX_PATTERN

	[[ ($@ == "--help") ||  ($@ == "-h") ]] \
		&& echo "Usage: ${0} [COUNT] [REGEX_PATTERN]" && return 0
	[[ -n ${1} ]] && COUNT=${1} || COUNT=20
	shift
	[[ -n ${1} ]] && REGEX_PATTERN="${1}" || REGEX_PATTERN='[ -~]'

	cat /dev/urandom | tr -dc "${REGEX_PATTERN}" | head -c "${COUNT}"
}

generate_weak_password() {
	local COUNT
	[[ ${#} -eq 0 ]] && COUNT=20 || COUNT=${1}
	generate_password "${COUNT}" "a-zA-Z0-9"
}

generate_password -h

