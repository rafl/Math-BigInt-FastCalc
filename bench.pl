#!/usr/bin/perl -w

use lib 'lib';
use lib 'blib/arch';

use Math::BigInt::Calc;
#use Math::BigInt lib => 'FastCalc';
use Math::BigInt::FastCalc; use Math::BigInt;
use Math::BigFloat;
#use Math::BigRat;
#use Math::BigInt::Pari;
#use Math::BigInt::GMP;
#use Math::BigInt::Lite;
use Benchmark;

print Math::BigInt->config()->{lib}, " => v",
      Math::BigInt->config()->{lib_version},"\n";
my $xi = Math::BigInt->new(123);
my $xf = Math::BigFloat->new(123);
#my $xr = Math::BigRat->new(123);
#my $xl = Math::BigInt::Lite->new(123);
#my $xp = Math::BigInt::GMP->new(123);
#my $xg = Math::BigInt::Pari->new(123);

my $c = 'Math::BigInt';

my $array = [123];

timethese ( -3,
  {
  #mbiodd => sub { $xi->is_odd(); },
#  mbizero => sub { $xi->is_zero(); },
#  mbione => sub { $xi->is_one(); },
  mbi_len => sub { $xi->length(); },
#  mbi_zero => sub { $c->bzero(); },
#  mbi_one => sub { $c->bone(); },
#  mbf => sub { $xf->is_odd(); },
#  lite => sub { $xl->is_odd(); },
#  rat => sub { $xr->is_odd(); },
#  gmp => sub { $xg->is_odd(); },
#  pari => sub { $xp->is_odd(); },
#  calc_zero => sub { Math::BigInt::Calc->_zero(); },
#  calc_one => sub { Math::BigInt::Calc->_one(); },
#  calc_two => sub { Math::BigInt::Calc->_two(); },
#  calcodd => sub { Math::BigInt::Calc->_is_odd([123]); },
#  calcone => sub { Math::BigInt::Calc->_is_one([123]); },
#  calczero => sub { Math::BigInt::Calc->_is_zero([123]); },
  calc_len => sub { Math::BigInt::Calc->_len([123,123,123]); },
#  xsfaster => sub { Math::BigInt::FastCalc::is_odd(123); },
#  xsfast => sub { Math::BigInt::FastCalc->_is_odd([123]); },
#  xsfast2 => sub { Math::BigInt::FastCalc->_is_odd2([123]); },
#  xsnick => sub { Math::BigInt::FastCalc->_is_odd([123]); },
#  xsodd => sub { Math::BigInt::FastCalc->_is_odd([123]); },
# xsone => sub { Math::BigInt::FastCalc->_is_one([123]); },
# xszero => sub { Math::BigInt::FastCalc->_is_zero([123]); },
# xsone2 => sub { Math::BigInt::FastCalc->_is_one([123,123]); },
# xszero2 => sub { Math::BigInt::FastCalc->_is_zero([123,123]); },
#  xs_zero => sub { Math::BigInt::FastCalc->_zero(); },
#  xs_one => sub { Math::BigInt::FastCalc->_one(); },
#  xs_two => sub { Math::BigInt::FastCalc->_two(); },
  xs_len => sub { Math::BigInt::FastCalc->_len([123,123,123]); },
  }, );

exit;

#print "short (1):\n";
#timethese ( -3,
#  {
#  mbi => sub { $xi->copy(); },
#  mbf => sub { $xf->copy(); },
#  lite => sub { $xl->copy(); },
#  rat => sub { $xr->copy(); },
#  calc => sub { Math::BigInt::Calc->_copy($array); },
#  xsfast => sub { Math::BigInt::FastCalc->_copy($array); },
#  }, );

for my $n (qw/100/)
  {
  my $array = [];
  for ($i = 0; $i < $n; $i ++) { push @$array, 1111111; }

  print "long ($n):\n";
  my $str = '1111111' x $n;
  my $xi = Math::BigInt->new($str);
  print "len: ",scalar @{$xi->{value}},"\n";
  my $xf = Math::BigFloat->new($str);
  my $xr = Math::BigRat->new($str);
  my $xl = Math::BigInt::Lite->new($str);
  timethese ( -3,
    {
    mbi => sub { $xi->copy(); },
    mbf => sub { $xf->copy(); },
    rat => sub { $xr->copy(); },
    calc => sub { Math::BigInt::Calc->_copy($array); },
    calc2 => sub { Math::BigInt::Calc->_copy($xi->{value}); },
    xsfast => sub { Math::BigInt::FastCalc->_copy($array); },
    xsfast2 => sub { Math::BigInt::FastCalc->_copy($xi->{value}); },
    }, );

  }

