#! /bin/sh

cd my_project

for i in bin etc lib share tmp; do
	mkdir $i
done
