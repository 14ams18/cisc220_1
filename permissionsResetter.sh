#!/bin/bash

if [[ $1=="-s" ]] ; then
	echo "Old \t Current \t File"
	for line in $2 ; do
		old=(awk '{print $1}' $line)
		file=(awk '{print $2}' $line)
		current=(ls -lh $file)
		if [[ $old!=$current ]] ; then
			echo "$old \t $current \t $file"
		fi
	done
elif [[ $1=="-r" ]] ; then
	for line in $2 ; do
        	old=(awk '{print $1}' $line)
                file=(awk '{print $2}' $line)
                current=(ls -lh $file)
                if [[ $old!=$current ]] ; then
			permission=0
			if [[ ${old:1:1}=='r' ]] ; then
				(($permissions+=400))
			fi
			if [[ ${old:2:1}=='r' ]] ; then
                                (($permissions+=200))
			fi
			if [[ ${old:3:1}=='r' ]] ; then
                                (($permissions+=100))
			fi
			if [[ ${old:4:1}=='r' ]] ; then
                                (($permissions+=40))
			fi
			if [[ ${old:5:1}=='r' ]] ; then
                                (($permissions+=20))
			fi
			if [[ ${old:6:1}=='r' ]] ; then
                                (($permissions+=10))
			fi
			if [[ ${old:7:1}=='r' ]] ; then
                                (($permissions+=4))
			fi
			if [[ ${old:8:1}=='r' ]] ; then
                                (($permissions+=2))
			fi
			if [[ ${old:9:1}=='r' ]] ; then
                                (($permissions+=1))
			fi
			chmod $permission $file
                        echo "$file permissions reset from $current to $old"
                fi
	done
fi
