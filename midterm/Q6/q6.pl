#! /usr/bin/perl

use strict;
use warnings;

my @numbers = (13, 41, 59, 9, 96, 95, 61, 19, 77, 1);
my $num;

my $max = max();
my $min = min();
print "$max\n";
print "$min\n";

sub max {
  my $max = $numbers[0];
  foreach my $num (@numbers) {
    $max = $num if $max < $num; }
  return $max;}

sub min {
  my $min = $numbers[0];
  foreach my $num (@numbers) {
    $min = $num if $min > $num; }
  return $min;}


