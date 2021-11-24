#!/bin/sh

cd /

for D in C D E G U V
do
    d=$(echo $D | tr A-Z a-z)
    while doas umount /mnt/$d 2> /dev/null
    do
        :
    done
    doas mkdir -p /mnt/$d
    doas mount -t drvfs $D: /mnt/$d
done
