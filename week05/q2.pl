#! /usr/bin/perl

use strict;
use warnings;

use Storable;
my @dataref = retrieve('DNA');

use Data::Dumper;
print Dumper @dataref;

foreach my $i (@dataref) {
        foreach my $base ( qw/ A C G T /) {
                if ($i =~ /$base{4}/) {
                        print "$base run found in $i\n";
                }
        }
}
