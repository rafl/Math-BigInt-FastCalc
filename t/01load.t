#!/usr/bin/perl -w

use strict;             # restrict unsafe constructs

use Test::More tests => 2;

BEGIN {
    use_ok('Math::BigInt::FastCalc');
    use_ok('Math::BigInt');         # Math::BigInt is required for the tests
};

diag("Testing Math::BigInt::FastCalc $Math::BigInt::FastCalc::VERSION");
diag("==> Perl $], $^X");
diag("==> Math::BigInt $Math::BigInt::VERSION");
diag("==> Math::BigInt::Calc $Math::BigInt::Calc::VERSION");
