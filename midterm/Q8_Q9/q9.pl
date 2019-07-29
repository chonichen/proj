#! /usr/bin/perl

use strict;
use warnings;

use Test::Simple tests => 5;

use translate_dna('translate_dna');

ok( translate_dna("ATGCAGTATAGTGCGCTGATTATGTGATAA") !~ /nuc/, "Nucleotide sequence checks");
print "\n";
ok( translate_dna("ATGCAGTATAGTGCGCTGATTATGTGATAA") !~ /starting/, "Start codon checks");
print "\n";
ok( translate_dna("ATGCAGTATAGTGCGCTGATTATGTGATAA") !~ /codon found/, "Stop codon found");
print "\n";
ok( translate_dna("ATGCAGTATAGTGCGCTGATTATGTGATAA") !~ /[ZXBJUO]/, "Amino acid chart check");
print "\n";
ok(translate_dna("ATGCAGTATAGTGCGCTGATTATGTGATAA") !~ /[WERTPDFGHKCVN]/, "Amino acid conversion check");
