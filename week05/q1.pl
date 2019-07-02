#! /usr/bin/perl

use strict;
use warnings;

my @first = (1, 2, 3);
my @second = (2, 4, 6);

print "Input == (@first) and (@second)\n";
print "Output == \n";

foreach my $i (@first) {
        my $str = "";
        foreach my $j (@second) {
                $str = $str.$i*$j;
                $str = $str." ";
        }
        print $str;
        print "\n";
}
