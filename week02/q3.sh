#! /bin/sh

for file in ./project/html/*; do
	if [ "$file" -nt ./public_html/html/${file##*/} ];
	then
		echo "Processing $file"
		cp "$file" ./public_html/html/
	else 
		echo "No need to copy"
	fi
done

for file in ./project/cgi/*; do 
	if [ "$file" -nt ./public_html/cgi/${file##*/} ];
	then
		echo "Processing $file"
		cp "$file" ./public_html/cgi/
	else
		echo "No need to copy"
	fi
done
