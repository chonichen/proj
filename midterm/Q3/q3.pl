#! /usr/bin/perl

use strict;
use warnings;

print "Please select your scale (F/C): ";
my $scale = <STDIN>;
print "Please enter your number: ";
my $temp = <STDIN>;
my $stemp = 0;

if ($scale =~ /[Cc]/) {
  my $answer = c_to_f($temp);
  print "$answer in Fahrenheit\n"; }
  elsif ($scale =~ /[Ff]/) {
    my $answer = f_to_c($temp);
    print "$answer in Celsius\n"; }
else {
    print "Incorrect input\n";}

sub f_to_c {
  $stemp = ($temp -32)*0.5556;}

sub c_to_f {
  $stemp = $temp/0.5556+32;}
