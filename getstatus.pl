#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;               # Perl core module
use Config::Simple;
use HTTP::Request;
use LWP::UserAgent;
use JSON qw( decode_json );
my %CONFIG;

Config::Simple->import_from($ARGV[0], \%CONFIG);

my $req = HTTP::Request->new('POST', $CONFIG{host});
$req->header('Content-Type' => 'application/json');
$req->content(<<EOF
{
   "jsonrpc": "2.0",
   "method": "host.get",
   "params": {
        "output": "extend"
    },
    "id": 2,
    "auth": "$CONFIG{auth}"
}
EOF
);

my $lwp = LWP::UserAgent->new;
my $res = $lwp->request($req);

$res->is_success or die $res->status_line. "\n";

my $content = $res->decoded_content;

my $parsed = decode_json($content);

my $result = $parsed->{result};

foreach my $host (@{$result}) {
    print $host->{host} . "\n";
}
