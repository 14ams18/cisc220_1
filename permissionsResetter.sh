#!/bin/bash

if [[ "$1" == "-s" ]] ; then
	echo $'Old \t\t Current \t File'
	IFS=$'\n'
	set -f
	for line in $(cat "$2") ; do
		old=${line:0:10}
		file=${line:11}
		current=$(ls -lh $file | awk '{print $1}')
		if [[ "$old" != "$current" ]] ; then
			echo -e "$old \t $current \t $file"
		fi
	done
elif [[ "$1" == "-r" ]] ; then
	IFS=$'\n'
        set -f
	for line in $(cat "$2") ; do
        	old=${line:0:10}
                file=${line:11}
                current=$(ls -lh $file | awk '{print $1}')
                if [[ "$old" != "$current" ]] ; then
			permission=0
			if [[ "${old:1:1}" == "r" ]] ; then
				permission=$(($permission+400))
			fi
			if [[ "${old:2:1}" == "w" ]] ; then
                                permission=$(($permission+200))
			fi
			if [[ "${old:3:1}" == "x" ]] ; then
                                permission=$(($permission+100))
			fi
			if [[ "${old:4:1}" == "r" ]] ; then
                                permission=$(($permission+40))
			fi
			if [[ "${old:5:1}" == "w" ]] ; then
                                permission=$(($permission+20))
			fi
			if [[ "${old:6:1}" == "x" ]] ; then
                                permission=$(($permission+10))
			fi
			if [[ "${old:7:1}" == "r" ]] ; then
                                permission=$(($permission+4))
			fi
			if [[ "${old:8:1}" == "w" ]] ; then
                                permission=$(($permission+2))
			fi
			if [[ "${old:9:1}" == "x" ]] ; then
                               permission=$(($permission+1))
			fi
			chmod $permission $file
                        echo "$file permissions reset from $current to $old"
                fi
	done
fi

