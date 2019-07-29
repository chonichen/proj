#! /usr/bin/perl

use strict;
use warnings;

print "Enter your sequence: ";
my $string = <STDIN>;

my $countcg = () = $string =~ /C|c|G|g/g;
my $countat = () = $string =~ /A|a|T|t/g;


my $annealtemp = temp();
print "The annealing temperature for this oligomer is: $annealtemp C\n";

my $gc = gccontent();
print "The GC content for this oligomer is: $gc\n";

sub temp {
  my $cgtemp = $countcg*4;
  my $attemp = $countat*2;
  $annealtemp = $cgtemp+$attemp;  }

sub gccontent {
  my $gccontent = $countcg / ($countcg+$countat); }


