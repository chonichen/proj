#! /usr/bin/perl

use strict;
use warnings;

for($i=1; $i<=12; $i++)
{
        for($j=1; $j<=12; $j++)
        {
                $ans = $i*$j;
                print "$ans\t";
        }
        print "\n\n";
}

