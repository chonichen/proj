#! /usr/bin/perl

To build a database of mRNA expression levels in different organisms, it would be better to separate data into 2 tables. 

Table Gene
Field name	Datatype	Notes
Gene ID		INT		Primary key
Organism ID	INT		Foreign key
Gene name	VARCHAR(255)	
Description 	TEXT
Gene sequence	TEXT
Expression level	INT
Start position	INT
Stop position	INT

Table Organism
Field name	Datatype	Notes
Organism ID	INT
Lineage		VARCHAR(255)
Organism name	VARCHAR(255)
Tissue 		VARCHAR(255)
