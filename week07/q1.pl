#! /usr/bin/perl

use strict;
use warnings;

use DBI;
use Getopt::Long;

my $dbfile = "sequence.db";

my $dbh = DBI->connect( "DBI:SQLite:dbname=$dbfile" , "" , "" ,
                        { PrintError => 0 , RaiseError => 1 } )
  or die DBI->errstr;

my $organism = 0;
my $tissue = 0;

GetOptions(
  'organism|o'  => \$organism,
  'tissue|t'  => \$tissue,
) or die "Incorrect usage!\n";

if( $organism ) {
  my ($value) = @ARGV;
  my $sql = "
    SELECT gene.gene_name, organism.organism_name, gene.expression_level
    FROM gene
    LEFT JOIN organism ON gene.organism_id = organism.organism_id
    WHERE organism.organism_name = '$value'";
  my $sth = $dbh->prepare($sql)
    or die "Error\n";
  $sth->execute();
  my $r;
  my $ref = $sth->fetchall_arrayref;
  if (@{$ref} !=0) {
    print "Gene  Organism  Expression level\n";
    foreach $r (@{$ref}){
        print "@{$r}\n";}}
  elsif (@{$ref} ==0) {
    print "*NOT FOUND*\n";}
}

if( $tissue ) {
  my ($value) = @ARGV;
  my $str = join '', '%', $value, '%';
  my $sql = "
    SELECT gene.gene_name, organism.organism_name, gene.expression_level
    FROM gene
    LEFT JOIN organism ON gene.organism_id = organism.organism_id
    WHERE organism.tissue LIKE '$str'";
  my $sth = $dbh->prepare($sql)
    or die "Error\n";
  $sth->execute();
  my $r;
  my $ref = $sth->fetchall_arrayref;
  if (@{$ref} !=0) {
    print "Gene  Organism  Expression level\n";
    foreach $r (@{$ref}){
        print "@{$r}\n";}}
  elsif (@{$ref} ==0) {
    print "*NOT FOUND*\n";}
}

$dbh->disconnect;
