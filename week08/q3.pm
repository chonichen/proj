
package RestrictionEnzyme;

use strict;
use warnings;

my %_attributes = (
  _name => shift,
  _manu => shift,
  _cut1 => shift, #first part of the recognition cut sequence
  _cut2 => shift, #second part of the recognition cut sequence
  );
  
sub new {
  my ($class, %_attributes) = @_;
  my $self = \%_attributes;
  bless $self, $class;
  return $self;
}

sub cut_dna {
  my ($self, $rest) = @_;
  my $rec = "$self->{_cut1}$self->{_cut2}";
  while ($rest =~ /$rec/) {
    print "$`$self->{_cut1}\n";
    $rest = "$self->{_cut2}$'";
    }
  print "$rest\n";
}

=head1 Synopsis
$object = RestrictionEnzyme->new("EcoRI", "New England BioLabs", "G", "AATTC");

$object->cut_dna("ATTATATCGCGAATTCTTAATGGCTCTTGGGCCG");
