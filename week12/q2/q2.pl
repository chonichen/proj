#! /usr/bin/perl

use strict;
use warnings;
use 5.010;

use DBI;

my $db_file = './gifts.db';

my $dbh = DBI->connect( "DBI:SQLite:dbname=$db_file" , "" , "" ,
                        { PrintError => 0 , RaiseError => 1 } )
  or die DBI->errstr;

my $person = <<'END_SQL';
CREATE TABLE friends (
  PersonID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  LastName VARCHAR(255),
  FirstName VARCHAR(255),
  Address VARCHAR(255),
  GiftsID INTEGER
)
END_SQL

$dbh->do($person);

my $gifts = <<'END_SQL';
CREATE TABLE gifts (
  GiftsID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  GiftsName VARCHAR(255),
  Retailers VARCHAR(255),
  Prices INTEGER
)
END_SQL

$dbh->do($gifts);

$dbh->disconnect;
