#! /bin/sh

export COPY_ALL=0	# Change to 1 to copy all files

for file in ./project/html/*; do
	if [ "$file" -nt ./public_html/html/${file##*/} ] || [ $COPY_ALL -eq 1 ]
	then
		echo "Processing $file"
		cp "$file" ./public_html/html/
	else 
		echo "No need to copy"
	fi
done

for file in ./project/cgi/*; do 
	if [ "$file" -nt ./public_html/cgi/${file##*/} ] || [ $COPY_ALL -eq 1 ]
	then
		echo "Processing $file"
		cp "$file" ./public_html/cgi/
	else
		echo "No need to copy"
	fi
done
