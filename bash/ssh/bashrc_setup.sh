#!/bin/bash

# Example used in .bashrc. 
# Might work differently or not at all if used independently.

ssh_shutdown() {
    # pidof is usually in the procps package.
	for TEMP_AGENT_PID in $(pidof ssh-agent); do
		eval "$(SSH_AGENT_PID=${TEMP_AGENT_PID} ssh-agent -k)"
	done
}

ssh_load_keys() {
	for SSH_KEY in "${SSH_KEYS_TO_LOAD[@]}"; do
		ssh-add "${HOME}/.ssh/${SSH_KEY}"
	done
}

ssh_startup() {
	if ps aux | grep -v grep | grep ssh-agent 1> /dev/null; then
		ssh_shutdown
	fi
	eval "$(ssh-agent -s)" 1> /dev/null

    # Remove the next line if not used in .bashrc.
	trap ssh_shutdown EXIT HUP PIPE TERM
    
	read -p "Add SSH keys?[y/N]: " -t 10 SHOULD_LOAD_KEYS || echo
	case "${SHOULD_LOAD_KEYS}" in
		y|Y|[yY][eE][sS] )
			ssh_load_keys
			;;
		* )
			;;
	esac
}

export SSH_KEYS_TO_LOAD=("ssh-key-1" "ssh-key-2")
ssh_startup
