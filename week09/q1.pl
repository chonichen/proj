#! /usr/bin/perl

use strict;
use warnings;

use Bio::Perl;

print "Enter your FASTA file: ";
my $filename = <STDIN>; 
my $file = join '', './', $filename;
# my $file = './data.fasta'
my @bio_seq_objects = read_all_sequences($file, 'fasta');

foreach my $seq (@bio_seq_objects) {
  my $name = $seq->desc;
  my $accession = $seq->display_id;
  my $sequence = $seq->seq;
  print "
Name: $name
Accession number: $accession
Sequence: $sequence
  ";
}

print "Enter accession numbers of sequences to blast, separated with a space: \n";
my $input = <STDIN>;
chomp($input);
#my $input = 'XP_641993.1';
my @accs;
if ($input =~ / /) {
  @accs = split / /, $input;}
else {
  @accs = $input;}

my @in_blast;
foreach my $seq (@bio_seq_objects) {
  my $accession = $seq->display_id;
  foreach my $acc (@accs) {
    if ($accession =~ /$acc/) {
      push @in_blast, $seq; }
  }
}

my $new_file = join '', './new_', $filename;
write_sequence( ">$new_file", 'fasta', @in_blast);

my @raw_seq = read_all_sequences($new_file, 'fasta');
my @pro_seq;
foreach my $seq (@raw_seq) {
  my $sequence = $seq->seq;
  if ($sequence =~ /^[A|T|C|G]+/) {
    my $pro_obj = $seq->translate;
    push @pro_seq, $pro_obj;}
  else {
    push @pro_seq, $sequence;}
}

my @blasts;
my $counter = 0;
foreach my $pro (@pro_seq) {
  $counter ++;
  my $blast = blast_sequence($pro);
  my $output_file = join '', './blast_output', $counter;
  write_blast(">$output_file", $blast);  
}

