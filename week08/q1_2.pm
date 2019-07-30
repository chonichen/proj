package RestrictionEnzyme;

use Moose;

has 'name' => (is => 'rw');
has 'manufacturer' => (is => 'rw');
has 'rec_sites' => (is=>'rw', required =>1);
has 'sequence' => (is => 'rw');

sub cut_dna {
  my $self = shift;
  my $input = $self->sequence;
  my $rec_sites = $self->rec_sites;
  my $cut_sites = $rec_sites;
  $cut_sites =~ s/\^//g;
  my $output;
  my $frag;
  my @frags;
  if ($input =~ m/$cut_sites/) {
    @frags = split /$cut_sites/, $input;
    my ($part1, $part2) = split /\^/, $rec_sites, 2;
    my $first = shift @frags;
    my $last = pop @frags;
    my $first_part = join '', $first, $part1;
    print "$first_part\n";
    foreach $frag (@frags) {
      $_ = join '', $part2, $frag, $part1;
      print "$_\n"; }
    my $last_part = join '', $part2, $last;
    print "$last_part\n";
  } else {
    return "No cut site was found.\n";}
}


1;

=head1 RestrictionEnzyme
RestrictionEnzyme: This is a package function with moose that allow you to enter specific restriction enzyme and a sequence to see if there will be a cut or not.

=head1 Synopsis
#! /usr/bin/perl

use strict;
use warnings;
use RestrictionEnzyme;

my $sequence = RestrictionEnzyme->new(
  name => 'EcoRI',
  manufactuer => 'New England BioLabs',      
  rec_sites => 'G^AATTC',
  sequence => 'GCGAATTCGATTATATCGCGAATTCTTAATGGCTCTTGGGCCGAATTCGCGGTGCGTTACCTTGCAGG');
          
          print $sequence->cut_dna();

