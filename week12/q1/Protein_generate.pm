package Protein_generate;
use strict;
use warnings;

use Exporter 'import';
our @EXPORT_OK = ( "protein_generate");

my @chars = ('A', 'R', 'N', 'D', 'B', 'C', 'E', 'Q', 'Z', 'G', 'H', 'I', 'L', 'K', 'M', 'F', 'P', 'S', 'T', 'W', 'Y', 'V' );
my $answer;
my $fixed_length;
my $random_length;
my $sequence;

sub protein_generate {
  print "Enter fixed or random to create sequence: ";
  $answer = <STDIN>;
  if ($answer =~ /[F|f]ixed/) {
    fixed_generate();
  } elsif ($answer =~ /[R|r]andom/) {
    random_generate();
  } else {
    print "Not applicable\n";
  }
}

sub fixed_generate {
  print "Enter a number: ";
  $fixed_length = <STDIN>;
  foreach (1..$fixed_length) {
    $sequence.=$chars[rand @chars];
  }
  return $sequence;
}

sub random_generate {
  $random_length = int(rand(1000));
    foreach (1..$random_length) {
      $sequence.=$chars[rand @chars];
  }
  return $sequence;
}

1;
