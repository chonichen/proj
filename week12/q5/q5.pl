#! /usr/bin/perl

use Bio::Perl;
use Bio::DB::GenBank;
use Bio::DB::SwissProt;
use Bio::Seq;
use Bio::SeqIO;
use Bio::Tools::Run::RemoteBlast;
use Bio::SearchIO;

my ($program, $data_type, $acc) = @ARGV;

if ($program eq 'blastn') {
  if ($data_type !~ /dna/) {
    print "Program and data type not match.\n";
    exit;
    }
} elsif ($program eq 'blastp') {
  if ($data_type !~ /protein/) {
    print "Program and data type not match.\n";
    exit;
    }
} elsif ($program eq 'blastx') {
  if ($data_type !~ /dna/) {
    print "Program and data type not match.\n";
    exit;
    }
} elsif ($program eq 'tblastn') {
  if ($data_type !~ /protein/) {
    print "Program and data type not match.\n";
    exit;
    }
} elsif ($program eq 'tblastx') {
  if ($data_type !~ /dna/) {
    print "Program and data type not match.\n";
    exit;
    }
}

my $db_obj = shift;
my $db;
if ($data_type eq 'protein') {
  $db_obj = Bio::DB::SwissProt->new;
  $db   = 'swissprot';
} elsif ($data_type eq 'dna') {
  $db_obj = Bio::DB::GenBank->new;
  $db = 'nr';
}

my $seq = $db_obj->get_Seq_by_acc($acc);
my $sequence = $seq->seq;
my $seq_obj = Bio::Seq->new(-seq=> $sequence,
                            -display_id => $acc);
write_sequence(">sequence.fasta", 'fasta', $seq_obj);

my $factory = Bio::Tools::Run::RemoteBlast->new( -prog => $program,
												 -data => $db,
												 -expect => '1e-10',
												 -readmethod => 'SearchIO');
my $str = Bio::SeqIO->new( -file => 'sequence.fasta',
                           -format => 'fasta');

print "Submitting BLASTs";
while( my $seq = $str->next_seq() ) {
  $factory->submit_blast($seq);
  print '.';
  sleep 5;
  }
print " Done\nPolling for results\n";
blast();

sub blast {
  while( my @rids = $factory->each_rid) {
  foreach my $rid (@rids) {
    my $result = $factory->retrieve_blast($rid);
    if (ref($result)) {
      my $output = $result->next_result();
      my $filename = $output->query_name().".$program";
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
