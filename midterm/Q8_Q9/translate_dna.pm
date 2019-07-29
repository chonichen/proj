package translate_dna;

use strict;
use warnings;

use Exporter 'import';
our @EXPORT_OK = ("translate_dna");

my $dna;
my $rna;
my $coding;
my $uncutprotein;
my (%aminoacid) = ( UUU => 'F', UUC => 'F', UUA => 'L', UUG => 'L',
CUU => 'L', CUC => 'L', CUA => 'L', CUG => 'L',
AUU => 'I', AUC => 'I', AUA => 'I', AUG => 'M',
GUU => 'V', GUC => 'V', GUA => 'V', GUG => 'V',
UCU => 'S', UCC => 'S', UCA => 'S', UCG => 'S',
CCU => 'P', CCC => 'P', CCA => 'P', CCG => 'P',
ACU => 'T', ACC => 'T', ACA => 'T', ACG => 'T',
GCU => 'A', GCC => 'A', GCA => 'A', GCG => 'A',
UAU => 'Y', UAC => 'Y', UAA => 'Stop', UAG => 'Stop',
CAU => 'H', CAC => 'H', CAA => 'Q', CAG => 'Q',
AAU => 'N', AAC => 'N', AAA => 'K', AAG => 'K',
GAU => 'D', GAC => 'D', GAA => 'E', GAG => 'E',
UGU => 'C', UGC => 'C', UGA => 'Stop', UGG => 'W',
CGU => 'R', CGC => 'R', CGA => 'R', CGG => 'R',
AGU => 'S', AGC => 'S', AGA => 'R', AGG => 'R',
GGU => 'G', GGC => 'G', GGA => 'G', GGG => 'G' );

sub translate_dna {
  my $dna = $_[0];
  test1($dna);
  my $rna = $dna;
  $rna =~ tr/AaTtCcGg/AAUUCCGG/;
  my $coding = "";
  test2($rna);
  my ($part1, $part2) = split /AUG/, $rna, 2;
  $coding = join '', 'AUG', $part2;
  my $codon = 0;
  my $uncutprotein = "";
  for (my $i=0; $i<(length($coding)-2); $i+=3) {
    $codon=substr($coding,$i,3);
    $uncutprotein .= translate_aa($codon);}
  test3($uncutprotein);
  my ($protein, $part3) = split /Stop/, $uncutprotein, 2;
  print "\n$protein\n";}

sub test1 {
  $dna = $_[0];
  if ($dna =~ /[QqWwEeRrYyUuIiOoPpSsDdFfHhJjKkLlZzXxVvBbNnMm]/) {
  print "\nNot a nucleotide\n";
  exit;}
}

sub test2 {
  $rna = $_[0];
  if ($rna =~ m/AUG/) {
    print "The start codon is AUG\n";}
  else {
    print "No starting codon found\n";
    exit;}
}

sub translate_aa {
  my ($codon)=@_;
  if (exists $aminoacid{$codon}) {
    return $aminoacid{$codon}; }
}

sub test3 {
  $uncutprotein = $_[0];
  if ($uncutprotein =~ /Stop/) {
    print "A stop codon is found \n";}
  else {
    print "No stop codon found\n";
    exit;}
}

