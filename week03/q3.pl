#! /usr/bin/perl

use strict;
use warnings;

sub generate_DNA{
        my $length=$_[0];
        my @chars=('A','T','C','G');
        my $random_sequence;
        foreach (1..$length)
        {
                $random_sequence.=$chars[rand @chars];
        }
        return $random_sequence;
}

print generate_DNA(15);
print "\n"
