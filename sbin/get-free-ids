#!/bin/sh

t=$(mktemp -d)
trap -- "rm -fr '$t'" EXIT INT KILL

curl -Lfks -o $t/list https://api.gentoo.org/uid-gid.txt

seq 101 499 > $t/ref

grep '^[^#]' < $t/list \
| sed -E 's/\t+/\t/g' \
| cut -f 2 \
| grep -Fv -e - -e .. \
| sort -nu \
> $t/uids

grep '^[^#]' < $t/list \
| sed -E 's/\t+/\t/g' \
| cut -f 3 \
| grep -Fv -e - -e .. \
| sort -nu \
> $t/gids

for i in uids gids
do
	diff $t/ref $t/$i \
	| sed -n 's/^< //p' \
	> $t/free-$i
done

echo Last free UID: $(tail -n 1 < $t/free-uids)
echo Last free GID: $(tail -n 1 < $t/free-gids)
echo Last free UID/GID pair: $(comm -12 $t/free-uids $t/free-gids | tail -n 1)
