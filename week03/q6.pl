#! /usr/bin/perl

use strict;
use warnings;

print "Enter regexp: ";
my $regexp = <STDIN>;
chomp $regexp;

while (1) {
        print "Enter string or 'exit' to exit: ";
        my $string = <>;
        if ($string =~ $regexp)
        {
                print "Match!\n";
        }
        elsif ($string =~ 'exit')
        {
                print "bye bye!\n";
                last
        }
        else
        {
                print "No match!\n";
        }
}

