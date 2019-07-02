package DNA_generate;

use strict;
use warnings;

use Exporter 'import';
our @EXPORT_OK = ( "generate_DNA_1" );

sub generate_DNA {
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
                $length = int(rand($length)+50);
        }
        return generate_DNA($length);
}

=pod

=head1 NAME
DNA_generate - DNA generator
=head1 SYNOPSIS
A module that create random DNA sequences.
=head1 DESCRIPTION
This module can be used to produce random DNA sequences and the nucleotide
number is given by the user. The number could vary if there is an additional
argument that was given.
=head2 METHODS1
Put one number in between the parentheses, script with this module will
generate a random DNA sequences of the given length. For example,
generate_DNA_1(20) will generate a DNA sequence that is 20 nucleotides long.
=head2 METHODS2
Put a second argument in between the parentheses, script with this module will
produce a sequence of a random length between 1 and the first argument. An
additional 50 nucleotides is added to the sequences to prevent the script from
generating DNA sequences that are too short to use. For example,
generate_DNA_1(20, "lf") will generate a DNA sequence that is 50 plus a
random number between 1 and 20 nucleotides long.

=cut
