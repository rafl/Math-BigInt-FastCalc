#!/usr/bin/perl -w

use lib 'blib/lib';
use lib 'blib/arch';

use Math::BigInt lib => shift;
use Benchmark;

print Math::BigInt->config()->{'lib'},"\n";

my $c = 'Math::BigInt';

my $x = $c->new("2");
my $n = $c->new(shift);

timethese ( -3,
  {
  bpow => sub { $x->copy()->bpow('$n'); }
  } );
