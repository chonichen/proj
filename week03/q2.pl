#! /usr/bin/perl

use strict;
use warnings;

sub mult_table{
        my $num = $_[0];
        my $i = 1;
        my $j = 1;
        my $str = "";
        for ($i=1; $i<=$num; $i++)
        {
                for ($j=1; $j<=$num; $j++)
                {
                        $str = $str.$i*$j;
                        $str = $str." ";
                }
                $str = $str."\n";
        }
        return $str;
}

print mult_table(5);
