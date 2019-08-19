#! /usr/bin/perl

use strict;
use warnings;
use Protein_generate;

my $sequence = Protein_generate->new(
  length => 'Random');

print $sequence->protein_generate();
print "\n";

#my $sequence = Protein_generate->new(
##  length => '35');
#
##print $sequence->protein_generate();
##print "\n";
##RKGFVDFYWITSPEIBIQFNRBQGSBRVSCSSYEF
