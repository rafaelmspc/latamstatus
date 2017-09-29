#!/usr/bin/env perl
use strict;
use warnings;
use Config::Simple;

my %CONFIG;

Config::Simple->import_from($ARGV[0], \%CONFIG);

while (each %CONFIG) {
    print "Value for $_  is $CONFIG{$_}\n";	
}

