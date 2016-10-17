#!/bin/bash

filename=savedPermissions

if [[ -e $filename ]] ; then
    i=1
    while [[ -e $filename-$i ]] ; do
        let i++
    done
    filename=$filename$i
fi

read -p "Type the names of the files you wish to store the permissions of separated by spaces. When you have finished hit return. Note the file must be inside your current directory, not hidden and case matters.   " -a fileArray

for file in ${fileArray[*]} ; do
	ls -lh $file | awk '{print $1 "\t" $9}' >> $filename
done

echo "$filename created!"
