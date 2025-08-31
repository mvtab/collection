#!/bin/bash

__prompt_command() {
	local RETURN_CODE="${?}"
	PS1=""

	# colors.
	local DARK_BLUE="\[$(tput setaf 24)\]"
	local GREEN="\[$(tput setaf 47)\]"
	local DARK_GREEN="\[$(tput setaf 64)\]"
	local RED="\[$(tput setaf 196)\]"
	local YELLOW="\[$(tput setaf 190)\]"
	local ORANGE="\[$(tput setaf 208)\]"
	local RESET="\[$(tput sgr0)\]"

	# title.
	PS1+="\[\e]2;\u@\h:\w\a\]"

	# user@host
	if [[ ${RETURN_CODE} != 0 ]]; then
		PS1+="${ORANGE}\u${RESET}@${ORANGE}\h${RESET}"
	else
		if [[ ${UID} -ne 0 ]]; then
			PS1+="${GREEN}\u${RESET}@${GREEN}\h${RESET}"
		else
			PS1+="${RED}\u${RESET}@${RED}\h${RESET}"
		fi
	fi

	# :pwd$
	PS1+=":${YELLOW}\w${RESET}"

	# python env.
	if [[ -n "${VIRTUAL_ENV_PROMPT}" ]]; then
		VIRTUAL_ENV_PROMPT=$(echo ${VIRTUAL_ENV_PROMPT} | tr -d '()')
		PS1+="(${DARK_GREEN}${VIRTUAL_ENV_PROMPT}${RESET}"
	fi

	# git branch.
	if [[ -n "$(git name-rev --name-only @ 2> /dev/null)" ]]; then
		if [[ -n "${VIRTUAL_ENV_PROMPT}" ]]; then
			PS1+="-"
		else
			PS1+="("
		fi
		PS1+="${DARK_BLUE}$(git name-rev --name-only @ 2> /dev/null)${RESET})"
	elif [[ -n "${VIRTUAL_ENV_PROMPT}" ]]; then
		PS1+=")"
	fi

	# $
	PS1+="\$ "

}

PROMPT_COMMAND=__prompt_command

