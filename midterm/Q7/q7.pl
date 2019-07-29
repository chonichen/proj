#! /usr/bin/perl

use strict;
use warnings;
use Data::Dumper qw(Dumper);

my @table = (
  [qw/ one two three/],
  [qw/ four five six/],
  [qw/seven eight nine/],);

my @transposed;
foreach my $j (0..$#{$table[0]}) {
  push(@transposed, [map $_->[$j], @table]);}

print "Input: ";
print_2d(\@table);
print "Output: ";
print_2d(\@transposed);

sub print_2d {
  my ($matrix) = @_;
  print "@$_\n" for @$matrix;}


