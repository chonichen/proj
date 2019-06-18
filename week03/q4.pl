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

sub generate_DNA_1{
	my @argv = @_;
	my $argc = scalar(@argv);
	my $length = $argv[0];
	if ($argc >1)
	{
		$length = int(rand($length));
	}
	return generate_DNA($length);
}

print generate_DNA_1(20, "lf");
print "\n"
