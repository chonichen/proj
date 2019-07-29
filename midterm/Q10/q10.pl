#! /usr/bin/perl


use strict;
use warnings;
use CGI (':standard');

my $title = 'Midterm Q10: Database search';
print header,
  start_html($title),
  h1($title);
  
if (param('submit')) {
  my $choice = param('choice');
  my $results;
  if ($choice eq "Organism") {}
  elsif ($choice eq "Tissue") {}
  print [("$results\n");
}

my $url = url();
print start_form( -method => 'GET', action => $url),
  p("Search in organism or tissue?:" . radio_group ( -name => 'choice',
  													-values => ['Organism', 'Tissue'])),
  p( "Search for?:". text ( -name => 'Name',
  								-values => [$string])),
  p( submit(-name => 'submit', value => 'Submit')),
  end_form(),
  end_html();
  
sub organism_search {
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
  
sub tissue_search {
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

<!DOCTYPE html>
 <html>
  <head>
    <title>Bioperl Midterm: sequence database search</title>
  </head>
  <body>
    <h1> Organism or Tissue?</h1>
    <form action="./q10.cgi" method="get">
     
     <p>
       Search in organism or tissue?:
       <input type="radio" name="choice" value="Organism"/>Organism
       <input type="radio" name="choice" value="Tissue"/>Tissue
     </p>

     <p>
       Search for?:
       <input type="text" name="Name" size="50"/>
     </p>

     <p>
       <input type="submit" name="submit" value="Submit"/>
     </p>
    </form>
  </body>
 </html>
