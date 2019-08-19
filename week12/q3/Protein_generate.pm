package Protein_generate;
  
use Moose;

has 'length' => (is => 'rw');

sub protein_generate {
  my $self = shift;
  my @chars = ('A', 'R', 'N', 'D', 'B', 'C', 'E', 'Q', 'Z', 'G', 'H', 'I', 'L', 'K', 'M', 'F', 'P', 'S', 'T', 'W', 'Y', 'V' );
  my $length = $self->length;
  my $sequence;
  if ($length =~ /^[\d]+/) {
    my $fixed_length = $length;
    foreach (1..$fixed_length) {
      $sequence.=$chars[rand @chars];
    }
    return $sequence;
  } elsif ($length =~ /[R|r]andom/) {
    my $random_length = int(rand(1000));
    foreach (1..$random_length) {
      $sequence.=$chars[rand @chars];
    }
    return $sequence;
  }
}

1;
