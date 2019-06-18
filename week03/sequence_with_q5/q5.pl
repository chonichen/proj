#! /usr/bin/perl

use strict;
use warnings;

my @files = <*>;
foreach my $file (@files) {
	open(my $fh, '<:encoding(UTF-8)', $file) or die("Can't open file '$file' $!");
	my $line = <$fh>;
	if ( $line =~ m/TTTT/ ) {
                print "T run found in ./".$file."\n";
        }
        if ( $line =~ m/AAAA/ ) {
                print "A run found in ./".$file."\n";
        }
        if ( $line =~ m/GGGG/ ) {
                print "G run found in ./".$file."\n";
        }
        if ( $line =~ m/CCCC/ ) {
                print "C run found in  ./".$file."\n";
        }
}

