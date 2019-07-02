#! /usr/bin/perl

use strict;
use warnings;

use CGI qw/ :standard /;

print header('text/html');

print <<"EndOfHTML";
<!DOCTYPE html>
<html>
        <head>
                <title>A DNA/Amino Acid Sequence Generator</title>
        </head>
        <body>
                <h1>DNA/Amino Acid Sequence Generator</h1?
                <form action="./simple_cgi.cgi" method="get">
                        <p>
                                DNA or Amino acid:
                                <input type="radio" name="type" value="DNA"/>DNA
                                <input type="radio" name="type" value="Amino acid"/>Amino
                        </p>

                        <p>
                                <input type="submit" name="submit" value="Submit"/>
                        </p>
                </form>
        </body>
</html>
EndOfHTML

my $type = param('type');

if (my $type =~ 'DNA') {
        my @DNA_chars=('A','T','C','G');
        my $random_sequence;
        foreach (1..50) {
                $random_sequence.=$DNA_chars[rand @DNA_chars];
        }
        return $random_sequence;
elsif (my $type =~ 'Amino') {
        my @AA_chars=('A','R','N','D','B','C','E','Q','Z','G','H','I','L','K','M','F','P','S','T','W','Y','V');
        foreach (1..50) {
                $random_sequence.=$AA_chars[rand @AA_chars];
        }
        return $random_sequence:
}
