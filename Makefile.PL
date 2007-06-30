
use strict;

# Load the Module::Install bundled in ./inc/
use inc::Module::Install;

# The name of your distribution
name		'Math-BigInt-FastCalc';

# Get most of the details from the primary module
all_from	'lib/Math/BigInt/FastCalc.pm';

requires	'perl'		=> "5.006002";
requires	'Math::BigInt'	=> 1.87;

build_requires	'Test::More'	=> 0.62;

license		'perl';

author		'Tels <nospam-abuse@bloodgate.com>';

# install this over the version in the Perl core
install_as_core;

# Generate the Makefile
WriteAll;
