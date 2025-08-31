#!/bin/bash

generate_password() {
	local COUNT
	if [[ ${#} -ne 0 ]]; then
		COUNT=${1}
	else
		COUNT=20
	fi	
	LC_ALL=C tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' </dev/urandom | head -c ${COUNT}; echo
}

generate_weak_password() {
	local COUNT
	if [[ ${#} -ne 0 ]]; then
		COUNT=${1}
	else
		COUNT=20
	fi	
	LC_ALL=C tr -dc 'A-Za-z0-9' </dev/urandom | head -c ${COUNT}; echo
}

