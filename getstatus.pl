#!/usr/bin/env perl
use strict;
use warnings;
use Config::Simple;
use HTTP::Request;
use LWP::UserAgent;

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


if ($res->is_success) {
    print $res->decoded_content;
}
else {
    print STDERR $res->status_line, "\n";
}
