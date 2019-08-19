#! /usr/bin/perl

use strict;
use warnings;
use Bio::SeqIO;

my ($infile, $out_format) = @ARGV;
my ($part1, $part2) = split(/\.\//, $infile);
my ($in_name, $in_suffix) = split(/\./, $part2);
my $outfile = join '', $in_name, '.', $out_format;
my $in_format;

if ($in_suffix =~ /(fasta|fast|seq|fa|fsa|nt|aa)/) {
  $in_format = 'fasta';
} elsif ($in_suffix =~ /(gb|gbank|genbank)/) {
  $in_format = 'genbank';
} elsif ($in_suffix =~ /(embl|ebl|emb|dat)/) {
  $in_format = 'embl';
} elsif ($in_suffix =~ /(bsm|bsml)/) {
  $in_format = 'bsml';
} elsif ($in_suffix =~ /(swiss|sp)/) {
  $in_format = 'swiss';
} elsif ($in_suffix =~ /(phd|phred)/) {
  $in_format = 'phd';
} else {
  print "The format does not exist.\n";
  exit;
}

my $in_seq = Bio::SeqIO->new(-file => "$part2",
                             -format => "$in_format");
my $out_seq = Bio::SeqIO->new(-file => ">$outfile",
                             -format => "$out_format");

while (my $seq = $in_seq->next_seq) {
  $out_seq->write_seq($seq);
}

