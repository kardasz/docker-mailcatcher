#!/bin/bash
set -e

# first check if we're passing flags, if so
# prepend with mailcatcher
if [ "${1:0:1}" = '-' ]; then
	set -- mailcatcher "$@"
fi

exec "$@"