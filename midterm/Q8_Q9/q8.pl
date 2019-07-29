#! /usr/bin/perl

use strict;
use warnings;

use translate_dna('translate_dna');

print "Enter your DNA sequence: ";
my $dna = <STDIN>;

print translate_dna($dna);
print "\n";


