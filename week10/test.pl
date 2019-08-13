#! /usr/bin/perl

use strict;
use warnings;

use Bio::Perl;
use Bio::DB::GenBank;
use Bio::DB::SwissProt;
use Bio::Seq;
use Bio::SeqIO;
use Bio::Tools::Run::RemoteBlast;
use Bio::SearchIO;

my $db_obj = shift;
my $prog;
my $db;
print "Select your database (Nucleotide/Protein): ";
my $choice = <STDIN>;
if ($choice =~ /[N|n]ucleotide/) {
  $db_obj = Bio::DB::GenBank->new;
  $prog = 'blastn';
  $db = 'nr';
} elsif ($choice =~ /[P|p]rotein/) {
  $db_obj = Bio::DB::SwissProt->new;
  $prog = 'blastp';
  $db   = 'swissprot';
} else {
  print "Invalid entry\n";
  exit;
}

print "Enter accession number: ";
my $acc = <STDIN>;
chomp($acc);

my $seq = $db_obj->get_Seq_by_acc($acc);
my $sequence = $seq->seq;
my $seq_obj = Bio::Seq->new(-seq=> $sequence,
                            -display_id => $acc);
write_sequence(">sequence.fasta", 'fasta', $seq_obj);

my $factory = Bio::Tools::Run::RemoteBlast->new( -prog => $prog,
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
print " done\n polling for results\n";
blast();

my $filename = join '.', $acc, "out";
my $in = Bio::SearchIO->new(-format => 'blast', -file => $filename);
my $result = $in->next_result;
my $hit    = $result->next_hit;
my $hit_name = $hit->name();
my $name;

if ($hit_name =~ /$acc/) {
  my $hsp = $result->next_hit();
  $name = $hsp->name();
} else {
  $name = $hit_name;
}

my ($blast_acc, $remain) = split(/\./, $name);
my $blast_seq = $db_obj->get_Seq_by_acc($blast_acc);
my $blast_id = $blast_seq->accession_number();
print "Accession number: $blast_id\n";
my $blast_name = $blast_seq->display_id();
print "Locus: $blast_name\n";
my $blast_alphabet = $blast_seq->alphabet();
print "Classification: $blast_alphabet\n";
my $blast_length = $blast_seq->length();
print "Length: $blast_length aa\n";
my $blast_species = $blast_seq->species->node_name;
print "Species: $blast_species\n";
my $blast_desc = $blast_seq->desc();
print "Description: $blast_desc\n";

my $blast_sequence = $blast_seq->seq;
my $blast_seq_obj = Bio::Seq->new(-seq=> $blast_sequence,
                         -display_id => $blast_acc);
write_sequence(">blast_sequence.fasta", 'fasta', $blast_seq_obj);
my $blast_str = Bio::SeqIO->new( -file => 'blast_sequence.fasta',
                           -format => 'fasta');

print "Submitting secondary BLASTs";
while( my $seq = $blast_str->next_seq() ) {
  $factory->submit_blast($seq);
  print '.';
  sleep 5;
  }
print " done\n polling for results\n";
blast();

my $sec_filename = join '.', $blast_acc, "out";
my $sec_in = Bio::SearchIO->new(-format => 'blast', -file => $sec_filename);
my $sec_result = $sec_in->next_result;
my $sec_hit    = $sec_result->next_hit;
my $sec_hit_name = $sec_hit->name();
my $sec_name;
if ($sec_hit_name =~ /$blast_acc/) {
  my $hsp = $result->next_hit();
  $sec_name = $hsp->name();
} else {
  $sec_name = $sec_hit_name;
}

if ($sec_hit_name =~ /$acc/) {
  print "The top hit for secondary BLAST is the same as the entered sequence.\n";
} else {
    print "The top hit for secondary BLAST is not the same as the entered sequence.\n";
}

my $first_fasta = 'sequence.fasta';
my $sec_fasta = 'blast_sequence.fasta';
unlink $filename, $sec_filename, $first_fasta, $sec_fasta;

# work with AY092024, XP_641993, NP_061874

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
