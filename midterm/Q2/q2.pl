#! /usr/bin/perl

use strict;
use warnings;

my $value;

my %nucleotides = ('A'=>'Adenine', 'T'=>'Thymine', 'C'=>'Cytosine', 'G'=>'Guanine');
my $nucleotidesref = \%nucleotides;

%nucleotides = %$nucleotidesref;
$nucleotidesref = {'A'=>'Adenine', 'T'=>'Thymine', 'C'=>'Cytosine', 'G'=>'Guanine'};

function('A'); #Print out Adenine

sub function {
  $value = $_[0];
  print "$nucleotidesref->{$value}\n";}
