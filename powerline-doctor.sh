#!/bin/bash

: ${DEBUG:=1}

debug() {
	[[ "$DEBUG" ]] && echo "[DEBUG] $@" 1>&2
}

backup() {
	local dir=~/.config/powerline_$(date +%Y%m%d_%H%M)

	debug backing up your powerline config to: $dir
	mv ~/.config/powerline $dir
	mkdir -p ~/.config/powerline
}

install_pwl() {
	local version=$1
	: ${version:? powerline git version is required}

	backup
	debug installing powerline version: $version

	pip install git+git://github.com/powerline/powerline@${version}
	# cp -r ~/.virtualenv/lib/python2.7/site-packages/powerline/config_files/* ~/.config/powerline/
}

check_virtualenv() {
	# debug "checking weather VIRTUAL_ENV variable is absolute url ..."

	if [[ "${VIRTUAL_ENV:0:1}" == "~" ]]; then
		cat <<-"EOF"
		========================================
		WARNING: please change your VIRTUAL_ENV
		it's safer to set is like:

		export VIRTUAL_ENV=$HOME/.virtualenv

		to make it permanent change your ~.profile or ~/.bash_profile
		========================================
		EOF
	fi
	for i in $(eval echo "$PATH|gsed \"s/:/\n/g\"")
	do
		if [[ "$i" =~ "~/.virtualenv" ]]; then
			cat <<-"EOF"
			========================================
			WARNING: "~/.virtualenv is represented on your path. Please remove it!"
			to make it permanent change your ~.profile or ~/.bash_profile
			========================================
			EOF
		fi
	done
}

get_config() {
	local version=$1
	: ${version:? powerline git version is required}

	git clone https://github.com/lalyos/powerline-config.git ~/.config/powerline
	cd ~/.config/powerline
	git checkout v${version}
}

main() {
  local ver
  ver=${1:-2.0}

  install_pwl $ver
  get_config $ver
  check_virtualenv
}

main
