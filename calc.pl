#!/usr/bin/perl -w

use lib 'blib/lib';
use lib 'blib/arch';

use Math::BigInt lib => shift;

print Math::BigInt->config()->{'lib'},"\n";

my $c = 'Math::BigInt';

my $x = $c->new(123456);
my $t = $c->bone();

while ( ! $x->is_zero() )
  {
  $t += $c->bone() if $x->is_odd();
  $x->bdec();
  }
