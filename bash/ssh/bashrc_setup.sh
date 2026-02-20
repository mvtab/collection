#!/bin/bash

# .bashrc ssh sessions 

check_ssh_agent() {
	if ps aux | grep -v grep | grep ssh-agent 1> /dev/null; then
		return 0
	else
		return 1
	fi
}

ssh_shutdown() {
	for TEMP_AGENT_PID in $(ps aux | grep -v grep | grep ssh-agent | awk '{print $2}'); do
		eval "$(SSH_AGENT_PID=${TEMP_AGENT_PID} ssh-agent -k)"
	done
}

ssh_load_keys() {
	for SSH_KEY in "${SSH_KEYS_TO_LOAD[@]}"; do
		ssh-add "${HOME}/.ssh/${SSH_KEY}"
	done
}

ssh_startup() {
	eval "$(ssh-agent -s)" 1> /dev/null
}

ssh_startup_check() {
	read -p "Start SSH session?[y/N]: " -t 10 SHOULD_START_SSH_SESSION || echo
	case "${SHOULD_START_SSH_SESSION}" in
		y|Y|[yY][eE][sS] )
			if check_ssh_agent; then
				ssh_shutdown
			fi
			ssh_startup
			ssh_load_keys
			trap ssh_shutdown EXIT HUP PIPE TERM
			;;
		* )
			;;
	esac
}

export SSH_KEYS_TO_LOAD=("ssh-key-1" "ssh-key-2")
ssh_startup_check
