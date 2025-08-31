#!/bin/bash

generate_password() {
	local COUNT
	[[ ${#} -eq 0 ]] && COUNT=20 || COUNT=${1}
	LC_ALL=C tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' </dev/urandom | head -c "${COUNT}"; echo
}

generate_weak_password() {
	local COUNT
	[[ ${#} -eq 0 ]] && COUNT=20 || COUNT=${1}
	LC_ALL=C tr -dc 'A-Za-z0-9' </dev/urandom | head -c "${COUNT}"; echo
}

