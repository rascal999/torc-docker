#!/bin/bash
## Process arguments

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Should we update git repos?
repo_update=1

function show_help {
    echo "$0 [-h|-n]"
    echo "-n No update. Don't update git repos before executing environment"
    echo "-h Show help."
    echo
    exit 1
}

while getopts "hn" opt; do
    case "$opt" in
    h)  show_help
        ;;
    n)  repo_update=0
        ;;
    esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

## Update repos
if [[ $repo_update == 1 ]]; then
    echo "Updating environment.. (\"torc.sh -n\" if you don't want this)"
    git -C /root/git/torc pull https://github.com/rascal999/torc
    git -C /root/git/torc-web pull https://github.com/rascal999/torc-web
    git -C /root/git/torc-tools pull https://github.com/rascal999/torc-tools
    git -C /root/git/torc-docker pull https://github.com/rascal999/torc-docker
    echo
    echo "#################"
    echo "Finished updating"
    echo "#################"
    echo
    sleep 1
fi

# Soft link
ln -s /root/git/torc-tools/tools/ /root/tools

# Locale hack for docker instance
LANG="en_GB.UTF-8"
export LANG

# run API
torc &

sleep 2

# run website
torc-web
