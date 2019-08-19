#! /usr/bin/perl

use Bio::Perl;
use Bio::DB::SwissProt;
use Bio::Seq;
use Bio::SeqIO;
use Bio::Tools::Run::RemoteBlast;
use Bio::SearchIO;

my ($acc, $eval) = @ARGV;
my $db_obj = Bio::DB::SwissProt->new;
my $seq = $db_obj->get_Seq_by_acc($acc);
my $sequence = $seq->seq;
my $seq_obj = Bio::Seq->new(-seq=> $sequence,
                            -display_id => $acc);
write_sequence(">sequence.fasta", 'fasta', $seq_obj);

my $factory = Bio::Tools::Run::RemoteBlast->new( -prog => 'blastp',
												 -data => 'nr',
												 -expect => $eval,
												 -readmethod => 'SearchIO');
my $str = Bio::SeqIO->new( -file => 'sequence.fasta',
                           -format => 'fasta');

print "Submitting BLASTs";
while( my $seq = $str->next_seq() ) {
  $factory->submit_blast($seq);
  print '.';
  sleep 5;
  }
print " done\n polling for results\n";
blast();

my $filename = join '.', $acc, "out";
my $in = Bio::SearchIO->new(-format => 'blast', -file => $filename);
my $result = $in->next_result;
print_blast_results($result);


sub blast {
  while( my @rids = $factory->each_rid) {
  foreach my $rid (@rids) {
    my $result = $factory->retrieve_blast($rid);
    if (ref($result)) {
      my $output = $result->next_result();
      my $filename = $output->query_name().".out";
      $factory->save_output($filename);
      $factory->remove_rid($rid);
      print "\n \tGot ",$output->query_name(), "\n";
      } elsif ($result < 0) {
        $factory->remove_rid($rid);
    } else {
      print ".";
      sleep 5;
      }
    }
}}

sub print_blast_results {
  my $result = shift;
  while ( my $hit = $result->next_hit() ) {
    while( my $hsp = $hit->next_hsp() ) {
      my $blast_name = $hit->name;
      my ($blast_acc, $part3) = split (/\./, $blast_name);
      my $blast_seq = $db_obj->get_Seq_by_acc($blast_acc);
      my $blast_sequence = $blast_seq->seq;
      my $blast_seq_obj = Bio::Seq->new(-seq=> $blast_sequence,
      					-display_id => $blast_acc);
      my $out_file = join '', $blast_acc, '.MatchedResults';
      write_sequence(">$out_file", 'fasta', $blast_seq_obj);        
    }
  }
}
