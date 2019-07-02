#! /usr/bin/perl

use strict;
use warnings;

use Storable;
my @data = (
        generate_DNA(50),
        generate_DNA(50),
        generate_DNA(50),
        generate_DNA(50),
        generate_DNA(50),
        generate_DNA(50),
        generate_DNA(50),
        generate_DNA(50),
        generate_DNA(50),
        generate_DNA(50)
        );

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

store \@data , 'DNA';
