#!/bin/sh

. echo.sh

current=$(mktemp)
default=$(mktemp)
trap -- "rm -f $current $default" EXIT INT KILL

vars=$(grep '^[^#]' /etc/portage/make.conf | sed 's/=.*//' | sort -u)

(
	. /etc/portage/make.conf

	for v in $vars
	do
		eval echo "\"$v=\\\"\$$v\\\"\""
	done
) > $current

for v in $vars
do
	doas sed -i "s/^$v=/#TEMP:$v=/" /etc/portage/make.conf
	echo "$v=\"$(portageq envvar $v)\""
	doas sed -i 's/^#TEMP://' /etc/portage/make.conf
done > $default

diff -u $default $current | sed -e s:$current:make.conf.current:g -e s:$default:make.conf.default:g
