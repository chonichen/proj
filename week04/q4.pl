#! /usr/bin/perl

use strict;
use warnings;

use Test::Simple tests => 3;

use DNA_generate ('generate_DNA_1');

ok( length(generate_DNA_1(20)) == 20, "First method checks" );
ok( generate_DNA_1(20) =~ /^[ACGT]{20}$/i, "String composition checks");
ok( length(generate_DNA_1(20, "lf")) <= 70 || length(generate_DNA_1(20, "lf")) >= 50, "Second method checks");
