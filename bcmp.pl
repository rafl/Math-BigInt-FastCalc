#!/usr/bin/perl -w

use lib 'blib/lib';
use lib 'blib/arch';

#use lib '../Math-BigInt-1.61/lib';

use Math::BigInt lib => shift;
use Benchmark;

print Math::BigInt->config()->{'lib'}, " => v";
print Math::BigInt->config()->{'lib_version'},"\n";

my $c = 'Math::BigInt';

my $x = $c->new("2");
my $xsmall = $c->new("1234");
my $x2000 = $c->new('1' x 2000);
my $x8000 = $c->new('1' x 8000);
my $x4000 = $c->new('1' x 4000);
my $x1000 = $c->new('1' x 1000);
my $x100 = $c->new('1' x 100);

timethese ( -3,
  {
  bcmp_small => sub { $x->bcmp($xsmall); },
  bcmp_large => sub { $x->bcmp($x1000); },
  bcmp_100 => sub { $x100->bcmp($x100); },
  bcmp_1000 => sub { $x1000->bcmp($x1000); },
  bpow_2000 => sub { $x2000->bcmp($x2000); },
  bpow_4000 => sub { $x4000->bcmp($x4000); },
  bpow_8000 => sub { $x8000->bcmp($x8000); }
  } );
