#! /bin/sh

mkdir -p public_html public_html/html public_html/cgi

for file in ./project/html/*; do
	echo "Processing $file"
	cp "$file" ./public_html/html/
done

for file in ./project/cgi/*; do 
	echo "Processing $file"
	cp "$file" ./public_html/cgi/
done
